//===========================================================================
// Author : 
// Module : PcieTop
//===========================================================================

module PcieTop  (
   input    sys_clk_p ,
   input    sys_clk_n ,
   input    sys_rst_n ,
   output  [3:0] pci_exp_txp ,
   output  [3:0] pci_exp_txn ,
   input   [3:0] pci_exp_rxp ,
   input   [3:0] pci_exp_rxn 
) ;

//=======START DECLARING WIRES ================================================//
wire  sys_clk ;
wire  sys_rst_n_c ;
wire  user_lnk_up ;
wire  axi_aclk ;
wire  axi_aresetn ;
wire [15:0] usr_irq_req ;
wire [15:0] usr_irq_ack ;
wire  msi_enable ;
wire [2:0] msi_vector_width ;
wire [18:0] pcie_cfg_mgmt_addr ;
wire  pcie_cfg_mgmt_write_en ;
wire [31:0] pcie_cfg_mgmt_write_data ;
wire [3:0] pcie_cfg_mgmt_byte_en ;
wire  pcie_cfg_mgmt_read_en ;
wire [31:0] pcie_cfg_mgmt_read_data ;
wire  pcie_cfg_mgmt_read_write_done ;
wire  pcie_cfg_mgmt_type1_cfg_reg_access ;
wire [63:0] s_axis_c2h_0_tdata ;
wire  s_axis_c2h_0_tlast ;
wire  s_axis_c2h_0_tvalid ;
wire  s_axis_c2h_0_tready ;
wire [7:0] s_axis_c2h_0_tkeep ;
wire [63:0] m_axis_h2c_0_tdata ;
wire  m_axis_h2c_0_tlast ;
wire  m_axis_h2c_0_tvalid ;
wire  m_axis_h2c_0_tready ;
wire [7:0] m_axis_h2c_0_tkeep ;
wire [7:0] IbDataValid ;
wire [7:0] IbRamValid ;
wire [127:0] IbWrData ;
wire  IbWrEn ;
wire [31:0] IbWrAddr ;
wire [7:0] ObDataValid ;
wire [7:0] ObRamValid ;
wire [127:0] ObRdData ;
wire  ObRdEn ;
wire [31:0] ObRdAddr ;
wire [7:0][127:0] IbRdData ;
wire [7:0] IbRdEn ;
wire [7:0][31:0] IbRdAddr ;
wire [7:0][127:0] ObWrData ;
wire [7:0] ObWrEn ;
wire [7:0][31:0] ObWrAddr ;
wire  JtagEn ;
wire [31:0] JtagRdAddr ;
wire [127:0] JtagRdData ;
wire  JtagRdEn ;
wire [31:0] JtagWrAddr ;
wire [127:0] JtagWrData ;
wire  JtagWrEn ;

//=======FINISH DECLARING WIRES ===============================================//

IBUFDS_GTE2  refclk_ibuf (
   .O ( sys_clk ) ,
   .ODIV2 (  ) ,
   .CEB ( 1'b0 ) ,
   .I ( sys_clk_p ) ,
   .IB ( sys_clk_n ) 
) ;

IBUF  sys_reset_n_ibuf (
   .O ( sys_rst_n_c ) ,
   .I ( sys_rst_n ) 
) ;

xdma_0  m_dma (
   .sys_clk ( sys_clk ) ,
   .sys_rst_n ( sys_rst_n_c ) ,
   .user_lnk_up ( user_lnk_up ) ,
   .pcie_exp_txp ( pci_exp_txp ) ,
   .pcie_exp_txn ( pci_exp_txn ) ,
   .pcie_exp_rxp ( pci_exp_rxp ) ,
   .pcie_exp_rxn ( pci_exp_rxn ) ,
   .axi_aclk ( axi_aclk ) ,
   .axi_aresetn ( axi_aresetn ) ,
   .usr_irq_req ( usr_irq_req ) ,
   .usr_irq_ack ( usr_irq_ack ) ,
   .msi_enable ( msi_enable ) ,
   .msi_vector_width ( msi_vector_width ) ,
   .pcie_cfg_mgmt_addr ( pcie_cfg_mgmt_addr ) ,
   .pcie_cfg_mgmt_write_en ( pcie_cfg_mgmt_write_en ) ,
   .pcie_cfg_mgmt_write_data ( pcie_cfg_mgmt_write_data ) ,
   .pcie_cfg_mgmt_byte_en ( pcie_cfg_mgmt_byte_en ) ,
   .pcie_cfg_mgmt_read_en ( pcie_cfg_mgmt_read_en ) ,
   .pcie_cfg_mgmt_read_data ( pcie_cfg_mgmt_read_data ) ,
   .pcie_cfg_mgmt_read_write_done ( pcie_cfg_mgmt_read_write_done ) ,
   .pcie_cfg_mgmt_type1_cfg_reg_access ( pcie_cfg_mgmt_type1_cfg_reg_access ) ,
   .s_axis_c2h_0_tdata ( s_axis_c2h_0_tdata ) ,
   .s_axis_c2h_0_tlast ( s_axis_c2h_0_tlast ) ,
   .s_axis_c2h_0_tvalid ( s_axis_c2h_0_tvalid ) ,
   .s_axis_c2h_0_tready ( s_axis_c2h_0_tready ) ,
   .s_axis_c2h_0_tkeep ( s_axis_c2h_0_tkeep ) ,
   .m_axis_h2c_0_tdata ( m_axis_h2c_0_tdata ) ,
   .m_axis_h2c_0_tlast ( m_axis_h2c_0_tlast ) ,
   .m_axis_h2c_0_tvalid ( m_axis_h2c_0_tvalid ) ,
   .m_axis_h2c_0_tready ( m_axis_h2c_0_tready ) ,
   .m_axis_h2c_0_tkeep ( m_axis_h2c_0_tkeep ) 
) ;

IbCtlr  IbCtlr (
   .clk ( axi_aclk ) ,
   .rst_n ( axi_aresetn ) ,
   .DataValid ( IbDataValid ) ,
   .RamValid ( IbRamValid ) ,
   .WrData ( IbWrData ) ,
   .WrEn ( IbWrEn ) ,
   .WrAddr ( IbWrAddr ) ,
   .cfg_mgmt_addr ( pcie_cfg_mgmt_addr ) ,
   .cfg_mgmt_write ( pcie_cfg_mgmt_write_en ) ,
   .cfg_mgmt_write_data ( pcie_cfg_mgmt_write_data ) ,
   .cfg_mgmt_byte_enable ( pcie_cfg_mgmt_byte_en ) ,
   .cfg_mgmt_read ( pcie_cfg_mgmt_read_en ) ,
   .cfg_mgmt_read_data ( pcie_cfg_mgmt_read_data ) ,
   .cfg_mgmt_read_write_done ( pcie_cfg_mgmt_read_write_done ) ,
   .cfg_mgmt_type1_cfg_reg_access ( pcie_cfg_mgmt_type1_cfg_reg_access ) ,
   .m_axis_h2c_tdata_0 ( m_axis_h2c_0_tdata ) ,
   .m_axis_h2c_tlast_0 ( m_axis_h2c_0_tlast ) ,
   .m_axis_h2c_tvalid_0 ( m_axis_h2c_0_tvalid ) ,
   .m_axis_h2c_tready_0 ( m_axis_h2c_0_tready ) ,
   .m_axis_h2c_tkeep_0 ( m_axis_h2c_0_tkeep ) 
) ;

ObCtlr  ObCtlr (
   .clk ( axi_aclk ) ,
   .rst_n ( axi_aresetn ) ,
   .DataValid ( ObDataValid ) ,
   .RamValid ( ObRamValid ) ,
   .RdData ( ObRdData ) ,
   .RdEn ( ObRdEn ) ,
   .RdAddr ( ObRdAddr ) ,
   .usr_irq_req ( usr_irq_req ) ,
   .usr_irq_ack ( usr_irq_ack ) ,
   .msi_enable ( msi_enable ) ,
   .msi_vector_width ( msi_vector_width ) ,
   .s_axis_c2h_tdata_0 ( s_axis_c2h_0_tdata ) ,
   .s_axis_c2h_tlast_0 ( s_axis_c2h_0_tlast ) ,
   .s_axis_c2h_tvalid_0 ( s_axis_c2h_0_tvalid ) ,
   .s_axis_c2h_tready_0 ( s_axis_c2h_0_tready ) ,
   .s_axis_c2h_tkeep_0 ( s_axis_c2h_0_tkeep ) 
) ;

Mem  Mem (
   .clk ( axi_aclk ) ,
   .rst_n ( axi_aresetn ) ,
   .IbWrData ( IbWrData ) ,
   .IbWrEn ( IbWrEn ) ,
   .IbWrAddr ( IbWrAddr ) ,
   .IbRdData ( IbRdData ) ,
   .IbRdEn ( IbRdEn ) ,
   .IbRdAddr ( IbRdAddr ) ,
   .ObRdData ( ObRdData ) ,
   .ObRdEn ( ObRdEn ) ,
   .ObRdAddr ( ObRdAddr ) ,
   .ObWrData ( ObWrData ) ,
   .ObWrEn ( ObWrEn ) ,
   .ObWrAddr ( ObWrAddr ) ,
   .JtagEn ( JtagEn ) ,
   .JtagRdAddr ( JtagRdAddr ) ,
   .JtagRdData ( JtagRdData ) ,
   .JtagRdEn ( JtagRdEn ) ,
   .JtagWrAddr ( JtagWrAddr ) ,
   .JtagWrData ( JtagWrData ) ,
   .JtagWrEn ( JtagWrEn ) 
) ;

Crypto  Crypto (
   .clk ( axi_aclk ) ,
   .rst_n ( axi_aresetn ) ,
   .RdData ( IbRdData ) ,
   .RdEn ( IbRdEn ) ,
   .RdAddr ( IbRdAddr ) ,
   .WrData ( ObWrData ) ,
   .WrEn ( ObWrEn ) ,
   .WrAddr ( ObWrAddr ) ,
   .IbPCIeValid ( IbDataValid ) ,
   .IbIPSECValid ( IbRamValid ) ,
   .ObPCIeValid ( ObDataValid ) ,
   .ObIPSECValid ( ObRamValid ) 
) ;

jtag  m_jtag (
   .clk ( axi_aclk ) ,
   .rst_n ( axi_aresetn ) ,
   .JtagEn ( JtagEn ) ,
   .RdAddr ( JtagRdAddr ) ,
   .RdData ( JtagRdData ) ,
   .RdEn ( JtagRdEn ) ,
   .WrAddr ( JtagWrAddr ) ,
   .WrData ( JtagWrData ) ,
   .WrEn ( JtagWrEn ) 
) ;

`include "PcieTop_lib.svh"


endmodule
