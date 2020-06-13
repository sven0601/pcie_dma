module pcie_sub_top (
   output [ 63:0  ] ctlr_araddr,
   output [ 1:0   ] ctlr_arburst,
   output [ 3:0   ] ctlr_arcache,
   output [ 3:0   ] ctlr_arid,
   output [ 7:0   ] ctlr_arlen,
   output           ctlr_arlock,
   output [ 2:0   ] ctlr_arprot,
   output [ 3:0   ] ctlr_arqos,
   input            ctlr_arready,
   output [ 2:0   ] ctlr_arsize,
   output           ctlr_arvalid,

   output [ 63:0  ] ctlr_awaddr,
   output [ 1:0   ] ctlr_awburst,
   output [ 3:0   ] ctlr_awcache,
   output [ 3:0   ] ctlr_awid,
   output [ 7:0   ] ctlr_awlen,
   output           ctlr_awlock,
   output [ 2:0   ] ctlr_awprot,
   output [ 3:0   ] ctlr_awqos,
   input            ctlr_awready,
   output [ 2:0   ] ctlr_awsize,
   output           ctlr_awvalid,

   input  [ 3:0   ] ctlr_bid,
   output           ctlr_bready,
   input  [ 1:0   ] ctlr_bresp,
   input            ctlr_bvalid,

   input  [ 127:0 ] ctlr_rdata,
   input  [ 3:0   ] ctlr_rid,
   input            ctlr_rlast,
   output           ctlr_rready,
   input  [ 1:0   ] ctlr_rresp,
   input            ctlr_rvalid,

   output [ 127:0 ] ctlr_wdata,
   output           ctlr_wlast,
   input            ctlr_wready,
   output [ 15:0  ] ctlr_wstrb,
   output           ctlr_wvalid,

   input            rsta_busy_csr,
   input            rsta_busy_ram,
   input            rstb_busy_csr,
   input            rstb_busy_ram 
) ;



endmodule : pcie_sub_ctlr




module AxiRReqCtlr (
   output logic [ 63:0  ] araddr  ,
   output logic [ 1:0   ] arburst ,
   output logic [ 3:0   ] arid    ,
   output logic [ 7:0   ] arlen   ,
   input                  arready ,
   output logic [ 2:0   ] arsize  ,
   output logic           arvalid ,

   output logic           arlock  ,
   output logic [ 2:0   ] arprot  ,
   output logic [ 3:0   ] arqos   ,
   output logic [ 3:0   ] arcache ,

   input        [ 127:0 ] rdata   ,
   input        [ 3:0   ] rid     ,
   input                  rlast   ,
   output logic           rready  ,
   input        [ 1:0   ] rresp   ,
   input                  rvalid  ,

   // Controller signals
   input                  RqValid  ,
   input        [63:0]    RqAddr   ,
   input        [127:0]   RqData   ,
   output logic           RqReady  ,
   output logic           RqErr    ,

   input                   clk,
   input                   rst_n

);


typedef enum logic[3:0] {
   IDLE  = 'h0000,
   REQ_0 = 'h0001,
   DATA  = 'h0010,
   FAULT = 'h0100 
} RdState;

RdState RdSt, RdSt_Nxt ;


assign arqos   = 4'h0;
assign arcache = 4'h0;
assign arprot  = 3'h2;
assign arlock  = 1'h0;

always_ff @(posedge clk or negedge rst_n) begin : proc_RdSt
   if(~rst_n) begin
      RdSt <= IDLE;
   end else begin
      RdSt <= RdSt_Nxt;
   end
end

always_comb begin : proc_RdSt_Nxt
   RdSt_Nxt = RdSt ;

   arvalid  = 1'h0 ;
   araddr   = 0    ;
   arburst  = 2'h1 ;
   arid     = 4'h0 ;
   arlen    = 8'h0 ;
   arsize   = 3'h2 ;
   arvalid  = 0    ;

   rready   = 1'h0 ;

   RqReady  = 1'h0 ;
   RqErr    = 1'h0 ;
   case (RdSt)
      IDLE: begin
         if (RqValid) begin
            RdSt_Nxt = REQ ;

            araddr   = RqAddr ;
            arvalid  = 1'h1   ;
         end
      end
      REQ_0:  begin
         if (arready & arvalid) begin
            RdSt_Nxt = DATA;

            rready   = 1'h1 ;
         end else begin
            arvalid = 1;
         end
      end
      DATA: begin
         if (rvalid & rready) begin
            if (rresp == 2'h0) begin
               RdSt_Nxt = IDLE;
            end else begin
               RdSt_Nxt = FAULT;
               RqErr = 1'h1;
            end

            RqData   = rdata ;
            RqReady  = 1'h1;
         end else begin
            rready = 1;
         end
      end
      FAULT: begin
         RdSt_Nxt = IDLE;
      end
      default : begin
         RdSt_Nxt = RdSt ;
      end
   endcase

end

endmodule : AxiRReqCtlr


module AxiWReqCtlr (
   input                   clk     ,
   input                   rst_n   ,

   output logic [ 63:0  ]        awaddr  ,
   output logic [ 1:0   ]        awburst ,
   output logic [ 3:0   ]        awid    ,
   output logic [ 7:0   ]        awlen   ,
   output logic [ 2:0   ]        awsize  ,
   output logic                  awvalid ,
   input                   awready ,

   input  [ 3:0   ]        bid     ,
   output                  bready  ,
   input  [ 1:0   ]        bresp   ,
   input                   bvalid  ,

   output logic [ 127:0 ]        wdata   ,
   output logic                  wlast   ,
   output logic [ 15:0  ]        wstrb   ,
   output logic                  wvalid  ,
   input                   wready  ,

   output [ 3:0   ]        awcache ,
   output [ 2:0   ]        awprot  ,
   output                  awlock  ,
   output [ 3:0   ]        awqos   ,

   // Controller signals
   input                  RqValid  ,
   input        [63:0]    RqAddr   ,
   input        [127:0]   RqData   ,
   output logic           RqReady  ,
   output logic           RqErr    ,

   input                   clk     ,
   input                   rst_n

   
);

assign awqos   = 4'h0;
assign awcache = 4'h0;
assign awprot  = 3'h2;
assign awlock  = 1'h0;


typedef enum logic[3:0] {
   IDLE  = 'h0,
   REQ_0 = 'h1,
   WDATA = 'h2,
   ADDR  = 'h4,
   RESP  = 'h8 
} WrState;

WrState WrSt, WrSt_Nxt ;


logic [3:0] Cntr ;
logic RqErr_Nxt ;




always_ff @(posedge clk) begin : proc_St
   if(~rst_n) begin
      WrSt <= IDLE;
   end else begin
      WrSt <= WrSt_Nxt ;
   end
end

always_ff @(posedge clk) begin : proc_Cntr
   if(~rst_n) begin
      Cntr <= '0 ;
   end else if(clk_en) begin
      Cntr <= Cntr + 1;
   end
end

always_ff @(posedge clk) begin : proc_RqErr
   if(~rst_n) begin
      RqErr <= 0;
   end else if(clk_en) begin
      RqErr <= RqErr_Nxt;
   end
end

always_comb begin : proc_WrSt_Nxt
   WrSt_Nxt = WrSt

   RqErr_Nxt = RqErr;
   RqReady = 1'h0;

   awaddr  = RqAddr;
   awvalid = 1'h0 ;
   awid    = '0 ;
   awlen   = '0 ;  // 1
   awsize  = 3'h4; // 16
   awburst = 2'h1;

   wdata   = RqData;
   wstrb   = '0;
   wlast   = 1'h0 ;
   wvalid  = 1'h0 ;
   bready  = 1'b0 ;
   case (WrSt)
      IDLE: begin
         if (RqValid) begin
            WrSt_Nxt = REQ_0;

            // Addr
            awaddr  = RqAddr;
            awvalid = 1'h1;

            // Data
            wdata  = RqData;
            wstrb  = '1;
            wlast  = 1'b1 ;
            wvalid = 1'b1 ;
         end
      end
      REQ_0: begin
         case ({awready, wready})
            2'h0: begin
               WrSt_Nxt = WrSt ;
               // Addr
               awaddr  = RqAddr;
               awvalid = 1'h1;

               // Data
               wdata  = RqData;
               wstrb  = '1;
               wlast  = 1'b1 ;
               wvalid = 1'b1 ;
            end
            2'h1: begin
               WrSt_Nxt = ADDR;

               awaddr  = RqAddr;
               awvalid = 1'h1;

               wlast  = 1'b0 ;
               wvalid = 1'b0 ;
            end
            2'h2: begin
               WrSt_Nxt = WDATA;

               awvalid = 1'h0;

               wdata    = RqData;
               wvalid   = 1'b1 ;
               wlast    = 1'b1 ;
               wstrb    = '1;
            end
            2'h3: begin
               WrSt_Nxt = RESP;

               awvalid = 1'h0;

               wlast  = 1'b0 ;
               wvalid = 1'b0 ;

               bready = 1'h1;
            end
         endcase
      end
      WDATA : begin
         if (wready) begin
            WrSt_Nxt = RESP;

            awvalid  = 1'h0;
            wlast    = 1'b0;
            wvalid   = 1'b0;

            bready   = 1'h1;
         end else begin
            WrSt_Nxt = WrSt;

            awvalid = 1'h0;

            wdata    = RqData;
            wvalid   = 1'b1 ;
            wlast    = 1'b1 ;
            wstrb    = '1;
         end
      end
      ADDR : begin
         if (awready) begin
            WrSt_Nxt = RESP;

            awvalid  = 1'h0;
            wlast    = 1'b0;
            wvalid   = 1'b0;

            bready   = 1'h1;
         end else begin
            WrSt_Nxt = WrSt;

            awaddr  = RqAddr;
            awvalid = 1'h1;

            wlast  = 1'b0 ;
            wvalid = 1'b0 ;
         end
      end
      RESP : begin
         if (bvalid) begin
            WrSt_Nxt = IDLE;
            bready   = 1'b0 ;

            RqErr_Nxt = (bresp != 2'h0) ? 1'h1 : 1'h0;
            RqReady   = 1'h1 ;
         end else begin
            WrSt_Nxt = WrSt;

            bready   = 1'h1;
         end
      end
      default : WrSt_Nxt = WrSt
   endcase
end


endmodule : AxiWReqCtlr



module pcie_sub_ctlr (
   input                   clk       ,
   input                   rst_n     ,

   // Controller signals
   output logic            RdRqValid ,
   output logic  [63:0]    RdRqAddr  ,
   input         [127:0]   RdRqData  ,
   input                   RdRqReady ,
   input                   RdRqErr   ,

   // Controller signals
   output logic            WrRqValid ,
   output logic  [63:0]    WrRqAddr  ,
   output logic  [127:0]   WrRqData  ,
   input                   WrRqReady ,
   input                   WrRqErr   ,

   // Ib FIFO
   output        [127:0]   IbDataOut ,
   input         [7:0]     IbAddrOut ,
   input                   IbRdEn    ,

   input                   ob_wr_en,
   input         [7:0]     ObAddr,
   input         [127:0]   ObData,

   output logic            IbDataValid,
   input                   IbRamValid,

);


logic [31:0] IbPtrFn, IbPtrFn_Nxt ;
logic [31:0] IbPtrNxt, IbPtrNxt_Nxt ;

logic [31:0] ObPtrFn ;
logic [31:0] ObPtrNxt ;


`define NEXT_IB_REGION  64'h0
`define FINAL_IB_REGION 64'h10

`define NEXT_OB_REGION  64'h20
`define FINAL_OB_REGION 64'h30

typedef enum logic[3:0] {
   IDLE     = 'h0,
   LOAD_PTR = 'h1,
   WRT_PTR  = 'h2,
   WRT_FIFO = 'h4,
   RD_FIFO  = 'h8,
   WAIT_DONE = 'h10
} CtlIbState ;

CtlIbState CtlIbSt, CtlIbSt_Nxt ;


logic          WrRqValid_Nxt ;
logic  [63:0]  WrRqAddr_Nxt ;
logic  [127:0] WrRqData_Nxt ;


logic IbDataValidNxt;



logic [127:0]  IbDataNxt;
logic [7:0]    IbAddrNxt;
logic          FFWrEnNxt;

logic [128-1:0]  IbData  ,
logic [7:0]      IbAddr  ,
logic            ib_wr_ena  ,




always_ff @(posedge clk) begin : proc_CtlIbSt
   if(~rst_n) begin
      CtlIbSt  <= LOAD_PTR;

      IbPtrFn  <= '0;
      IbPtrNxt <= '0;
      
      RdRqValid <= '0 ;
      RdRqAddr  <= '0 ;

      WrRqValid <= '0 ;
      WrRqAddr  <= '0 ;
      WrRqData  <= '0 ;

      IbData    <= '0 ;
      IbAddr    <= '0;
      ib_wr_ena    <= '0;

      IbDataValid <= 0;
   end else begin
      CtlIbSt   <= CtlIbSt_Nxt;
      
      IbPtrFn   <= IbPtrFn_Nxt  ;
      IbPtrNxt  <= IbPtrNxt_Nxt ;

      RdRqValid <= RdRqValid_Nxt ;
      RdRqAddr  <= RdRqAddr_Nxt ;

      WrRqValid <= WrRqValid_Nxt ;
      WrRqAddr  <= WrRqAddr_Nxt ;
      WrRqData  <= WrRqData_Nxt ;

      IbData    <= IbDataNxt ;
      IbAddr    <= IbAddrNxt;
      ib_wr_ena    <= FFWrEnNxt ;

      IbDataValid <= IbDataValidNxt;
   end
end

always_comb begin : proc_IB_Ptr
   RdRqValid_Nxt  = 1'h0;
   IbPtrFn_Nxt    = IbPtrFn ;
   IbPtrNxt_Nxt   = IbPtrNxt ;
   CtlIbSt_Nxt    = CtlIbSt ;

   WrRqData_Nxt   = WrRqData ;
   WrRqValid_Nxt  = 1'h0;
   WrRqAddr_Nxt   = WrRqAddr ;

   RdRqAddr_Nxt   = RdRqAddr ;


   FFWrEnNxt        = 0;
   IbAddrNxt      = IbAddr;
   IbDataNxt      = IbData;

   IbDataValid    = 0;

   case (CtlIbSt)
      IDLE: begin
         CtlIbSt_Nxt = LOAD_PTR;

         RdRqValid_Nxt = 1;
         RdRqAddr_Nxt  = `FINAL_IB_REGION;
      end
      LOAD_PTR: begin
         if (RdRqReady & ~RdRqErr) begin
            IbPtrFn_Nxt = RdRqData[31:0] ;

            if (IbPtrFn_Nxt != IbPtrNxt) begin
               CtlIbSt_Nxt = WRT_FIFO;

               //
               RdRqValid_Nxt = 1;
               RdRqAddr_Nxt  = IbPtrNxt;
            end else begin
               CtlIbSt_Nxt = IDLE;
            end
         end
         else if (RdRqReady & RdRqErr) begin
            CtlIbSt_Nxt = IDLE;
         end else begin
            CtlIbSt_Nxt = CtlIbSt ;
         end
      end
      WRT_FIFO :begin
         if (RdRqReady & ~RdRqErr) begin
            IbDataNxt = RdRqData[31:0] ;
            IbAddrNxt = IbAddr + 1;
            FFWrEnNxt   = 1;

            if (IbDataNxt == 'h63) begin// 99
               CtlIbSt_Nxt = WAIT_DONE;
            end else begin
               CtlIbSt_Nxt = WRT_FIFO;

               RdRqValid_Nxt = 1;
               RdRqAddr_Nxt  = IbPtrNxt + 'h4;
            end
         end else begin
            CtlIbSt_Nxt = WRT_FIFO;

            IbDataNxt = IbData;
            IbAddrNxt = IbAddr;
            FFWrEnNxt   = 0;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = IbPtrNxt ;
         end
      end
      WAIT_DONE: begin
         IbDataValidNxt = 1;
      end
      default : CtlIbSt_Nxt = CtlIbSt;
   endcase
end

////////////////////
// RAM

ram m_ram_Ib_0 (
   .WrEn   ( ib_wr_ena ) ,
   .WrAddr ( IbAddr    ) ,
   .WrData ( IbData    ) ,
   .RdEn   ( IbRdEn    ) ,
   .RdAddr ( IbAddrOut ) ,
   .RdData ( IbDataOut ) ,

   .clk    ( clk       ) ,
   .rst_n  ( rst_n     )
) ;


ram m_ram_Ob_0 (
   .clk    ( clk       ) ,
   .rst_n  ( rst_n     ) ,
   .WrEn   ( ob_wr_en  ) ,
   .WrAddr ( ObAddr    ) ,
   .WrData ( ObData    ) ,
   .RdAddr ( ObAddrOut ) ,
   .RdData ( ObDataOut )
);



endmodule : pcie_sub_ctlr



module pcie_sub_ctlr_top (
   input                   clk       ,
   input                   rst_n     ,

   // Controller signals
   output logic            RdRqValid ,
   output logic  [63:0]    RdRqAddr  ,
   input         [127:0]   RdRqData  ,
   input                   RdRqReady ,
   input                   RdRqErr   ,

   // Controller signals
   output logic            WrRqValid ,
   output logic  [63:0]    WrRqAddr  ,
   output logic  [127:0]   WrRqData  ,
   input                   WrRqReady ,
   input                   WrRqErr   ,
);


wire   IbDataOut  ;
wire   IbAddrOut  ;

wire   IbDataValid ;
wire   IbRamValid ;


wire           ob_wr_en;
wire [7:0]     ObAddr;
wire [127:0]   ObData;


pcie_sub_ctlr m_pcie_sub_ctlr (
   .clk         (clk      ) ,
   .rst_n       (rst_n    ) ,

   .RdRqValid   (RdRqValid) ,
   .RdRqAddr    (RdRqAddr ) ,
   .RdRqData    (RdRqData ) ,
   .RdRqReady   (RdRqReady) ,
   .RdRqErr     (RdRqErr  ) ,

   .WrRqValid   (WrRqValid) ,
   .WrRqAddr    (WrRqAddr ) ,
   .WrRqData    (WrRqData ) ,
   .WrRqReady   (WrRqReady) ,
   .WrRqErr     (WrRqErr  ) ,

   .IbDataOut   (IbDataOut) ,
   .IbAddrOut   (IbAddrOut) ,
   .IbRdEn      (IbRdEn)

   .ob_wr_en    (ob_wr_en) ,
   .ObAddr      (ObAddr  ) ,
   .ObData      (ObData  ) ,

   .IbDataValid (IbDataValid) ,
   .IbRamValid  (IbRamValid) ,
);


top_gcm_aes_128 m_top_gcm_aes_128_0(
.clk         ( clk         ) ,
.rstn        ( rst_n       ) ,
.encrypt_ena ( 1           ) ,
.ibSRAMValid ( IbRamValid  ) ,
.ibDataValid ( IbDataValid ) ,
.ib_rd_en    ( IbRdEn      ) ,
.ib_rd_data  ( IbDataOut   ) ,
.ib_rd_addr  ( IbAddrOut   ) ,
// output
.obSRAMValid ( ) ,
.obDataValid ( ) ,
.ob_wr_en    ( ) ,
.ob_wr_addr  ( ) ,
.ob_wr_data  ( )
);






endmodule : pcie_sub_ctlr_top