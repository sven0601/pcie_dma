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
   
   input   [31:0] m_axi_araddr ,
   input   [1:0] m_axi_arburst ,
   input   [0:0] m_axi_arid ,
   input   [7:0] m_axi_arlen ,
   output   m_axi_arready ,
   input   [2:0] m_axi_arsize ,
   input    m_axi_arvalid ,
   input   [31:0] m_axi_awaddr ,
   input   [1:0] m_axi_awburst ,
   input   [0:0] m_axi_awid ,
   input   [7:0] m_axi_awlen ,
   output   m_axi_awready ,
   input   [2:0] m_axi_awsize ,
   input    m_axi_awvalid ,
   output  [0:0] m_axi_bid ,
   input    m_axi_bready ,
   output  [1:0] m_axi_bresp ,
   output   m_axi_bvalid ,
   input    m_axi_wlast ,
   output   m_axi_wready ,
   input   [7:0] m_axi_wstrb ,
   input    m_axi_wvalid ,
   input   [63:0] m_axi_wdata ,
   output  [63:0] m_axi_rdata ,
   output  [0:0] m_axi_rid ,
   output   m_axi_rlast ,
   input    m_axi_rready ,
   output  [1:0] m_axi_rresp ,
   output   m_axi_rvalid 
) ;

//=======START DECLARING WIRES ================================================//

//=======FINISH DECLARING WIRES ===============================================//

ram  IbRam (
   .clk ( clk ) ,
   .rst_n ( rst_n ) ,
   .WrData ( IbWrData ) ,
   .WrEn ( IbWrEn ) ,
   .WrAddr ( IbWrAddr ) ,
   .RdData ( IbRdData ) ,
   .RdEn ( IbRdEn ) ,
   .RdAddr ( IbRdAddr ) 
) ;

ram  ObRam (
   .clk ( clk ) ,
   .rst_n ( rst_n ) ,
   .RdData ( ObRdData ) ,
   .RdEn ( ObRdEn ) ,
   .RdAddr ( ObRdAddr ) ,
   .WrData ( ObWrData ) ,
   .WrEn ( ObWrEn ) ,
   .WrAddr ( ObWrAddr ) 
) ;

`include "Mem_lib.svh"


endmodule
