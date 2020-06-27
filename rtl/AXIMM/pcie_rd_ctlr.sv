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

logic [127:0]  RqData_Nxt;
logic          RqReady_Nxt, RqErr_Nxt;
logic          rready_Nxt;
logic          arvalid_Nxt ;
logic [63:0]   araddr_Nxt;


assign arqos   = 4'h0;
assign arcache = 4'h0;
assign arprot  = 3'h2;
assign arlock  = 1'h0;

always_ff @(posedge clk or negedge rst_n) begin : proc_RdSt
   if(~rst_n) begin
      RdSt    <= IDLE;
      RqData  <= '0;
      RqReady <= 0;
      RqErr   <= 0;
      rready  <= 0;
      arvalid <= 0;
      araddr  <= '0;
   end else begin
      RdSt    <= RdSt_Nxt;
      RqData  <= RqData_Nxt;
      RqReady <= RqReady_Nxt;
      RqErr   <= RqErr_Nxt;
      rready  <= rready_Nxt;
      arvalid <= arvalid_Nxt;
      araddr  <= araddr_Nxt;
   end
end

always_comb begin : proc_RdSt_Nxt
   RdSt_Nxt = RdSt ;

   arvalid_Nxt  = 1'h0 ;
   araddr_Nxt   = araddr ;
   arburst  = 2'h1 ;
   arid     = 4'h0 ;
   arlen    = 8'h0 ;
   arsize   = 3'h2 ;

   rready_Nxt   = 1'h0 ;
   RqErr_Nxt    = 1'h0 ;

   RqReady_Nxt  = 1'h0 ;
   RqData_Nxt   = RqData;
   RqErr_Nxt    = 0;
   case (RdSt)
      IDLE: begin
         if (RqValid) begin
            RdSt_Nxt = REQ_0 ;

            araddr_Nxt   = RqAddr ;
            arvalid_Nxt  = 1'h1   ;
         end
      end
      REQ_0:  begin
         if (arready & arvalid) begin
            RdSt_Nxt = DATA;

            rready_Nxt  = 1'h1 ;
            arvalid_Nxt = 0;
         end else begin
            rready_Nxt = 1'h0;
            arvalid_Nxt = 1;
            RdSt_Nxt = RdSt;  
         end
      end
      DATA: begin
         if (rvalid & rready) begin
            rready_Nxt = 0;
            if (rresp == 2'h0) begin
               RdSt_Nxt = IDLE;
            end else begin
               RdSt_Nxt = FAULT;
               RqErr_Nxt = 1'h1;
            end

            RqData_Nxt  = rdata ;
            RqReady_Nxt  = 1'h1;
         end else begin
            rready_Nxt = 1;
            RdSt_Nxt = RdSt;  
            RqReady_Nxt  = 1'h0;
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