// 
// Address to access RAM need to be 16B aligned 
// ==> Only accept Jtag transactions with Len=4 && Size=4 ==> total data = 16B
// ==> revoke the last 4b LSB in address
//
// To change to debug mode, the Debug Reg has to be set before issuing debug transactions
// The address of Debug Reg is 0xffff_fff0 from the aspect of JTAG debuger
//   or 1000_0111_FFFFFF

`define  OKAY    2'b00
`define  EXOKAY  2'b01 
`define  SLVERR  2'b10 
`define  DECERR  2'b11 

logic JtagEnReg;

`define WrDelayNum 2
`define RdDelayNum 2

//--------------------------------------------------------------------

enum logic[3:0] {
   RD_FAULT   = 4'h0 ,
   RD_GETADDR = 4'h1 ,
   RD_GETDATA = 4'h2 ,
   RD_RESPONSE0 = 4'h4,
   RD_RESPONSE1 = 4'h8
} JtagAxiRdSt ;

logic          ArReady ;
logic [31:0]   ArAddr;
logic [0:0]    ArId, RId;
logic [3:0]    RdDataDelayCntr;
logic          lg_RdEn ;
logic          RValid, RLast ;
logic [1:0]    RResp;
logic [63:0]   lg_RData;


//--------------------------------------------------------------------

enum logic[4:0] {
   WR_FAULT    = 5'h0 ,
   WR_GETADDR  = 5'h1 ,
   WR_GETDATA0 = 5'h2 ,
   WR_GETDATA1 = 5'h4 ,
   WR_WRITE    = 5'h8 ,
   WR_RESPONSE = 5'h10 
} JtagAxiWrSt ;

logic [31:0]   AwAddr;
logic [0:0]    AwId;
logic          AwReady, WReady;
logic [127:0]  lg_WrData;
logic          lg_WrEn;
logic [3:0]    WrDataDelayCntr;

logic          BValid;
logic [1:0]    BResp;
logic [0:0]    BId;

//--------------------------------------------------------------------
assign RdAddr = ArAddr ;
assign RdEn   = lg_RdEn ;

assign m_axi_arready = ArReady ;
assign m_axi_rdata = lg_RData;
assign m_axi_rid = RId;
assign m_axi_rlast = RLast;
assign m_axi_rresp = RResp;
assign m_axi_rvalid = RValid ;

always_ff @(posedge clk or negedge rst_n) begin : proc_Rd
   if (~rst_n) begin
      JtagAxiRdSt      <= RD_GETADDR ;
      ArReady        <= 1 ;
      RdDataDelayCntr <= 0 ;
      lg_RdEn        <= 0;
   end else begin
      case (JtagAxiRdSt)
         RD_GETADDR   : begin
            if (m_axi_arvalid) begin
               ArReady              <= 0 ;
               if (m_axi_arburst != 1 // INCR only
                     || m_axi_arlen != 4
                     || m_axi_arsize != 4) begin
                  JtagAxiRdSt         <= RD_FAULT ;

                  // initiate the next state
                  RValid         <= 1;
                  RLast          <= 1;
                  RResp          <= `DECERR;
               end else begin
                  ArAddr[31:0]      <= {m_axi_araddr[31], 4'h0, m_axi_araddr[30:4]} ; // remove the last 4b LSB
                  ArId              <= m_axi_arid ;
                  // next 
                  JtagAxiRdSt         <= RD_GETDATA ;
                  // initiate the next state
                  lg_RdEn           <= 1;
                  RdDataDelayCntr   <= 0;
               end
            end
         end
         RD_GETDATA: begin
            if (RdDataDelayCntr == `RdDelayNum) begin
               lg_RdEn         <= 0;
               JtagAxiRdSt     <= RD_RESPONSE0 ;
               // initiate the next state
               RId            <= ArId ;
               RValid         <= 1;
               RLast          <= 0;
               lg_RData       <= RdData[63:0] ;
               RResp          <= `OKAY;
            end else begin
               RdDataDelayCntr <= RdDataDelayCntr + 1;
            end
         end
         RD_RESPONSE0: begin
            if (m_axi_rready) begin
               JtagAxiRdSt   <= RD_RESPONSE1 ;
               // initiate the next state
               RId            <= ArId ;
               RValid         <= 1;
               RLast          <= 1;
               lg_RData       <= RdData[127:64] ;
               RResp          <= `OKAY;
            end
         end
         RD_RESPONSE1: begin
            if (m_axi_rready) begin
               JtagAxiRdSt    <= RD_GETADDR ;
               RValid         <= 0;
               RLast          <= 0;
               RResp          <= `SLVERR;
               // initiate the next state
               ArReady        <= 1;
            end
         end
         RD_FAULT: begin
            if (m_axi_rready) begin
               JtagAxiRdSt    <= RD_GETADDR ;
               RValid         <= 0;
               RLast          <= 0;
               RResp          <= `SLVERR;
               // initiate the next state
               ArReady        <= 1;
            end
         end
      endcase
   end
end

//-------------------------------------------------------------
assign m_axi_awready = AwReady;
assign m_axi_wready  = WReady;
assign m_axi_bresp   = BResp;
assign m_axi_bid     = BId;
assign m_axi_bvalid  = BValid;

assign WrData = lg_WrData;
assign WrEn   = lg_WrEn;
assign WrAddr = AwAddr ;
assign JtagEn = JtagEnReg ;

always_ff @(posedge clk or negedge rst_n) begin : proc_JtagEn
   if (~rst_n) begin
      JtagEnReg   <= 0;
   end else begin
      // FIXME: this reg is always updated although there is an error with transaction
      if (AwAddr[31:0] == {1'h1, 4'h0, 27'h7FF_FFFF}) begin
         JtagEnReg <= lg_WrData[0];
      end
   end
end


always_ff @(posedge clk or negedge rst_n) begin : proc_Wr
   if (~rst_n) begin
      JtagAxiWrSt    <= WR_GETADDR ;
      AwReady        <= 1;
      AwAddr         <= '0;
      WReady         <= 0;
      BResp          <= `OKAY;
      WrDataDelayCntr <= 0;
      lg_WrEn        <= 0;
   end else begin
      case (JtagAxiWrSt)
      WR_GETADDR: begin
         if (m_axi_awvalid) begin
            if (m_axi_arburst != 1 ||
                  m_axi_arlen != 4 ||
                  m_axi_arsize != 4) begin
               BResp          <= `DECERR;
               // initiate the next state
               AwReady        <= 0;
               WReady         <= 1;
            end else begin
               JtagAxiWrSt    <= WR_GETDATA0;
               AwAddr[31:0]   <= {m_axi_awaddr[31], 4'h0, m_axi_awaddr[30:4]};
               // initiate the next state
               AwReady        <= 0;
               WReady         <= 1;
               BResp          <= `OKAY;
            end
         end
      end
      WR_GETDATA0: begin
         if(m_axi_wvalid) begin
            JtagAxiWrSt <= WR_GETDATA1;
            // initiate the next state
            if (m_axi_wstrb != 8'hFF) begin
               BResp          <= `DECERR;
            end
            WReady            <= 1;
            lg_WrData[63:0]   <= m_axi_wdata[63:0] ;
         end
      end
      WR_GETDATA1: begin
         if(m_axi_wvalid) begin
            if (m_axi_wlast)
               JtagAxiWrSt       <= WR_WRITE;
            else
               BResp          <= `DECERR;

            // initiate the next state
            if (m_axi_wstrb != 8'hFF) begin
               BResp          <= `DECERR;
            end
            WReady            <= 0;
            lg_WrData[127:64] <= m_axi_wdata[63:0] ;
         end
      end
      WR_WRITE: begin
         if (BResp != `OKAY || AwAddr[31:0] == {1'h1, 4'h0, 27'h7FF_FFFF}) begin
            JtagAxiWrSt       <= WR_RESPONSE;
            // initiate the next state
            BValid            <= 1;
            BId               <= AwId;
         end else begin
            if (WrDataDelayCntr != `WrDelayNum) begin
               lg_WrEn           <= 1;
            end else begin
               WrDataDelayCntr   <= WrDataDelayCntr +1 ;
               lg_WrEn           <= 0;
               JtagAxiWrSt       <= WR_RESPONSE ;
               // initiate the next state
               BValid            <= 1;
               BId               <= AwId;
            end
         end
      end
      WR_RESPONSE: begin
         AwAddr            <= '0;
         if (m_axi_bvalid) begin
            JtagAxiWrSt       <= WR_GETADDR;
            BValid            <= 0;
            BResp             <= `SLVERR;
            // initiate the next state
            AwReady           <= 1;
         end
      end
      endcase
   end
end

