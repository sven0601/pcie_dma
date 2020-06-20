//===========================================================================
// Author : 
// Module : jtag
//===========================================================================

module jtag  (
   input    clk ,
   input    rst_n ,
   output   JtagEn ,
   output  [31:0] RdAddr ,
   input   [127:0] RdData ,
   output   RdEn ,
   output  [31:0] WrAddr ,
   output  [127:0] WrData ,
   output   WrEn 
) ;

//=======START DECLARING WIRES ================================================//
wire  m_axi_arlock ;
wire [3:0] m_axi_arqos ;
wire [2:0] m_axi_arprot ;
wire [3:0] m_axi_arcache ;
wire  m_axi_awlock ;
wire [3:0] m_axi_awqos ;
wire [2:0] m_axi_awprot ;
wire [3:0] m_axi_awcache ;
wire [31:0] m_axi_araddr ;
wire [1:0] m_axi_arburst ;
wire [0:0] m_axi_arid ;
wire [7:0] m_axi_arlen ;
wire  m_axi_arready ;
wire [2:0] m_axi_arsize ;
wire  m_axi_arvalid ;
wire [31:0] m_axi_awaddr ;
wire [1:0] m_axi_awburst ;
wire [0:0] m_axi_awid ;
wire [7:0] m_axi_awlen ;
wire  m_axi_awready ;
wire [2:0] m_axi_awsize ;
wire  m_axi_awvalid ;
wire [0:0] m_axi_bid ;
wire  m_axi_bready ;
wire [1:0] m_axi_bresp ;
wire  m_axi_bvalid ;
wire  m_axi_wlast ;
wire  m_axi_wready ;
wire [7:0] m_axi_wstrb ;
wire  m_axi_wvalid ;
wire [63:0] m_axi_wdata ;
wire [63:0] m_axi_rdata ;
wire [0:0] m_axi_rid ;
wire  m_axi_rlast ;
wire  m_axi_rready ;
wire [1:0] m_axi_rresp ;
wire  m_axi_rvalid ;

//=======FINISH DECLARING WIRES ===============================================//

jtag_axi  m_jtag (
   .aclk ( clk ) ,
   .aresetn ( rst_n ) ,
   .m_axi_arlock ( m_axi_arlock ) ,
   .m_axi_arqos ( m_axi_arqos ) ,
   .m_axi_arprot ( m_axi_arprot ) ,
   .m_axi_arcache ( m_axi_arcache ) ,
   .m_axi_awlock ( m_axi_awlock ) ,
   .m_axi_awqos ( m_axi_awqos ) ,
   .m_axi_awprot ( m_axi_awprot ) ,
   .m_axi_awcache ( m_axi_awcache ) ,
   .m_axi_araddr ( m_axi_araddr ) ,
   .m_axi_arburst ( m_axi_arburst ) ,
   .m_axi_arid ( m_axi_arid ) ,
   .m_axi_arlen ( m_axi_arlen ) ,
   .m_axi_arready ( m_axi_arready ) ,
   .m_axi_arsize ( m_axi_arsize ) ,
   .m_axi_arvalid ( m_axi_arvalid ) ,
   .m_axi_awaddr ( m_axi_awaddr ) ,
   .m_axi_awburst ( m_axi_awburst ) ,
   .m_axi_awid ( m_axi_awid ) ,
   .m_axi_awlen ( m_axi_awlen ) ,
   .m_axi_awready ( m_axi_awready ) ,
   .m_axi_awsize ( m_axi_awsize ) ,
   .m_axi_awvalid ( m_axi_awvalid ) ,
   .m_axi_bid ( m_axi_bid ) ,
   .m_axi_bready ( m_axi_bready ) ,
   .m_axi_bresp ( m_axi_bresp ) ,
   .m_axi_bvalid ( m_axi_bvalid ) ,
   .m_axi_wlast ( m_axi_wlast ) ,
   .m_axi_wready ( m_axi_wready ) ,
   .m_axi_wstrb ( m_axi_wstrb ) ,
   .m_axi_wvalid ( m_axi_wvalid ) ,
   .m_axi_wdata ( m_axi_wdata ) ,
   .m_axi_rdata ( m_axi_rdata ) ,
   .m_axi_rid ( m_axi_rid ) ,
   .m_axi_rlast ( m_axi_rlast ) ,
   .m_axi_rready ( m_axi_rready ) ,
   .m_axi_rresp ( m_axi_rresp ) ,
   .m_axi_rvalid ( m_axi_rvalid ) 
) ;

`include "jtag_lib.svh"


endmodule
