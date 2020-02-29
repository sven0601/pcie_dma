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
wire [3:0] usr_irq_req ;
wire [3:0] usr_irq_ack ;
wire  msi_enable ;
wire [2:0] msi_vector_width ;
wire [18:0] cfg_mgmt_addr ;
wire  cfg_mgmt_write ;
wire [31:0] cfg_mgmt_write_data ;
wire [3:0] cfg_mgmt_byte_enable ;
wire  cfg_mgmt_read ;
wire [31:0] cfg_mgmt_read_data ;
wire  cfg_mgmt_read_write_done ;
wire  cfg_mgmt_type1_cfg_reg_access ;
wire [63:0] s_axis_c2h_tdata_0 ;
wire  s_axis_c2h_tlast_0 ;
wire  s_axis_c2h_tvalid_0 ;
wire  s_axis_c2h_tready_0 ;
wire [7:0] s_axis_c2h_tkeep_0 ;
wire [63:0] m_axis_h2c_tdata_0 ;
wire  m_axis_h2c_tlast_0 ;
wire  m_axis_h2c_tvalid_0 ;
wire  m_axis_h2c_tready_0 ;
wire [7:0] m_axis_h2c_tkeep_0 ;
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
   .pci_exp_txp ( pci_exp_txp ) ,
   .pci_exp_txn ( pci_exp_txn ) ,
   .pci_exp_rxp ( pci_exp_rxp ) ,
   .pci_exp_rxn ( pci_exp_rxn ) ,
   .axi_aclk ( axi_aclk ) ,
   .axi_aresetn ( axi_aresetn ) ,
   .usr_irq_req ( usr_irq_req ) ,
   .usr_irq_ack ( usr_irq_ack ) ,
   .msi_enable ( msi_enable ) ,
   .msi_vector_width ( msi_vector_width ) ,
   .cfg_mgmt_addr ( cfg_mgmt_addr ) ,
   .cfg_mgmt_write ( cfg_mgmt_write ) ,
   .cfg_mgmt_write_data ( cfg_mgmt_write_data ) ,
   .cfg_mgmt_byte_enable ( cfg_mgmt_byte_enable ) ,
   .cfg_mgmt_read ( cfg_mgmt_read ) ,
   .cfg_mgmt_read_data ( cfg_mgmt_read_data ) ,
   .cfg_mgmt_read_write_done ( cfg_mgmt_read_write_done ) ,
   .cfg_mgmt_type1_cfg_reg_access ( cfg_mgmt_type1_cfg_reg_access ) ,
   .s_axis_c2h_tdata_0 ( s_axis_c2h_tdata_0 ) ,
   .s_axis_c2h_tlast_0 ( s_axis_c2h_tlast_0 ) ,
   .s_axis_c2h_tvalid_0 ( s_axis_c2h_tvalid_0 ) ,
   .s_axis_c2h_tready_0 ( s_axis_c2h_tready_0 ) ,
   .s_axis_c2h_tkeep_0 ( s_axis_c2h_tkeep_0 ) ,
   .m_axis_h2c_tdata_0 ( m_axis_h2c_tdata_0 ) ,
   .m_axis_h2c_tlast_0 ( m_axis_h2c_tlast_0 ) ,
   .m_axis_h2c_tvalid_0 ( m_axis_h2c_tvalid_0 ) ,
   .m_axis_h2c_tready_0 ( m_axis_h2c_tready_0 ) ,
   .m_axis_h2c_tkeep_0 ( m_axis_h2c_tkeep_0 ) 
) ;

IbCtlr  IbCtlr (
   .clk ( axi_aclk ) ,
   .rst_n ( axi_aresetn ) ,
   .DataValid ( IbDataValid ) ,
   .RamValid ( IbRamValid ) ,
   .WrData ( IbWrData ) ,
   .WrEn ( IbWrEn ) ,
   .WrAddr ( IbWrAddr ) ,
   .cfg_mgmt_addr ( cfg_mgmt_addr ) ,
   .cfg_mgmt_write ( cfg_mgmt_write ) ,
   .cfg_mgmt_write_data ( cfg_mgmt_write_data ) ,
   .cfg_mgmt_byte_enable ( cfg_mgmt_byte_enable ) ,
   .cfg_mgmt_read ( cfg_mgmt_read ) ,
   .cfg_mgmt_read_data ( cfg_mgmt_read_data ) ,
   .cfg_mgmt_read_write_done ( cfg_mgmt_read_write_done ) ,
   .cfg_mgmt_type1_cfg_reg_access ( cfg_mgmt_type1_cfg_reg_access ) ,
   .m_axis_h2c_tdata_0 ( m_axis_h2c_tdata_0 ) ,
   .m_axis_h2c_tlast_0 ( m_axis_h2c_tlast_0 ) ,
   .m_axis_h2c_tvalid_0 ( m_axis_h2c_tvalid_0 ) ,
   .m_axis_h2c_tready_0 ( m_axis_h2c_tready_0 ) ,
   .m_axis_h2c_tkeep_0 ( m_axis_h2c_tkeep_0 ) 
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
   .s_axis_c2h_tdata_0 ( s_axis_c2h_tdata_0 ) ,
   .s_axis_c2h_tlast_0 ( s_axis_c2h_tlast_0 ) ,
   .s_axis_c2h_tvalid_0 ( s_axis_c2h_tvalid_0 ) ,
   .s_axis_c2h_tready_0 ( s_axis_c2h_tready_0 ) ,
   .s_axis_c2h_tkeep_0 ( s_axis_c2h_tkeep_0 ) 
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
   .aclk ( axi_aclk ) ,
   .aresetn ( axi_aresetn ) ,
   .m_axi_arlock (  ) ,
   .m_axi_arqos (  ) ,
   .m_axi_arprot (  ) ,
   .m_axi_arcache (  ) ,
   .m_axi_awlock (  ) ,
   .m_axi_awqos (  ) ,
   .m_axi_awprot (  ) ,
   .m_axi_awcache (  ) ,
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

`include "PcieTop_lib.svh"


endmodule
