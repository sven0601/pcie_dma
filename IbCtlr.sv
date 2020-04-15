//===========================================================================
// Author : 
// Module : IbCtlr
//===========================================================================

module IbCtlr  (
   input    clk ,
   input    rst_n ,
   output  [7:0] DataValid ,
   input   [7:0] RamValid ,
   output  [127:0] WrData ,
   output   WrEn ,
   output  [31:0] WrAddr ,
   output  [18:0] cfg_mgmt_addr ,
   output   cfg_mgmt_write ,
   output  [31:0] cfg_mgmt_write_data ,
   output  [3:0] cfg_mgmt_byte_enable ,
   output   cfg_mgmt_read ,
   input   [31:0] cfg_mgmt_read_data ,
   input    cfg_mgmt_read_write_done ,
   output   cfg_mgmt_type1_cfg_reg_access ,
   input   [63:0] m_axis_h2c_tdata_0 ,
   input    m_axis_h2c_tlast_0 ,
   input    m_axis_h2c_tvalid_0 ,
   output   m_axis_h2c_tready_0 ,
   input   [7:0] m_axis_h2c_tkeep_0 ,
   output  [31:0] m_axi_lite_araddr ,
   output  [2:0] m_axi_lite_arprot ,
   input    m_axi_lite_arready ,
   output   m_axi_lite_arvalid ,
   output  [31:0] m_axi_lite_awaddr ,
   output  [2:0] m_axi_lite_awprot ,
   input    m_axi_lite_awready ,
   output   m_axi_lite_awvalid ,
   output   m_axi_lite_bready ,
   input   [1:0] m_axi_lite_bresp ,
   input    m_axi_lite_bvalid ,
   input   [31:0] m_axi_lite_rdata ,
   output   m_axi_lite_rready ,
   input   [1:0] m_axi_lite_rresp ,
   input    m_axi_lite_rvalid ,
   output  [31:0] m_axi_lite_wdata ,
   input    m_axi_lite_wready ,
   output  [3:0] m_axi_lite_wstrb ,
   output   m_axi_lite_wvalid 
) ;

//=======START DECLARING WIRES ================================================//

//=======FINISH DECLARING WIRES ===============================================//

`include "IbCtlr_lib.svh"


endmodule
