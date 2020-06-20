module top (
   input                   clk       ,
   input                   rst_n     ,

   // Controller signals
   output logic            RdRqValid ,
   output logic  [63:0]    RdRqAddr  ,
   input         [127:0]   w_RdRqData  ,
   input                   w_RdRqReady ,
   input                   w_RdRqErr   ,

   // Controller signals
   output logic            WrRqValid ,
   output logic  [63:0]    WrRqAddr  ,
   output logic  [127:0]   WrRqData  ,
   input                   w_WrRqReady ,
   input                   w_WrRqErr   ,

   // Ib FIFO
   output        [127:0]   IbDataOut ,
   input         [31:0]    w_IbAddrOut ,
   input                   w_IbRdEn    ,

   output logic            IbDataValid,
   input                   w_IbRamValid,


   //Ob FIFO
   input                   w_ObWrEn,
   input         [31:0]    w_ObAddrIn,
   input         [127:0]   w_ObDataIn,

   input                   w_ObDataValid,
   output logic            ObRamValid
);

logic [127:0]   RdRqData    ;
logic           RdRqReady   ;
logic           RdRqErr     ;
logic           WrRqReady   ;
logic           WrRqErr     ;
logic [31:0]    IbAddrOut   ;
logic           IbRdEn      ;
logic           IbRamValid  ;
logic           ObWrEn      ;
logic [31:0]    ObAddrIn    ;
logic [127:0]   ObDataIn    ;
logic           ObDataValid ;

always_ff @(posedge clk or negedge rst_n) begin : proc_
   if(~rst_n) begin
      RdRqData    <= 0;
      RdRqReady   <= 0;
      RdRqErr     <= 0;
      WrRqReady   <= 0;
      WrRqErr     <= 0;
      IbAddrOut   <= 0;
      IbRdEn      <= 0;
      IbRamValid  <= 0;
      ObWrEn      <= 0;
      ObAddrIn    <= 0;
      ObDataIn    <= 0;
      ObDataValid <= 0;
   end else begin
      RdRqData    <= w_RdRqData    ;
      RdRqReady   <= w_RdRqReady   ;
      RdRqErr     <= w_RdRqErr     ;
      WrRqReady   <= w_WrRqReady   ;
      WrRqErr     <= w_WrRqErr     ;
      IbAddrOut   <= w_IbAddrOut   ;
      IbRdEn      <= w_IbRdEn      ;
      IbRamValid  <= w_IbRamValid  ;
      ObWrEn      <= w_ObWrEn      ;
      ObAddrIn    <= w_ObAddrIn    ;
      ObDataIn    <= w_ObDataIn    ;
      ObDataValid <= w_ObDataValid ;
   end
end






pcie_sub_ctlr #(
   .COUNTER_LEN (6)
   ) m_pcie_sub_ctlr (
   .clk         ( clk  ) ,
   .rst_n       ( rst_n) ,

   // Controller signals
   .RdRqValid   ( RdRqValid ) ,
   .RdRqAddr    ( RdRqAddr  ) ,
   .RdRqData    ( RdRqData  ) ,
   .RdRqReady   ( RdRqReady ) ,
   .RdRqErr     ( RdRqErr   ) ,

   // Controller signals
   .WrRqValid   ( WrRqValid  ) ,
   .WrRqAddr    ( WrRqAddr   ) ,
   .WrRqData    ( WrRqData   ) ,
   .WrRqReady   ( WrRqReady  ) ,
   .WrRqErr     ( WrRqErr    ) ,

   // Ib FIFO
   .IbDataOut   ( IbDataOut   ) ,
   .IbAddrOut   ( IbAddrOut   ) ,
   .IbRdEn      ( IbRdEn      ) ,

   .IbDataValid ( IbDataValid ) ,
   .IbRamValid  ( IbRamValid  ) ,


   //Ob FIFO
   .ObWrEn      ( ObWrEn      ) ,
   .ObAddrIn    ( ObAddrIn    ) ,
   .ObDataIn    ( ObDataIn    ) ,

   .ObDataValid ( ObDataValid ) ,
   .ObRamValid  ( ObRamValid  )
);

endmodule