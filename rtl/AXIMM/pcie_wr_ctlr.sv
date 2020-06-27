
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


// logic [3:0] Cntr ;
logic RqErr_Nxt ;

logic [63:0]   awaddr_Nxt ;
logic [127:0]  wdata_Nxt ;
logic          wlast_Nxt, wvalid_Nxt, awvalid_Nxt, bready_Nxt;




always_ff @(posedge clk) begin : proc_St
   if(~rst_n) begin
      WrSt <= IDLE;
   end else begin
      WrSt <= WrSt_Nxt ;
   end
end


always_ff @(posedge clk) begin : proc_RqErr
   if(~rst_n) begin
      RqErr    <= 0;
      awaddr   <= '0;
      wdata    <= '0;
      wlast    <= '0;
      wvalid   <= '0;
      awvalid  <= '0;
      bready   <= '0;
   end else begin
      RqErr    <= RqErr_Nxt;
      awaddr   <= awaddr_Nxt ;
      wdata    <= wdata_Nxt ;
      wlast    <= wlast_Nxt ;
      wvalid   <= wvalid_Nxt ;
      awvalid  <= awvalid_Nxt;
      bready   <= bready_Nxt;
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

   wstrb   = '0;
   wlast   = 1'h0 ;
   wvalid  = 1'h0 ;
   bready  = 1'b0 ;

   RqErr_Nxt = '0 ;
   awaddr_Nxt  = awaddr ;
   wdata_Nxt  = wdata ;
   wlast_Nxt  = '0 ;
   wvalid_Nxt  = '0 ;
   awvalid_Nxt = '0 ;
   bready_Nxt = '0 ;



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