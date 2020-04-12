//===========================================================================
// Author : 
// Module : Mem
//===========================================================================

module Mem  (
   input    clk ,
   input    rst_n ,
   input   [127:0] IbWrData ,
   input    IbWrEn ,
   input   [31:0] IbWrAddr ,
   output  [7:0][127:0] IbRdData ,
   input   [7:0] IbRdEn ,
   input   [7:0][31:0] IbRdAddr ,
   output  [127:0] ObRdData ,
   input    ObRdEn ,
   input   [31:0] ObRdAddr ,
   input   [7:0][127:0] ObWrData ,
   input   [7:0] ObWrEn ,
   input   [7:0][31:0] ObWrAddr ,
   input    JtagEn ,
   input   [31:0] JtagRdAddr ,
   output  [127:0] JtagRdData ,
   input    JtagRdEn ,
   input   [31:0] JtagWrAddr ,
   input   [127:0] JtagWrData ,
   input    JtagWrEn 
) ;

//=======START DECLARING WIRES ================================================//
wire [127:0] Ib_x8_WrData ;
wire  Ib_x8_WrEn ;
wire [31:0] Ib_x8_WrAddr ;
wire [7:0][127:0] Ib_x8_RdData ;
wire [7:0] Ib_x8_RdEn ;
wire [7:0][31:0] Ib_x8_RdAddr ;
wire [127:0] Ob_x8_RdData ;
wire  Ob_x8_RdEn ;
wire [31:0] Ob_x8_RdAddr ;
wire [7:0][127:0] Ob_x8_WrData ;
wire [7:0] Ob_x8_WrEn ;
wire [7:0][31:0] Ob_x8_WrAddr ;

//=======FINISH DECLARING WIRES ===============================================//

ram_x8_ib  ram_ib (
   .clk ( clk ) ,
   .rst_n ( rst_n ) ,
   .WrData ( Ib_x8_WrData ) ,
   .WrEn ( Ib_x8_WrEn ) ,
   .WrAddr ( Ib_x8_WrAddr ) ,
   .RdData ( Ib_x8_RdData ) ,
   .RdEn ( Ib_x8_RdEn ) ,
   .RdAddr ( Ib_x8_RdAddr ) 
) ;

ram_x8_ob  ram_ob (
   .clk ( clk ) ,
   .rst_n ( rst_n ) ,
   .RdData ( Ob_x8_RdData ) ,
   .RdEn ( Ob_x8_RdEn ) ,
   .RdAddr ( Ob_x8_RdAddr ) ,
   .WrData ( Ob_x8_WrData ) ,
   .WrEn ( Ob_x8_WrEn ) ,
   .WrAddr ( Ob_x8_WrAddr ) 
) ;

`include "Mem_lib.svh"


endmodule
