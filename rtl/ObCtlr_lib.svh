// input    clk ,
// input    rst_n ,

// input   [7:0] DataValid ,
// output  [7:0] RamValid ,
// input   [127:0] RdData ,
// output   RdEn ,
// output  [11:0] RdAddr ,

// output  [3:0] usr_irq_req ,
// input   [3:0] usr_irq_ack ,

// input    msi_enable ,
// input   [2:0] msi_vector_width ,

// output  [63:0] s_axis_c2h_tdata_0 ,
// output   s_axis_c2h_tlast_0 ,
// output   s_axis_c2h_tvalid_0 ,
// input    s_axis_c2h_tready_0 ,
// output  [7:0] s_axis_c2h_tkeep_0 


logic [31:0]   lg_RdAddr ;
logic          lg_RdEn ;
logic [7:0]    lg_RamValid ;
logic          RamValidSignal ;
logic          DataValidSignal ;

logic [63:0]   tdata ;
logic [7:0]    tkeep ;
logic          tvalid, tlast ;
wire           tready ;

logic [7:0]    RamPtr, RamPtrNxt ;
logic          DataRamValid, ChangeRam ;
logic [7:0]    lenMess ;


assign   RdAddr = lg_RdAddr ;
assign   RdEn   = lg_RdEn ;
assign   RamValid = lg_RamValid ;

assign tready = s_axis_c2h_tready_0 ;
assign s_axis_c2h_tvalid_0 = tvalid ;
assign s_axis_c2h_tkeep_0 = tkeep ;
assign s_axis_c2h_tlast_0 = tlast ;
assign s_axis_c2h_tdata_0 = tdata ;

enum logic[2:0] {
   IDLE  = 3'h0,
   GET0  = 3'h1,
   SEND1 = 3'h2,
   SEND2 = 3'h4
} ObSt, ObNxtSt ;

assign tValidReady = tvalid & tready ;

/**
 * Round-robin
 */
always_comb begin : proc_DataValid_RamValid_Signals
   DataRamValid = 0 ;
   RamPtrNxt    = 0 ;
   case (RamPtr)
      0 : begin
         casex (DataValid)
         8'bxxxx_xxx1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'bxxxx_xx10: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'bxxxx_x100: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'bxxxx_1000: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'bxxx1_0000: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'bxx10_0000: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx100_0000: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b1000_0000: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      1 : begin
         casex (DataValid)
         8'b0000_0001: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'bxxxx_xx1x: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'bxxxx_x10x: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'bxxxx_100x:begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'bxxx1_000x: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'bxx10_000x: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx100_000x: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b1000_000x: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      2 : begin
         casex (DataValid)
         8'b0000_00x1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'b0000_0010: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'bxxxx_x1xx: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'bxxxx_10xx: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'bxxx1_00xx: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'bxx10_00xx: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx100_00xx: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b1000_00xx: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      3 : begin
         casex (DataValid)
         8'b0000_0xx1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'b0000_0x10: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'b0000_0100: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'bxxxx_1xxx: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'bxxx1_0xxx: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'bxx10_0xxx: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx100_0xxx: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b1000_0xxx: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      4 : begin
         casex (DataValid)
         8'b0000_xxx1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'b0000_xx10: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'b0000_x100: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'b0000_1000: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'bxxx1_xxxx: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'bxx10_xxxx: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx100_xxxx: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b1000_xxxx: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      5 : begin
         casex (DataValid)
         8'b000x_xxx1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'b000x_xx10: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'b000x_x100: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'b000x_1000: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'b0001_0000: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'bxx1x_xxxx: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx10x_xxxx: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b100x_xxxx: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      6 : begin
         casex (DataValid)
         8'b00xx_xxx1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'b00xx_xx10: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'b00xx_x100: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'b00xx_1000: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'b00x1_0000: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'b0010_0000: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'bx1xx_xxxx: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b10xx_xxxx: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
      7 : begin
         casex (DataValid)
         8'b0xxx_xxx1: begin
            DataRamValid = DataValid[0] & RamValid[0] ;
            RamPtrNxt    = 0 ;
         end
         8'b0xxx_xx10: begin
            DataRamValid = DataValid[1] & RamValid[1] ;
            RamPtrNxt    = 1 ;
         end
         8'b0xxx_x100: begin
            DataRamValid = DataValid[2] & RamValid[2] ;
            RamPtrNxt    = 2 ;
         end
         8'b0xxx_1000: begin
            DataRamValid = DataValid[3] & RamValid[3] ;
            RamPtrNxt    = 3 ;
         end
         8'b0xx1_0000: begin
            DataRamValid = DataValid[4] & RamValid[4] ;
            RamPtrNxt    = 4 ;
         end
         8'b0x10_0000: begin
            DataRamValid = DataValid[5] & RamValid[5] ;
            RamPtrNxt    = 5 ;
         end
         8'b0100_0000: begin
            DataRamValid = DataValid[6] & RamValid[6] ;
            RamPtrNxt    = 6 ;
         end
         8'b1xxx_xxxx: begin
            DataRamValid = DataValid[7] & RamValid[7] ;
            RamPtrNxt    = 7 ;
         end
         endcase
      end
   endcase
end
always_comb begin : proc_RamValid
   lg_RamValid[0] = (RamPtr == 8'h0 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[1] = (RamPtr == 8'h1 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[2] = (RamPtr == 8'h2 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[3] = (RamPtr == 8'h3 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[4] = (RamPtr == 8'h4 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[5] = (RamPtr == 8'h5 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[6] = (RamPtr == 8'h6 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
   lg_RamValid[7] = (RamPtr == 8'h7 && ObSt != IDLE ) ? (1'b0) : (1'b1) ;
end

always_ff @(posedge clk or negedge rst_n) begin
   if (~rst_n) begin
      RamPtr   <= 0 ;
   end else begin
      if (ChangeRam) begin
         RamPtr   <= RamPtrNxt ;
      end
   end
end

always_ff @(posedge clk or negedge rst_n) begin
   if (~rst_n) begin
      lenMess <= 0 ;
   end else begin
      if (ObSt == GET0 && lg_RdEn == 1'b1) begin
         lenMess[7:0] <= RdData[15:8] ;
      end
   end
end


always_ff @(posedge clk or negedge rst_n) begin : proc_ObSt
   if (~rst_n) begin
      ObSt     <= IDLE ;
   end else begin
      ObSt     <= ObNxtSt ;
   end
end

always_comb begin : proc_ObNxtSt
   ObNxtSt     = IDLE ;
   ChangeRam   = 0 ;
   case (ObSt)
      IDLE  : begin
         if (DataRamValid) begin
            ObNxtSt  = GET0 ;
         end
      end
      GET0  : begin
         ObNxtSt  = SEND1 ;
      end
      SEND1 : begin
         if (tValidReady == 1'b1) begin
            ObNxtSt = SEND2 ;
         end
      end
      SEND2 : begin
         if (lg_RdAddr == lenMess-1) begin
            ObNxtSt   = IDLE ;
            ChangeRam = 1 ;
         end else begin
            if (tValidReady == 1'b1) begin
               ObNxtSt  = SEND1 ;
            end
         end
      end
      default : begin
         ObNxtSt     = IDLE ;
      end
   endcase
end

always_comb begin : proc_tValid_RdEn
   tvalid      = (ObSt == SEND1 || ObSt == SEND2) ? (1'b1) : (1'b0) ;
   lg_RdEn     = (ObSt == GET0  || ObSt == SEND2) ? 1'b1 : 1'b0 ;
   tdata[63:0] = (ObSt == SEND1) ? RdData[63:0] : ((ObSt == SEND2) ? RdData[127:64] : 64'h0) ;
end


always_ff @(posedge clk or negedge rst_n) begin
   if(~rst_n) begin
      lg_RdAddr <= 0 ;
   end else begin
      if (ChangeRam) begin
         lg_RdAddr    <= 0 ;
      end else begin
         if (lg_RdEn) begin
            lg_RdAddr <= lg_RdAddr + 1 ;
         end
      end
   end
end


