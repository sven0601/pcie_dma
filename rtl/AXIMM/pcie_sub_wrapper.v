//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
//Date        : Sat May  9 12:13:13 2020
//Host        : Admin running 64-bit major release  (build 9200)
//Command     : generate_target pcie_sub_wrapper.bd
//Design      : pcie_sub_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module pcie_sub_wrapper
   (ctlr_araddr,
    ctlr_arburst,
    ctlr_arcache,
    ctlr_arid,
    ctlr_arlen,
    ctlr_arlock,
    ctlr_arprot,
    ctlr_arqos,
    ctlr_arready,
    ctlr_arsize,
    ctlr_arvalid,
    ctlr_awaddr,
    ctlr_awburst,
    ctlr_awcache,
    ctlr_awid,
    ctlr_awlen,
    ctlr_awlock,
    ctlr_awprot,
    ctlr_awqos,
    ctlr_awready,
    ctlr_awsize,
    ctlr_awvalid,
    ctlr_bid,
    ctlr_bready,
    ctlr_bresp,
    ctlr_bvalid,
    ctlr_rdata,
    ctlr_rid,
    ctlr_rlast,
    ctlr_rready,
    ctlr_rresp,
    ctlr_rvalid,
    ctlr_wdata,
    ctlr_wlast,
    ctlr_wready,
    ctlr_wstrb,
    ctlr_wvalid,
    pcie_perstn,
    pcie_refclk_clk_n,
    pcie_refclk_clk_p,
    pcie_x1_rxn,
    pcie_x1_rxp,
    pcie_x1_txn,
    pcie_x1_txp,
    rsta_busy_csr,
    rsta_busy_ram,
    rstb_busy_csr,
    rstb_busy_ram);
  input [63:0]ctlr_araddr;
  input [1:0]ctlr_arburst;
  input [3:0]ctlr_arcache;
  input [3:0]ctlr_arid;
  input [7:0]ctlr_arlen;
  input [0:0]ctlr_arlock;
  input [2:0]ctlr_arprot;
  input [3:0]ctlr_arqos;
  output [0:0]ctlr_arready;
  input [2:0]ctlr_arsize;
  input [0:0]ctlr_arvalid;
  input [63:0]ctlr_awaddr;
  input [1:0]ctlr_awburst;
  input [3:0]ctlr_awcache;
  input [3:0]ctlr_awid;
  input [7:0]ctlr_awlen;
  input [0:0]ctlr_awlock;
  input [2:0]ctlr_awprot;
  input [3:0]ctlr_awqos;
  output [0:0]ctlr_awready;
  input [2:0]ctlr_awsize;
  input [0:0]ctlr_awvalid;
  output [3:0]ctlr_bid;
  input [0:0]ctlr_bready;
  output [1:0]ctlr_bresp;
  output [0:0]ctlr_bvalid;
  output [127:0]ctlr_rdata;
  output [3:0]ctlr_rid;
  output [0:0]ctlr_rlast;
  input [0:0]ctlr_rready;
  output [1:0]ctlr_rresp;
  output [0:0]ctlr_rvalid;
  input [127:0]ctlr_wdata;
  input [0:0]ctlr_wlast;
  output [0:0]ctlr_wready;
  input [15:0]ctlr_wstrb;
  input [0:0]ctlr_wvalid;
  input pcie_perstn;
  input [0:0]pcie_refclk_clk_n;
  input [0:0]pcie_refclk_clk_p;
  input [0:0]pcie_x1_rxn;
  input [0:0]pcie_x1_rxp;
  output [0:0]pcie_x1_txn;
  output [0:0]pcie_x1_txp;
  output rsta_busy_csr;
  output rsta_busy_ram;
  output rstb_busy_csr;
  output rstb_busy_ram;

  wire [63:0]ctlr_araddr;
  wire [1:0]ctlr_arburst;
  wire [3:0]ctlr_arcache;
  wire [3:0]ctlr_arid;
  wire [7:0]ctlr_arlen;
  wire [0:0]ctlr_arlock;
  wire [2:0]ctlr_arprot;
  wire [3:0]ctlr_arqos;
  wire [0:0]ctlr_arready;
  wire [2:0]ctlr_arsize;
  wire [0:0]ctlr_arvalid;
  wire [63:0]ctlr_awaddr;
  wire [1:0]ctlr_awburst;
  wire [3:0]ctlr_awcache;
  wire [3:0]ctlr_awid;
  wire [7:0]ctlr_awlen;
  wire [0:0]ctlr_awlock;
  wire [2:0]ctlr_awprot;
  wire [3:0]ctlr_awqos;
  wire [0:0]ctlr_awready;
  wire [2:0]ctlr_awsize;
  wire [0:0]ctlr_awvalid;
  wire [3:0]ctlr_bid;
  wire [0:0]ctlr_bready;
  wire [1:0]ctlr_bresp;
  wire [0:0]ctlr_bvalid;
  wire [127:0]ctlr_rdata;
  wire [3:0]ctlr_rid;
  wire [0:0]ctlr_rlast;
  wire [0:0]ctlr_rready;
  wire [1:0]ctlr_rresp;
  wire [0:0]ctlr_rvalid;
  wire [127:0]ctlr_wdata;
  wire [0:0]ctlr_wlast;
  wire [0:0]ctlr_wready;
  wire [15:0]ctlr_wstrb;
  wire [0:0]ctlr_wvalid;
  wire pcie_perstn;
  wire [0:0]pcie_refclk_clk_n;
  wire [0:0]pcie_refclk_clk_p;
  wire [0:0]pcie_x1_rxn;
  wire [0:0]pcie_x1_rxp;
  wire [0:0]pcie_x1_txn;
  wire [0:0]pcie_x1_txp;
  wire rsta_busy_csr;
  wire rsta_busy_ram;
  wire rstb_busy_csr;
  wire rstb_busy_ram;

  pcie_sub pcie_sub_i
       (.ctlr_araddr(ctlr_araddr),
        .ctlr_arburst(ctlr_arburst),
        .ctlr_arcache(ctlr_arcache),
        .ctlr_arid(ctlr_arid),
        .ctlr_arlen(ctlr_arlen),
        .ctlr_arlock(ctlr_arlock),
        .ctlr_arprot(ctlr_arprot),
        .ctlr_arqos(ctlr_arqos),
        .ctlr_arready(ctlr_arready),
        .ctlr_arsize(ctlr_arsize),
        .ctlr_arvalid(ctlr_arvalid),
        .ctlr_awaddr(ctlr_awaddr),
        .ctlr_awburst(ctlr_awburst),
        .ctlr_awcache(ctlr_awcache),
        .ctlr_awid(ctlr_awid),
        .ctlr_awlen(ctlr_awlen),
        .ctlr_awlock(ctlr_awlock),
        .ctlr_awprot(ctlr_awprot),
        .ctlr_awqos(ctlr_awqos),
        .ctlr_awready(ctlr_awready),
        .ctlr_awsize(ctlr_awsize),
        .ctlr_awvalid(ctlr_awvalid),
        .ctlr_bid(ctlr_bid),
        .ctlr_bready(ctlr_bready),
        .ctlr_bresp(ctlr_bresp),
        .ctlr_bvalid(ctlr_bvalid),
        .ctlr_rdata(ctlr_rdata),
        .ctlr_rid(ctlr_rid),
        .ctlr_rlast(ctlr_rlast),
        .ctlr_rready(ctlr_rready),
        .ctlr_rresp(ctlr_rresp),
        .ctlr_rvalid(ctlr_rvalid),
        .ctlr_wdata(ctlr_wdata),
        .ctlr_wlast(ctlr_wlast),
        .ctlr_wready(ctlr_wready),
        .ctlr_wstrb(ctlr_wstrb),
        .ctlr_wvalid(ctlr_wvalid),
        .pcie_perstn(pcie_perstn),
        .pcie_refclk_clk_n(pcie_refclk_clk_n),
        .pcie_refclk_clk_p(pcie_refclk_clk_p),
        .pcie_x1_rxn(pcie_x1_rxn),
        .pcie_x1_rxp(pcie_x1_rxp),
        .pcie_x1_txn(pcie_x1_txn),
        .pcie_x1_txp(pcie_x1_txp),
        .rsta_busy_csr(rsta_busy_csr),
        .rsta_busy_ram(rsta_busy_ram),
        .rstb_busy_csr(rstb_busy_csr),
        .rstb_busy_ram(rstb_busy_ram));
endmodule
