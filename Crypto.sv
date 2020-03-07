//===========================================================================
// Author : 
// Module : Crypto
//===========================================================================

module Crypto  (
   input    clk ,
   input    rst_n ,
   input   [7:0][127:0] RdData ,
   output  [7:0] RdEn ,
   output  [7:0][31:0] RdAddr ,
   output  [7:0][127:0] WrData ,
   output  [7:0] WrEn ,
   output  [7:0][31:0] WrAddr ,
   output   [7:0] IbPCIeValid ,
   input  [7:0] IbIPSECValid ,
   output   [7:0] ObPCIeValid ,
   input  [7:0] ObIPSECValid 
) ;

//=======START DECLARING WIRES ================================================//

//=======FINISH DECLARING WIRES ===============================================//

`include "Crypto_lib.svh"


endmodule
