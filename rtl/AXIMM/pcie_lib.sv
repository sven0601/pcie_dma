module pcie_sub_top (
   output [ 63:0  ] ctlr_araddr,
   output [ 1:0   ] ctlr_arburst,
   output [ 3:0   ] ctlr_arcache,
   output [ 3:0   ] ctlr_arid,
   output [ 7:0   ] ctlr_arlen,
   output           ctlr_arlock,
   output [ 2:0   ] ctlr_arprot,
   output [ 3:0   ] ctlr_arqos,
   input            ctlr_arready,
   output [ 2:0   ] ctlr_arsize,
   output           ctlr_arvalid,

   output [ 63:0  ] ctlr_awaddr,
   output [ 1:0   ] ctlr_awburst,
   output [ 3:0   ] ctlr_awcache,
   output [ 3:0   ] ctlr_awid,
   output [ 7:0   ] ctlr_awlen,
   output           ctlr_awlock,
   output [ 2:0   ] ctlr_awprot,
   output [ 3:0   ] ctlr_awqos,
   input            ctlr_awready,
   output [ 2:0   ] ctlr_awsize,
   output           ctlr_awvalid,

   input  [ 3:0   ] ctlr_bid,
   output           ctlr_bready,
   input  [ 1:0   ] ctlr_bresp,
   input            ctlr_bvalid,

   input  [ 127:0 ] ctlr_rdata,
   input  [ 3:0   ] ctlr_rid,
   input            ctlr_rlast,
   output           ctlr_rready,
   input  [ 1:0   ] ctlr_rresp,
   input            ctlr_rvalid,

   output [ 127:0 ] ctlr_wdata,
   output           ctlr_wlast,
   input            ctlr_wready,
   output [ 15:0  ] ctlr_wstrb,
   output           ctlr_wvalid,

   input            rsta_busy_csr,
   input            rsta_busy_ram,
   input            rstb_busy_csr,
   input            rstb_busy_ram ,

   input            clk,
   input            rst_n
) ;


wire         WrRqValid ;
wire [63:0]  WrRqAddr  ;
wire [127:0] WrRqData  ;
wire         WrRqReady ;
wire         WrRqErr   ;

wire           RdRqValid ;
wire [63:0]    RdRqAddr  ;
wire [127:0]   RdRqData  ;
wire           RdRqReady ;
wire           RdRqErr   ;


AxiRReqCtlr m_AxiRReqCtlr (
   .araddr  (ctlr_araddr  ) ,
   .arburst (ctlr_arburst ) ,
   .arid    (ctlr_arid    ) ,
   .arlen   (ctlr_arlen   ) ,
   .arready (ctlr_arready ) ,
   .arsize  (ctlr_arsize  ) ,
   .arvalid (ctlr_arvalid ) ,

   .arlock  (ctlr_arlock  ) ,
   .arprot  (ctlr_arprot  ) ,
   .arqos   (ctlr_arqos   ) ,
   .arcache (ctlr_arcache ) ,

   .rdata   (ctlr_rdata   ) ,
   .rid     (ctlr_rid     ) ,
   .rlast   (ctlr_rlast   ) ,
   .rready  (ctlr_rready  ) ,
   .rresp   (ctlr_rresp   ) ,
   .rvalid  (ctlr_rvalid  ) ,

   // Controller signals
   .RqValid (RdRqValid ) ,
   .RqAddr  (RdRqAddr  ) ,
   .RqData  (RdRqData  ) ,
   .RqReady (RdRqReady ) ,
   .RqErr   (RdRqErr   ) ,

   .clk     (clk),
   .rst_n   (rst_n)
);

AxiWReqCtlr m_AxiWReqCtlr(
   .awaddr  ( ctlr_awaddr  ) ,
   .awburst ( ctlr_awburst ) ,
   .awid    ( ctlr_awid    ) ,
   .awlen   ( ctlr_awlen   ) ,
   .awsize  ( ctlr_awsize  ) ,
   .awvalid ( ctlr_awvalid ) ,
   .awready ( ctlr_awready ) ,

   .bid     ( ctlr_bid     ) ,
   .bready  ( ctlr_bready  ) ,
   .bresp   ( ctlr_bresp   ) ,
   .bvalid  ( ctlr_bvalid  ) ,

   .wdata   ( ctlr_wdata   ) ,
   .wlast   ( ctlr_wlast   ) ,
   .wstrb   ( ctlr_wstrb   ) ,
   .wvalid  ( ctlr_wvalid  ) ,
   .wready  ( ctlr_wready  ) ,

   .awcache ( ctlr_awcache ) ,
   .awprot  ( ctlr_awprot  ) ,
   .awlock  ( ctlr_awlock  ) ,
   .awqos   ( ctlr_awqos   ) ,

   // Controller signals
   .RqValid ( WrRqValid    ) ,
   .RqAddr  ( WrRqAddr     ) ,
   .RqData  ( WrRqData     ) ,
   .RqReady ( WrRqReady    ) ,
   .RqErr   ( WrRqErr      ) ,

   .clk     ( clk          ) ,
   .rst_n   ( rst_n        )
);


pcie_sub_ctlr_top m_pcie_sub_ctlr_top(
   .clk       (clk  ) ,
   .rst_n     (rst_n) ,

   // Controller signals
   .RdRqValid (RdRqValid) ,
   .RdRqAddr  (RdRqAddr ) ,
   .RdRqData  (RdRqData ) ,
   .RdRqReady (RdRqReady) ,
   .RdRqErr   (RdRqErr  ) ,

   // Controller signals
   .WrRqValid (WrRqValid ) ,
   .WrRqAddr  (WrRqAddr  ) ,
   .WrRqData  (WrRqData  ) ,
   .WrRqReady (WrRqReady ) ,
   .WrRqErr   (WrRqErr   ) 
);

endmodule : pcie_sub_top





module pcie_sub_ctlr_top (
   input                   clk       ,
   input                   rst_n     ,

   // Controller signals
   output logic            RdRqValid ,
   output logic  [63:0]    RdRqAddr  ,
   input         [127:0]   RdRqData  ,
   input                   RdRqReady ,
   input                   RdRqErr   ,

   // Controller signals
   output logic            WrRqValid ,
   output logic  [63:0]    WrRqAddr  ,
   output logic  [127:0]   WrRqData  ,
   input                   WrRqReady ,
   input                   WrRqErr   
);


// Ib FIFO
wire [127:0]   IbDataOut  ;
wire [31:0]    IbAddrOut  ;
wire           IbRdEn     ;

wire           IbDataValid ;
wire           IbRamValid ;


//Ob FIFO
wire            ObWrEn ;
wire  [31:0]    ObAddrIn ;
wire  [127:0]   ObDataIn ;

wire            ObDataValid ;
wire            ObRamValid ;


pcie_sub_ctlr #(
   .COUNTER_LEN (6)
   ) m_pcie_sub_ctlr (
   .clk         ( clk  ) ,
   .rst_n       ( rst_n) ,

   // Controller signals
   .RdRqValid   ( RdRqValid ) ,
   .RdRqAddr    ( RdRqAddr  ) ,
   .RdRqData    ( RdRqData  ) ,
   .RdRqReady   ( RdRqReady ) ,
   .RdRqErr     ( RdRqErr   ) ,

   // Controller signals
   .WrRqValid   ( WrRqValid  ) ,
   .WrRqAddr    ( WrRqAddr   ) ,
   .WrRqData    ( WrRqData   ) ,
   .WrRqReady   ( WrRqReady  ) ,
   .WrRqErr     ( WrRqErr    ) ,

   // Ib FIFO
   .IbDataOut   ( IbDataOut   ) ,
   .IbAddrOut   ( IbAddrOut   ) ,
   .IbRdEn      ( IbRdEn      ) ,

   .IbDataValid ( IbDataValid ) ,
   .IbRamValid  ( IbRamValid  ) ,


   //Ob FIFO
   .ObWrEn      ( ObWrEn      ) ,
   .ObAddrIn    ( ObAddrIn    ) ,
   .ObDataIn    ( ObDataIn    ) ,

   .ObDataValid ( ObDataValid ) ,
   .ObRamValid  ( ObRamValid  )
);


top_gcm_aes_128 m_top_gcm_aes_128_0(
.clk         ( clk         ) ,
.rstn        ( rst_n       ) ,
.encrypt_ena ( 1           ) ,
.ibSRAMValid ( IbRamValid  ) ,
.ibDataValid ( IbDataValid ) ,
.ib_rd_en    ( IbRdEn      ) ,
.ib_rd_data  ( IbDataOut   ) ,
.ib_rd_addr  ( IbAddrOut   ) ,
// output
.ObWrEn      ( ObWrEn      ) ,
.obSRAMValid ( ObRamValid  ) ,
.obDataValid ( ObDataValid ) ,
.ob_wr_addr  ( ObAddrIn    ) ,
.ob_wr_data  ( ObDataIn    )
);



endmodule : pcie_sub_ctlr_top