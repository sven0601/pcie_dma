`timescale 1ns/100ps


module top_tb #(
   parameter T=20
   )();

logic clk, rst_n;

logic            RdRqValid   ;
logic  [63:0]    RdRqAddr    ;
logic  [127:0]   RdRqData    ;
logic            RdRqReady   ;
logic            RdRqErr     ;

logic            WrRqValid   ;
logic  [63:0]    WrRqAddr    ;
logic  [127:0]   WrRqData    ;
logic            WrRqReady   ;
logic            WrRqErr     ;

logic  [127:0]   IbDataOut   ;
logic  [31:0]    IbAddrOut   ;
logic            IbRdEn      ;
logic            IbDataValid ;
logic            IbRamValid  ;
//Ob FIFO
logic            ObWrEn      ;
logic [31:0]     ObAddrIn    ;
logic [127:0]    ObDataIn    ;
logic            ObDataValid ;
logic            ObRamValid  ;



top_gcm_aes_128 m_crypto (
   .clk            ( clk         ),
   .rstn           ( rst_n       ),
   .ibDataValid    ( IbDataValid ),
   .ibSRAMValid    ( IbRamValid  ),
   .ib_rd_data     ( IbDataOut   ),
   .ib_rd_addr     ( IbAddrOut   ),
   .ib_rd_en       ( IbRdEn      ),

   .obSRAMValid    ( ObRamValid  ),
   .obDataValid    ( ObDataValid ),
   .ob_wr_en       ( ObWrEn      ),
   .ob_wr_addr     ( ObAddrIn    ),
   .ob_wr_data     ( ObDataIn    )
);



pcie_sub_ctlr #(
   .COUNTER_LEN (6)
   ) m_pcie_sub_ctlr (
   .clk         ( clk         ) ,
   .rst_n       ( rst_n       ) ,

   // Controller signals
   .RdRqValid   ( RdRqValid   ) ,
   .RdRqAddr    ( RdRqAddr    ) ,
   .RdRqData    ( RdRqData    ) ,
   .RdRqReady   ( RdRqReady   ) ,
   .RdRqErr     ( RdRqErr     ) ,

   // Controller signals
   .WrRqValid   ( WrRqValid   ) ,
   .WrRqAddr    ( WrRqAddr    ) ,
   .WrRqData    ( WrRqData    ) ,
   .WrRqReady   ( WrRqReady   ) ,
   .WrRqErr     ( WrRqErr     ) ,

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


initial begin

   wait(RdRqValid == 1 && clk === 0) ;
   #(T*2);
   RdRqReady = 1;
   RdRqData  = 128'h2000;
   wait(clk === 0);

   #(T*2);
   RdRqData = 0;
   repeat(30) begin
      wait(m_pcie_sub_ctlr.CtlIbSt == m_pcie_sub_ctlr.WRT_FIFO);
      wait(clk === 0);
      RdRqData += 'h2;
      #(T);
   end
   
   wait(m_pcie_sub_ctlr.CtlIbSt == m_pcie_sub_ctlr.UPDATE_PTR);
   wait(clk === 0);   
   #T;
   WrRqReady = 1;
   WrRqErr   = 0;
   #T;
   WrRqReady = 0;

   wait(m_pcie_sub_ctlr.CtlIbSt == m_pcie_sub_ctlr.WAIT_DONE);
   wait(IbDataValid === 1);
   wait(clk === 0);

   for (int i=0; i<200; ++i) begin
      m_pcie_sub_ctlr.m_ram_Ob_0.mem[i] = i*2;
   end

   // #(3*T);
   // IbRamValid = 1; ObDataValid = 1;



   #(T*1000);
   $finish;
end

always @(m_pcie_sub_ctlr.WrRqAddr) begin
   if (m_pcie_sub_ctlr.WrRqAddr == '0) begin
      $display("Write Next Rd Ptr [%0x], %0t", m_pcie_sub_ctlr.WrRqData, $realtime());
   end
end

initial begin
   clk = 0;
   rst_n = 0;

   RdRqReady = 0;
   RdRqData = 0;
   RdRqErr = 0;

   WrRqReady = 0;
   WrRqErr = 0;

   IbRamValid = 0; ObDataValid = 0;
   


   #(T*10);
   rst_n = 1;
end
always #(T/2) clk++;


endmodule