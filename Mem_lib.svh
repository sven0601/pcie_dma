// Address map for debug data in RAM
// Ib Ram 0             - 32'h7fff_ffff
// Ob Ram 32'h8000_0000 - 32'hffff_ffff

logic [127:0]     lg_JtagIb_x8_RdData;
logic [7:0]       lg_Ib_x8_RdEn ;
logic [7:0][31:0] lg_Ib_x8_RdAddr ;

logic [7:0]          lg_Ob_x8_WrEn;
logic [7:0][31:0]    lg_Ob_x8_WrAddr;
logic [7:0][127:0]   lg_Ob_x8_WrData;

assign Ib_x8_WrData = (JtagEn == 1'b1 && 
                        JtagWrAddr[31] == 1'b0) ? (JtagWrData) : (IbWrData) ;
assign Ib_x8_WrEn   = (JtagEn == 1'b1 && 
                        JtagWrAddr[31] == 1'b0) ? (JtagWrEn) : (IbWrEn) ;
assign Ib_x8_WrAddr = (JtagEn == 1'b1 && 
                        JtagWrAddr[31] == 1'b0) ? (JtagWrAddr) : (IbWrAddr) ;


assign Ib_x8_RdEn   = lg_Ib_x8_RdEn  ;
assign Ib_x8_RdAddr = lg_Ib_x8_RdAddr;

always_comb begin : proc_Ib_Ram
   lg_JtagIb_x8_RdData = 0;
   lg_Ib_x8_RdEn       = '{default: '0};
   lg_Ib_x8_RdAddr     = '{default: '0};
   if (JtagEn) begin
      if (JtagRdAddr[31] == 1'b0) begin
         case(JtagRdAddr[11:8])
         4'h0: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[0];
            lg_Ib_x8_RdEn[0]    = 1'b1 ;
            lg_Ib_x8_RdAddr[0]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h1: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[1];
            lg_Ib_x8_RdEn[1]    = 1'b1 ;
            lg_Ib_x8_RdAddr[1]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h2: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[2];
            lg_Ib_x8_RdEn[2]    = 1'b1 ;
            lg_Ib_x8_RdAddr[2]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h3: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[3];
            lg_Ib_x8_RdEn[3]    = 1'b1 ;
            lg_Ib_x8_RdAddr[3]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h4: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[4];
            lg_Ib_x8_RdEn[4]    = 1'b1 ;
            lg_Ib_x8_RdAddr[4]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h5: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[5];
            lg_Ib_x8_RdEn[5]    = 1'b1 ;
            lg_Ib_x8_RdAddr[5]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h6: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[6];
            lg_Ib_x8_RdEn[6]    = 1'b1 ;
            lg_Ib_x8_RdAddr[6]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         4'h7: begin
            lg_JtagIb_x8_RdData = Ib_x8_RdData[7];
            lg_Ib_x8_RdEn[7]    = 1'b1 ;
            lg_Ib_x8_RdAddr[7]  = {24'h0, JtagRdAddr[7:0]} ;
         end
         endcase // JtagRdAddr[11:8]
      end
   end else begin
      lg_Ib_x8_RdEn   = IbRdEn;
      lg_Ib_x8_RdAddr = IbRdAddr;
   end
end

assign Ob_x8_RdEn   = (JtagEn == 1'b1 &&
                        JtagRdAddr[31] == 1'b1) ? (JtagRdEn) : (ObRdEn) ;
assign Ob_x8_RdAddr = (JtagEn == 1'b1 &&
                        JtagRdAddr[31] == 1'b1) ? (JtagRdAddr) : (ObRdAddr) ;
assign JtagRdData   = (JtagEn == 1'b1) ? (
                        (JtagRdAddr[31] == 1'b1)? (Ob_x8_RdData): (lg_JtagIb_x8_RdData)
                      ) : (128'h0) ;

assign Ob_x8_WrData = lg_Ob_x8_WrData;
assign Ob_x8_WrEn   = lg_Ob_x8_WrEn;
assign Ob_x8_WrAddr = lg_Ob_x8_WrAddr;

always_comb begin : proc_Ob_Ram
   lg_Ob_x8_WrData     = '{default: '0};
   lg_Ob_x8_WrEn       = '{default: '0};
   lg_Ob_x8_WrAddr     = '{default: '0};
   if (JtagEn) begin
      if (JtagWrAddr[31] == 1'b1) begin
         case(JtagWrAddr[11:8])
         4'h0: begin
            lg_Ob_x8_WrData[0] = JtagWrData;
            lg_Ob_x8_WrEn[0]    = 1'b1 ;
            lg_Ob_x8_WrAddr[0]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h1: begin
            lg_Ob_x8_WrData[1] = JtagWrData;
            lg_Ob_x8_WrEn[1]    = 1'b1 ;
            lg_Ob_x8_WrAddr[1]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h2: begin
            lg_Ob_x8_WrData[2] = JtagWrData;
            lg_Ob_x8_WrEn[2]    = 1'b1 ;
            lg_Ob_x8_WrAddr[2]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h3: begin
            lg_Ob_x8_WrData[3] = JtagWrData;
            lg_Ob_x8_WrEn[3]    = 1'b1 ;
            lg_Ob_x8_WrAddr[3]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h4: begin
            lg_Ob_x8_WrData[4] = JtagWrData;
            lg_Ob_x8_WrEn[4]    = 1'b1 ;
            lg_Ob_x8_WrAddr[4]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h5: begin
            lg_Ob_x8_WrData[5] = JtagWrData;
            lg_Ob_x8_WrEn[5]    = 1'b1 ;
            lg_Ob_x8_WrAddr[5]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h6: begin
            lg_Ob_x8_WrData[6] = JtagWrData;
            lg_Ob_x8_WrEn[6]    = 1'b1 ;
            lg_Ob_x8_WrAddr[6]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         4'h7: begin
            lg_Ob_x8_WrData[7] = JtagWrData;
            lg_Ob_x8_WrEn[7]    = 1'b1 ;
            lg_Ob_x8_WrAddr[7]  = {24'h0, JtagWrAddr[7:0]} ;
         end
         endcase
      end
   end else begin
      lg_Ob_x8_WrData = ObWrData;
      lg_Ob_x8_WrEn   = ObWrEn;
      lg_Ob_x8_WrAddr = ObWrAddr;
   end
end

