//=======================================================
// Author : 
// Module : IbCtlr
//=======================================================

//========== START DECLARING CONNECTIONS =============
logic          lg_tready ;
wire           tvalid, tlast ;
wire [7:0]     tkeep ;
wire [1:0]     tkeepDW ;
wire [63:0]    tdata, tdataDW ;
wire           ValidReady ;
logic          tlast_d1 ;

logic [127:0]  lg_WrData ;
logic          lg_WrEn;
logic [31:0]   WrDataBuffer[3:0] ;
logic [31:0]   WrDataBuffer_Nxt[3:0] ;
logic [11:0]   lg_WrAddr ;
// logic [7:0]    lg_DataValid ;
logic [2:0]    DataBufferCntr ;
logic [7:0]    enableUseRam ;
//========== FINISH DECLARING CONNECTIONS ============


assign tvalid = m_axis_h2c_tvalid_0 ;
assign tlast  = m_axis_h2c_tlast_0 ;
assign tdata  = m_axis_h2c_tdata_0 ;
assign tkeep  = m_axis_h2c_tkeep_0 ;
assign m_axis_h2c_tready_0 = lg_tready ;


assign WrData     = lg_WrData ;
assign WrAddr     = lg_WrAddr ;
assign WrEn       = lg_WrEn ;
// assign DataValid  = lg_DataValid ;



assign lg_tready = (RamValid != 0) ? 1'b1 : 1'b0 ;
assign ValidReady = tvalid & lg_tready ;


/**
 * pack data into a 128-b wide package
 */
assign tkeepDW =  (tkeep == 8'h0F || tkeep == 8'hF0) ? 2'h1 : ( (tkeep == 8'hFF) ? 2'h2 : 0) ;

assign tdataDW[32:0] = (tkeep[3:0] == 4'hF) ? tdata[31:00] : tdata[63:32] ;
assign tdataDW[32:0] = (tkeep[7:4] == 4'hF) ? tdata[63:32] : 32'h0 ;


always_comb begin : proc_InputOfBuffer
   lg_WrEn               = (DataBufferCntr == 3'h3 || tlast_d1 == 1'b1) ;
   lg_WrData[127:0]      = {WrDataBuffer[3][31:0], WrDataBuffer[2][31:0], WrDataBuffer[1][31:0], WrDataBuffer[0][31:0]} ;
   WrDataBuffer_Nxt[3:0] = WrDataBuffer[3:0] ;
   if (ValidReady) begin
      case(DataBufferCntr)
         3'h0: begin
            WrDataBuffer_Nxt[1] <= tdataDW[31:00] ;
            WrDataBuffer_Nxt[2] <= tdataDW[63:32] ;
         end
         3'h1: begin
            WrDataBuffer_Nxt[2] <= tdataDW[31:00] ;
            WrDataBuffer_Nxt[3] <= tdataDW[63:32] ;
         end
         3'h2: begin
            WrDataBuffer_Nxt[3] <= tdataDW[31:00] ;
            WrDataBuffer_Nxt[0] <= tdataDW[63:32] ;
         end
         3'h3: begin
            WrDataBuffer_Nxt[0] <= tdataDW[31:00] ;
            WrDataBuffer_Nxt[1] <= tdataDW[63:32] ;
         end
         3'h7: begin
            WrDataBuffer_Nxt[0] <= tdataDW[31:00] ;
            WrDataBuffer_Nxt[1] <= tdataDW[63:32] ;
         end
      endcase
   end
end



always_ff @(posedge clk or negedge rst_n) begin : proc_WrAddr
   if (~rst_n) begin
      lg_WrAddr           <= 12'h0 ;
   end else begin
      if (lg_WrEn & ~tlast_d1) begin
         lg_WrAddr[7:0]   <= lg_WrAddr[7:0] + 8'h1 ;
      end
      else if (lg_WrEn & tlast_d1) begin
         lg_WrAddr[7:0]   <= 8'h0 ;
      end

      //
      if (tlast_d1) begin
         casex (RamValid)
            8'bX1: begin
               lg_WrAddr[11:8] <= 4'h0 ;
            end
            8'bX10: begin
               lg_WrAddr[11:8] <= 4'h1 ;
            end
            8'bX100: begin
               lg_WrAddr[11:8] <= 4'h2 ;
            end
            8'bX_1000: begin
               lg_WrAddr[11:8] <= 4'h3 ;
            end
            8'bX1_0000: begin
               lg_WrAddr[11:8] <= 4'h4 ;
            end
            8'bX10_0000: begin
               lg_WrAddr[11:8] <= 4'h5 ;
            end
            8'bX100_0000: begin
               lg_WrAddr[11:8] <= 4'h6 ;
            end
            8'b1000_0000: begin
               lg_WrAddr[11:8] <= 4'h7 ;
            end
         endcase
      end
   end
end


always_ff @(posedge clk or negedge rst_n) begin : proc_UseRam
   if (~rst_n) begin
      enableUseRam      <= 8'h01 ;
   end else begin
      if (tlast_d1) begin
         if (enableUseRam[7]) begin
            enableUseRam   <= 8'h1 ;
         end else begin
            enableUseRam   <<= 1 ;
         end
      end
   end
end

IbRamCtlr RAM_0 (
   .DataValid    ( DataValid[0]    ) ,
   .RamValid     ( RamValid[0]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[0] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_1 (
   .DataValid    ( DataValid[1]    ) ,
   .RamValid     ( RamValid[1]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[1] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_2 (
   .DataValid    ( DataValid[2]    ) ,
   .RamValid     ( RamValid[2]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[2] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_3 (
   .DataValid    ( DataValid[3]    ) ,
   .RamValid     ( RamValid[3]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[3] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_4 (
   .DataValid    ( DataValid[4]    ) ,
   .RamValid     ( RamValid[4]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[4] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_5 (
   .DataValid    ( DataValid[5]    ) ,
   .RamValid     ( RamValid[5]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[5] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_6 (
   .DataValid    ( DataValid[6]    ) ,
   .RamValid     ( RamValid[6]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[6] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

IbRamCtlr RAM_7 (
   .DataValid    ( DataValid[7]    ) ,
   .RamValid     ( RamValid[7]     ) ,
   .tlast        ( tlast_d1        ) ,
   .enableUseRam ( enableUseRam[7] ) ,
   .clk          ( clk             ) ,
   .rst_n        ( rst_n           )
) ;

/**
 * the state of DataBufferCntr with value 7 can be merged with '3' state
 */
always_ff @(posedge clk or negedge rst_n) begin : proc_WrData
   if (~rst_n) begin
      WrDataBuffer   <= '{default: 32'h0} ;
      DataBufferCntr <= 3'h7 ;
      tlast_d1       <= 1'b0 ;
   end else begin
      tlast_d1          <= tlast ;
      WrDataBuffer[3:0] <= WrDataBuffer_Nxt[3:0] ;
      if (tlast) begin
         if (ValidReady) begin
            case(tkeepDW)
               2'h1: begin
                  case (DataBufferCntr)
                     3'h0: DataBufferCntr <= 3'h1 ;
                     3'h1: DataBufferCntr <= 3'h2 ;
                     3'h2: DataBufferCntr <= 3'h3 ;
                     3'h3: DataBufferCntr <= 3'h0 ;
                     3'h7: DataBufferCntr <= 3'h0 ;
                  endcase
               end
               2'h2: begin
                  case (DataBufferCntr)
                     3'h0: DataBufferCntr <= 3'h2 ;
                     3'h1: DataBufferCntr <= 3'h3 ;
                     // 3'h2: DataBufferCntr <= 
                     3'h3: DataBufferCntr <= 3'h1 ;
                     3'h7: DataBufferCntr <= 3'h1 ;
                  endcase
               end
            endcase
         end
      end else begin
         DataBufferCntr <= 3'h7 ;
      end
   end
end
