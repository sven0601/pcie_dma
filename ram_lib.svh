
wire porta_en_0, portb_en_0 ;
wire porta_en_1, portb_en_1 ;
wire porta_en_2, portb_en_2 ;
wire porta_en_3, portb_en_3 ;

wire rsta_busy_0, rstb_busy_0 ;
wire rsta_busy_1, rstb_busy_1 ;
wire rsta_busy_2, rstb_busy_2 ;
wire rsta_busy_3, rstb_busy_3 ;


assign porta_en_0 = WrEn ;
assign porta_en_1 = WrEn ;
assign porta_en_2 = WrEn ;
assign porta_en_3 = WrEn ;

assign portb_en_0 = RdEn ;
assign portb_en_1 = RdEn ;
assign portb_en_2 = RdEn ;
assign portb_en_3 = RdEn ;

mem32bDataIn mem32bDataIn_0 (
   .porta_clk  ( clk         ) ,
   .porta_rst  ( rst_n       ) ,
   .portb_clk  ( clk         ) ,
   .portb_rst  ( rst_n       ) ,
   .rsta_busy  ( rsta_busy_0 ) ,
   .rstb_busy  ( rstb_busy_0 )

   .porta_addr ( WrAddr         ) ,
   .porta_din  ( WrData[127:96] ) ,
   .porta_dout (                  ) ,
   .porta_en   ( porta_en_0       ) ,
   .porta_we   ( WrEn           ) ,

   .portb_addr ( RdAddr         ) ,
   .portb_din  ( 32'h0            ) ,
   .portb_dout ( RdData[127:96] ) ,
   .portb_en   ( portb_en_0       ) ,
   .portb_we   ( 1'b0             ) ,
) ;

mem32bDataIn mem32bDataIn_1 (
   .porta_clk  ( clk         ) ,
   .porta_rst  ( rst_n       ) ,
   .portb_clk  ( clk         ) ,
   .portb_rst  ( rst_n       ) ,
   .rsta_busy  ( rsta_busy_1 ) ,
   .rstb_busy  ( rstb_busy_1 )

   .porta_addr ( WrAddr        ) ,
   .porta_din  ( WrData[95:64] ) ,
   .porta_dout (                 ) ,
   .porta_en   ( porta_en_1      ) ,
   .porta_we   ( WrEn          ) ,

   .portb_addr ( RdAddr        ) ,
   .portb_din  ( 32'h0           ) ,
   .portb_dout ( RdData[95:64] ) ,
   .portb_en   ( portb_en_1      ) ,
   .portb_we   ( 1'b0            ) ,
) ;

mem32bDataIn mem32bDataIn_2 (
   .porta_clk  ( clk         ) ,
   .porta_rst  ( rst_n       ) ,
   .portb_clk  ( clk         ) ,
   .portb_rst  ( rst_n       ) ,
   .rsta_busy  ( rsta_busy_2 ) ,
   .rstb_busy  ( rstb_busy_2 )

   .porta_addr ( WrAddr        ) ,
   .porta_din  ( WrData[63:32] ) ,
   .porta_dout (                 ) ,
   .porta_en   ( porta_en_2      ) ,
   .porta_we   ( WrEn          ) ,

   .portb_addr ( RdAddr        ) ,
   .portb_din  ( 32'h0           ) ,
   .portb_dout ( RdData[63:32] ) ,
   .portb_en   ( portb_en_2      ) ,
   .portb_we   ( 1'b0            ) ,
) ;

mem32bDataIn mem32bDataIn_3 (
   .porta_clk  ( clk         ) ,
   .porta_rst  ( rst_n       ) ,
   .portb_clk  ( clk         ) ,
   .portb_rst  ( rst_n       ) ,
   .rsta_busy  ( rsta_busy_3 ) ,
   .rstb_busy  ( rstb_busy_3 )

   .porta_addr ( WrAddr       ) ,
   .porta_din  ( WrData[31:0] ) ,
   .porta_dout (                ) ,
   .porta_en   ( porta_en_3     ) ,
   .porta_we   ( WrEn         ) ,

   .portb_addr ( RdAddr       ) ,
   .portb_din  ( 32'h0          ) ,
   .portb_dout ( RdData[31:0] ) ,
   .portb_en   ( portb_en_3     ) ,
   .portb_we   ( 1'b0           ) ,
) ;

