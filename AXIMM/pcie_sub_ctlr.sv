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
   input            rstb_busy_ram ,

   input            clk,
   input            rst_n
) ;


wire         WrRqValid ;
wire [63:0]  WrRqAddr  ;
wire [127:0] WrRqData  ;
wire         WrRqReady ;
wire         WrRqErr   ;

wire           RdRqValid ;
wire [63:0]    RdRqAddr  ;
wire [127:0]   RdRqData  ;
wire           RdRqReady ;
wire           RdRqErr   ;


AxiRReqCtlr m_AxiRReqCtlr (
   .araddr  (ctlr_araddr  ) ,
   .arburst (ctlr_arburst ) ,
   .arid    (ctlr_arid    ) ,
   .arlen   (ctlr_arlen   ) ,
   .arready (ctlr_arready ) ,
   .arsize  (ctlr_arsize  ) ,
   .arvalid (ctlr_arvalid ) ,

   .arlock  (ctlr_arlock  ) ,
   .arprot  (ctlr_arprot  ) ,
   .arqos   (ctlr_arqos   ) ,
   .arcache (ctlr_arcache ) ,

   .rdata   (ctlr_rdata   ) ,
   .rid     (ctlr_rid     ) ,
   .rlast   (ctlr_rlast   ) ,
   .rready  (ctlr_rready  ) ,
   .rresp   (ctlr_rresp   ) ,
   .rvalid  (ctlr_rvalid  ) ,

   // Controller signals
   .RqValid (RdRqValid ) ,
   .RqAddr  (RdRqAddr  ) ,
   .RqData  (RdRqData  ) ,
   .RqReady (RdRqReady ) ,
   .RqErr   (RdRqErr   ) ,

   .clk     (clk),
   .rst_n   (rst_n)
);

AxiWReqCtlr m_AxiWReqCtlr(
   .awaddr  (ctlr_awaddr  ) ,
   .awburst (ctlr_awburst ) ,
   .awid    (ctlr_awid    ) ,
   .awlen   (ctlr_awlen   ) ,
   .awsize  (ctlr_awsize  ) ,
   .awvalid (ctlr_awvalid ) ,
   .awready (ctlr_awready ) ,

   .bid     (ctlr_bid     ) ,
   .bready  (ctlr_bready  ) ,
   .bresp   (ctlr_bresp   ) ,
   .bvalid  (ctlr_bvalid  ) ,

   .wdata   (ctlr_wdata   ) ,
   .wlast   (ctlr_wlast   ) ,
   .wstrb   (ctlr_wstrb   ) ,
   .wvalid  (ctlr_wvalid  ) ,
   .wready  (ctlr_wready  ) ,

   .awcache (ctlr_awcache ) ,
   .awprot  (ctlr_awprot  ) ,
   .awlock  (ctlr_awlock  ) ,
   .awqos   (ctlr_awqos   ) ,

   // Controller signals
   .RqValid  (WrRqValid),
   .RqAddr   (WrRqAddr ),
   .RqData   (WrRqData ),
   .RqReady  (WrRqReady),
   .RqErr    (WrRqErr  ),

   .clk     (clk),
   .rst_n  (rst_n)
);


pcie_sub_ctlr_top m_pcie_sub_ctlr_top(
   .clk       (clk  ) ,
   .rst_n     (rst_n) ,

   // Controller signals
   .RdRqValid (RdRqValid) ,
   .RdRqAddr  (RdRqAddr ) ,
   .RdRqData  (RdRqData ) ,
   .RdRqReady (RdRqReady) ,
   .RdRqErr   (RdRqErr  ) ,

   // Controller signals
   .WrRqValid (WrRqValid ) ,
   .WrRqAddr  (WrRqAddr  ) ,
   .WrRqData  (WrRqData  ) ,
   .WrRqReady (WrRqReady ) ,
   .WrRqErr   (WrRqErr   ) 
);

endmodule : pcie_sub_top




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
   output logic [127:0]   RqData   ,
   output logic           RqReady  ,
   output logic           RqErr    ,

   input                   clk,
   input                   rst_n
);


typedef enum logic[3:0] {
   IDLE  = 'b0000,
   REQ_0 = 'b0001,
   DATA  = 'b0010,
   FAULT = 'b0100 
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
            RdSt_Nxt = REQ_0 ;

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
   output logic [ 63:0  ]        awaddr  ,
   output logic [ 1:0   ]        awburst ,
   output logic [ 3:0   ]        awid    ,
   output logic [ 7:0   ]        awlen   ,
   output logic [ 2:0   ]        awsize  ,
   output logic                  awvalid ,
   input                         awready ,

   input  [ 3:0   ]              bid     ,
   output logic                  bready  ,
   input  [ 1:0   ]              bresp   ,
   input                         bvalid  ,

   output logic [ 127:0 ]        wdata   ,
   output logic                  wlast   ,
   output logic [ 15:0  ]        wstrb   ,
   output logic                  wvalid  ,
   input                         wready  ,

   output [ 3:0   ]              awcache ,
   output [ 2:0   ]              awprot  ,
   output                        awlock  ,
   output [ 3:0   ]              awqos   ,

   // Controller signals
   input                         RqValid  ,
   input        [63:0]           RqAddr   ,
   input        [127:0]          RqData   ,
   output logic                  RqReady  ,
   output logic                  RqErr    ,

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
   end else begin
      Cntr <= Cntr + 1;
   end
end

always_ff @(posedge clk) begin : proc_RqErr
   if(~rst_n) begin
      RqErr <= 0;
   end else begin
      RqErr <= RqErr_Nxt;
   end
end

always_comb begin : proc_WrSt_Nxt
   WrSt_Nxt = WrSt;

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
      default : WrSt_Nxt = WrSt;
   endcase
end


endmodule : AxiWReqCtlr



module pcie_sub_ctlr #(
   parameter  COUNTER_LEN = 6
   )(
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
   input         [31:0]    IbAddrOut ,
   input                   IbRdEn    ,

   output logic            IbDataValid,
   input                   IbRamValid,

   //Ob FIFO
   input                   ObWrEn,
   input         [31:0]    ObAddrIn,
   input         [127:0]   ObDataIn,

   input                   ObDataValid,
   output logic            ObRamValid
);


logic [31:0] IbPtrFn, IbPtrFn_Nxt ;
logic [31:0] IbPtrNxt, IbPtrNxt_Nxt ;

logic [31:0] ObPtrFn, ObPtrFn_Nxt ;
logic [31:0] ObPtrNxt, ObPtrNxt_Nxt ;



`define INIT_IB_REGION  64'h0_1000
`define NEXT_IB_REGION  64'h0
`define FINAL_IB_REGION 64'h10
`define MAX_IB          'h7

`define INIT_OB_REGION  64'h1_1000
`define NEXT_OB_REGION  64'h20
`define FINAL_OB_REGION 64'h30
`define MAX_OB          'h8

/*{COUNTER_LEN{1'b1}}*/
`define CNTR_MAX          'h20


typedef enum logic[10:0] {
   IDLE        = 'h000,
   LOAD_PTR    = 'h001,
   // WRT_PTR     = 'h002,
   WRT_FIFO    = 'h002,
   // RD_FIFO     = 'h008,
   WAIT_DONE   = 'h004,
   UPDATE_PTR  = 'h008,
   WRT_DATA    = 'h010,
   WRT_DTPTR   = 'h020,
   WAIT_WR_PTR = 'h040,
   CHK_PTR     = 'h080,
   INI_WR_DATA = 'h100
} CtlIbState ;


CtlIbState CtlIbSt, CtlIbSt_Nxt ;

logic             WrRqValid_Nxt ;
logic  [63:0]     WrRqAddr_Nxt ;
logic  [127:0]    WrRqData_Nxt ;

logic             IbDataValidNxt ;

logic [127:0]     IbDataNxt;
logic [31:0]      IbAddrNxt;
logic             IbWrEnNxt;

logic [128-1:0]   IbData  ;
logic [31:0]      IbAddr  ;
logic             IbWrEn  ;

logic             ObRdEn, ObRdEn_Nxt;
logic [31:0]      ObAddrOut, ObAddrOut_Nxt;
wire [127:0]      ObDataOut;

logic             RdRqValid_Nxt;
logic [63:0]      RdRqAddr_Nxt;

logic             ObRamValid_Nxt;


logic [COUNTER_LEN-1:0] Cntr;

always_ff @(posedge clk or negedge rst_n) begin : proc_Cntr
   if(~rst_n) begin
      Cntr <= '0;
   end else begin
      if (Cntr == `CNTR_MAX) begin
         Cntr <= '0;
      end else begin
         Cntr <= Cntr + 1 ;
      end
   end
end


always_ff @(posedge clk) begin : proc_CtlIbSt
   if(~rst_n) begin
      CtlIbSt     <= IDLE;

      IbPtrFn     <= '0;
      IbPtrNxt    <= `INIT_IB_REGION;

      ObPtrFn     <= `INIT_OB_REGION;
      ObPtrNxt    <= '0;
      
      RdRqValid   <= '0 ;
      RdRqAddr    <= '0 ;

      WrRqValid   <= '0 ;
      WrRqAddr    <= '0 ;
      WrRqData    <= '0 ;

      IbData      <= '0 ;
      IbAddr      <= '0;
      IbWrEn      <= '0;

      IbDataValid <= 0;

      ObRdEn      <= '0;
      ObAddrOut   <= '0;

   end else begin
      CtlIbSt     <= CtlIbSt_Nxt;
      
      IbPtrFn     <= IbPtrFn_Nxt  ;
      IbPtrNxt    <= IbPtrNxt_Nxt ;

      ObPtrFn     <= ObPtrFn_Nxt  ;
      ObPtrNxt    <= ObPtrNxt_Nxt ;

      RdRqValid   <= RdRqValid_Nxt ;
      RdRqAddr    <= RdRqAddr_Nxt ;

      WrRqValid   <= WrRqValid_Nxt ;
      WrRqAddr    <= WrRqAddr_Nxt ;
      WrRqData    <= WrRqData_Nxt ;

      IbData      <= IbDataNxt ;
      IbAddr      <= IbAddrNxt;
      IbWrEn      <= IbWrEnNxt ;

      IbDataValid <= IbDataValidNxt;
      ObRamValid  <= ObRamValid_Nxt;

      ObRdEn      <= ObRdEn_Nxt;
      ObAddrOut   <= ObAddrOut_Nxt;

   end
end

always_comb begin : proc_IB_Ptr
   RdRqValid_Nxt  = 1'h0;
   IbPtrFn_Nxt    = IbPtrFn ;
   IbPtrNxt_Nxt   = IbPtrNxt ;

   ObPtrFn_Nxt    = ObPtrFn;
   ObPtrNxt_Nxt   = ObPtrNxt;

   CtlIbSt_Nxt    = CtlIbSt ;

   ObRdEn_Nxt     = ObRdEn;
   ObAddrOut_Nxt  = ObAddrOut;



   WrRqData_Nxt   = WrRqData ;
   WrRqValid_Nxt  = 1'h0;
   WrRqAddr_Nxt   = WrRqAddr ;

   RdRqAddr_Nxt   = RdRqAddr ;

   IbWrEnNxt      = 0;
   IbAddrNxt      = IbAddr;
   IbDataNxt      = IbData;

   IbDataValidNxt = 0;

   ObRamValid_Nxt = 1;

   case (CtlIbSt)
      IDLE: begin
         if (Cntr == `CNTR_MAX ) begin
            CtlIbSt_Nxt = LOAD_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `FINAL_IB_REGION;
         end
      end
      LOAD_PTR: begin
         if (RdRqReady & ~RdRqErr) begin
            IbPtrFn_Nxt = RdRqData[31:0] ;

            if (IbPtrFn_Nxt[15:12] != IbPtrNxt[15:12]) begin
               CtlIbSt_Nxt = WRT_FIFO;

               //
               RdRqValid_Nxt = 1;
               RdRqAddr_Nxt  = IbPtrNxt;

               // FIFO interface
               IbAddrNxt = '1;
            end else begin
               CtlIbSt_Nxt = IDLE;

               //
               RdRqValid_Nxt = 0;
            end
         end
         else /*if (RdRqReady & RdRqErr)*/ begin
            CtlIbSt_Nxt = LOAD_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `FINAL_IB_REGION;
         end /*else begin
            CtlIbSt_Nxt = CtlIbSt ;
         end*/
      end
      WRT_FIFO :begin
         if (RdRqReady & ~RdRqErr) begin
            IbDataNxt = RdRqData[127:0] ;
            IbAddrNxt = IbAddr + 1;
            IbWrEnNxt   = 1;

            if (IbAddrNxt == 32'h64) begin// 100
               CtlIbSt_Nxt = UPDATE_PTR;

               //
               WrRqValid_Nxt = 1;
               WrRqAddr_Nxt  = `NEXT_IB_REGION;

               if (IbPtrNxt[15:12] == 4'h7) begin
                  WrRqData_Nxt[15:12] = 4'h0;
               end else begin
                  WrRqData_Nxt[15:12] = IbPtrNxt[15:12] + 4'h1;
               end

               RdRqValid_Nxt = 0;

            end else begin
               CtlIbSt_Nxt = WRT_FIFO;

               RdRqValid_Nxt = 1;
               RdRqAddr_Nxt  = IbPtrNxt + 64'h10;
            end
         end else begin
            CtlIbSt_Nxt = WRT_FIFO;

            IbDataNxt = IbData;
            IbAddrNxt = IbAddr;
            IbWrEnNxt = 0;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = IbPtrNxt ;
         end
      end
      UPDATE_PTR : begin
         if (WrRqReady  & ~WrRqErr) begin
            CtlIbSt_Nxt = WAIT_DONE;
            WrRqValid_Nxt = 0;

            if (IbPtrNxt[15:12] == 4'h7) begin
               IbPtrNxt_Nxt = `INIT_IB_REGION;
            end else begin
               IbPtrNxt_Nxt[15:12] = IbPtrNxt[15:12] + 4'h1;
               IbPtrNxt_Nxt[11:0]  = '0;
            end
         end
         /*else if (WrRqReady  & WrRqErr) begin
            CtlIbSt_Nxt = UPDATE_PTR;

            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = `NEXT_IB_REGION;

            IbPtrNxt_Nxt = IbPtrNxt ;

            if (IbPtrNxt[15:12] == 8'h7) begin
               WrRqData_Nxt[15:12] = 8'h0;
            end else begin
               WrRqData_Nxt[15:12] = IbPtrNxt[15:12] + 8'h1;
            end
         end */else begin
            CtlIbSt_Nxt = UPDATE_PTR;

            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = `NEXT_IB_REGION;

            IbPtrNxt_Nxt = IbPtrNxt ;
            if (IbPtrNxt[15:12] == 4'h7) begin
               WrRqData_Nxt[15:12] = 4'h0;
            end else begin
               WrRqData_Nxt[15:12] = IbPtrNxt[15:12] + 4'h1;
            end
         end
      end
      WAIT_DONE: begin
         if (IbRamValid & ObDataValid) begin
            CtlIbSt_Nxt = CHK_PTR;

            IbDataValidNxt = 0;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `NEXT_OB_REGION;

            ObRamValid_Nxt = 0;
         end else begin
            RdRqValid_Nxt  = 0;

            IbDataValidNxt = 1;
            ObRamValid_Nxt = 1;
         end
      end
      WAIT_WR_PTR: begin
         ObRamValid_Nxt = 0;

         if (Cntr == `CNTR_MAX  ) begin
            CtlIbSt_Nxt = CHK_PTR;

            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `NEXT_OB_REGION;

            ObRdEn_Nxt = 1;
            ObAddrOut_Nxt = 0;
         end else begin
            RdRqValid_Nxt = 0;
            RdRqAddr_Nxt  = RdRqAddr ;

            ObRdEn_Nxt = 0;
            ObAddrOut_Nxt = 0;
         end
      end
      CHK_PTR: begin
         ObRamValid_Nxt = 0;

         if (RdRqReady & ~RdRqErr) begin
            RdRqValid_Nxt = 0;
            RdRqAddr_Nxt  = '0;

            if (RdRqData[15:12] == 4'h0 && ObPtrFn[15:12] == `MAX_OB || 
                  ObPtrFn[15:12] + 4'h1 == RdRqData[15:12]
               ) begin // wait for writing
               CtlIbSt_Nxt = WAIT_WR_PTR ;

               ObRdEn_Nxt = 1;
               ObAddrOut_Nxt = 0;
            end else begin
               CtlIbSt_Nxt = INI_WR_DATA;

               ObRdEn_Nxt = 1;
               ObAddrOut_Nxt = 32'h0;
            end

         end else begin
            RdRqValid_Nxt = 1;
            RdRqAddr_Nxt  = `NEXT_OB_REGION;

            ObRdEn_Nxt = 0;
            ObAddrOut_Nxt = 0;
         end
      end
      INI_WR_DATA: begin
         ObRamValid_Nxt = 0;

         WrRqValid_Nxt  = 0;
         WrRqData_Nxt   = ObDataOut;

         WrRqAddr_Nxt[63:0] = {32'h0, ObPtrFn[31:0]};

         CtlIbSt_Nxt    = WRT_DATA;

         ObRdEn_Nxt     = 1;
         ObAddrOut_Nxt  = ObAddrOut + 32'h1;
      end
      WRT_DATA: begin
         ObRamValid_Nxt = 0;

         if (WrRqReady & ~WrRqErr) begin
            if (ObAddrOut == 'h64) begin // 100
               CtlIbSt_Nxt   = WRT_DTPTR;

               ObRdEn_Nxt    = 0;
               ObAddrOut_Nxt = 0;

               WrRqValid_Nxt = 1;
               WrRqAddr_Nxt  = `FINAL_OB_REGION;
               if (ObPtrFn[15:12] == `MAX_OB) begin
                  WrRqData_Nxt = '0;
               end else begin
                  WrRqData_Nxt[15:12] = ObPtrFn[15:12] + 4'h1;
               end
            end else begin
               ObRdEn_Nxt    = 1;
               ObAddrOut_Nxt = ObAddrOut + 32'h1;
               WrRqValid_Nxt = 1;
               WrRqAddr_Nxt  = WrRqAddr + 64'h10;
               WrRqData_Nxt  = ObDataOut;
            end
         end else begin
            ObRdEn_Nxt    = 0;
            ObAddrOut_Nxt = ObAddrOut;
            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = WrRqAddr;
            WrRqData_Nxt  = WrRqData;
         end
      end
      WRT_DTPTR: begin
         ObRamValid_Nxt = 0;

         if (WrRqReady & ~WrRqErr) begin
            WrRqValid_Nxt =  0;
            WrRqAddr_Nxt  = '0;
            WrRqData_Nxt  = '0;

            CtlIbSt_Nxt   = IDLE;

            if (ObPtrFn[15:12] == `MAX_OB) begin
               ObPtrFn_Nxt = `INIT_OB_REGION;
            end else begin
               ObPtrFn_Nxt[15:12] = ObPtrFn[15:12] + 4'h1;
               ObPtrFn_Nxt[11:0]  = '0;
            end
         end else begin
            WrRqValid_Nxt = 1;
            WrRqAddr_Nxt  = `FINAL_OB_REGION;
            if (ObPtrFn[15:12] == `MAX_OB) begin
               WrRqData_Nxt = '0;
            end else begin
               WrRqData_Nxt[15:12] = ObPtrFn[15:12] + 'h1;
            end
         end
      end
      default : CtlIbSt_Nxt = CtlIbSt;
   endcase
end



////////////////////
// RAM

ram m_ram_Ib_0 (
   .WrEn   ( IbWrEn    ) ,
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

   .WrEn   ( ObWrEn    ) ,
   .WrAddr ( ObAddrIn  ) ,
   .WrData ( ObDataIn  ) ,

   .RdEn   ( ObRdEn    ) ,
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
   input                   WrRqErr   
);


// Ib FIFO
wire [127:0]   IbDataOut  ;
wire [31:0]    IbAddrOut  ;
wire           IbRdEn     ;

wire           IbDataValid ;
wire           IbRamValid ;


//Ob FIFO
wire            ObWrEn ;
wire  [31:0]    ObAddrIn ;
wire  [127:0]   ObDataIn ;

wire            ObDataValid ;
wire            ObRamValid ;


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
.ObWrEn      ( ObWrEn      ) ,
.obSRAMValid ( ObRamValid  ) ,
.obDataValid ( ObDataValid ) ,
.ob_wr_addr  ( ObAddrIn    ) ,
.ob_wr_data  ( ObDataIn    )
);






endmodule : pcie_sub_ctlr_top