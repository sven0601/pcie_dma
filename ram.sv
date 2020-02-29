module ram (
   input             WrEn ,
   input  [31:0]     WrAddr ,
   input  [127:0]    WrData ,
   input             RdEn ,
   input  [31:0]     RdAddr ,
   input  [127:0]    RdData ,

   input             clk ,
   input             rst_n  
) ;

`include "ram_lib.svh"

endmodule