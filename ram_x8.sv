module ram_x8_ib #(
  parameter RAM_NUM = 8
  )(
  input                 clk    ,
  input                 rst_n  ,

  input   [127:0]       WrData ,
  input                 WrEn   ,
  input   [31:0]        WrAddr ,
  output  [7:0][127:0]  RdData ,
  input   [7:0]         RdEn   ,
  input   [7:0][31:0]   RdAddr  
);

logic [(RAM_NUM-1):0] lg_WrEn ;
logic [(RAM_NUM-1):0] lg_RdEn ;


`define decRamIb(idx)              \
ram ram_``idx (                  \
   .WrEn   (lg_WrEn[idx]   ),      \
   .WrAddr ({24'h0, WrAddr[7:0]} ), \
   .WrData (WrData      ),          \
   .RdEn   (RdEn[idx]     ),        \
   .RdAddr (RdAddr[idx]   ),        \
   .RdData (RdData[idx]   ),        \
   .clk    (clk),                   \
   .rst_n  (rst_n)                  \
) ;

`decRamIb(0)
`decRamIb(1)
`decRamIb(2)
`decRamIb(3)
`decRamIb(4)
`decRamIb(5)
`decRamIb(6)
`decRamIb(7)

always_comb begin : proc_WrEn
   lg_WrEn = '0;
   case (WrAddr[11:8])
   4'h0: begin
      lg_WrEn[0] = 1'h1 ;
   end
   4'h1: begin
      lg_WrEn[1] = 1'h1 ;
   end
   4'h2: begin
      lg_WrEn[2] = 1'h1 ;
   end
   4'h3: begin
      lg_WrEn[3] = 1'h1 ;
   end
   4'h4: begin
      lg_WrEn[4] = 1'h1 ;
   end
   4'h5: begin
      lg_WrEn[5] = 1'h1 ;
   end
   4'h6: begin
      lg_WrEn[6] = 1'h1 ;
   end
   4'h7: begin
      lg_WrEn[7] = 1'h1 ;
   end
   endcase
end

endmodule : ram_x8_ib


module ram_x8_ob #(
  parameter RAM_NUM = 8
  )(
  input                 clk    ,
  input                 rst_n  ,
  
  input   [7:0][127:0]  WrData ,
  input   [7:0]         WrEn   ,
  input   [7:0][31:0]   WrAddr ,
  output  [127:0]       RdData ,
  input                 RdEn   ,
  input   [31:0]        RdAddr  
);

logic [(RAM_NUM-1):0] lg_RdEn ;


`define decRamOb(idx)                  \
ram ram_``idx (                      \
   .WrEn   (WrEn[idx]            ) , \
   .WrAddr (WrAddr[idx]          ) , \
   .WrData (WrData[idx]          ) , \
   .RdEn   (lg_RdEn[idx]         ) , \
   .RdAddr ({24'h0, RdAddr[7:0]} ) , \
   .RdData (RdData               ) , \
   .clk    (clk                  ) , \
   .rst_n  (rst_n                )   \
) ;

`decRamOb(0)
`decRamOb(1)
`decRamOb(2)
`decRamOb(3)
`decRamOb(4)
`decRamOb(5)
`decRamOb(6)
`decRamOb(7)

always_comb begin : proc_WrEn
   lg_RdEn = '0;
   case (RdAddr[11:8])
   4'h0: begin
      lg_RdEn[0] = 1'h1 ;
   end
   4'h1: begin
      lg_RdEn[1] = 1'h1 ;
   end
   4'h2: begin
      lg_RdEn[2] = 1'h1 ;
   end
   4'h3: begin
      lg_RdEn[3] = 1'h1 ;
   end
   4'h4: begin
      lg_RdEn[4] = 1'h1 ;
   end
   4'h5: begin
      lg_RdEn[5] = 1'h1 ;
   end
   4'h6: begin
      lg_RdEn[6] = 1'h1 ;
   end
   4'h7: begin
      lg_RdEn[7] = 1'h1 ;
   end
   endcase
end

endmodule : ram_x8_ob