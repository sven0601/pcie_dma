//===========================================================================
// Author : 
// Module : jtag
//===========================================================================

module jtag  (
   input    aclk ,
   input    aresetn ,
   output   m_axi_arlock ,
   output  [3:0] m_axi_arqos ,
   output  [2:0] m_axi_arprot ,
   output  [3:0] m_axi_arcache ,
   output   m_axi_awlock ,
   output  [3:0] m_axi_awqos ,
   output  [2:0] m_axi_awprot ,
   output  [3:0] m_axi_awcache ,
   output  [31:0] m_axi_araddr ,
   output  [1:0] m_axi_arburst ,
   output  [0:0] m_axi_arid ,
   output  [7:0] m_axi_arlen ,
   input    m_axi_arready ,
   output  [2:0] m_axi_arsize ,
   output   m_axi_arvalid ,
   output  [31:0] m_axi_awaddr ,
   output  [1:0] m_axi_awburst ,
   output  [0:0] m_axi_awid ,
   output  [7:0] m_axi_awlen ,
   input    m_axi_awready ,
   output  [2:0] m_axi_awsize ,
   output   m_axi_awvalid ,
   input   [0:0] m_axi_bid ,
   output   m_axi_bready ,
   input   [1:0] m_axi_bresp ,
   input    m_axi_bvalid ,
   output   m_axi_wlast ,
   input    m_axi_wready ,
   output  [7:0] m_axi_wstrb ,
   output   m_axi_wvalid ,
   output  [63:0] m_axi_wdata ,
   input   [63:0] m_axi_rdata ,
   input   [0:0] m_axi_rid ,
   input    m_axi_rlast ,
   output   m_axi_rready ,
   input   [1:0] m_axi_rresp ,
   input    m_axi_rvalid 
) ;

//=======START DECLARING WIRES ================================================//

//=======FINISH DECLARING WIRES ===============================================//

`include "jtag_lib.svh"


endmodule
