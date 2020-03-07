   // input    clk ,
   // input    rst_n ,
   // input   [127:0] RdData ,
   // output   RdEn ,
   // output  [11:0] RdAddr ,
   // output  [127:0] WrData ,
   // output   WrEn ,
   // output  [11:0] WrAddr 

assign ena_aes_0      = IbIPSECValid[0] ;
assign IbPCIeValid[0]  = gcm_aes_done_0 ;
assign ObPCIeValid[0] = ~gcm_aes_done_0 ;
// ObRamValid[0]


top_gcm_aes_128 gcm_aes_0 (
.clk                ( clk            ) ,
.rstn               ( rst_n          ) ,
.ena_aes            ( ena_aes_0      ) ,
.wr_ena_fifo_in     ( WrEn[0]           ) ,
.addr_pcie_fifo_in  ( RdAddr[0]         ) ,
.data_pcie_fifo_in  ( RdData[0]         ) ,

.addr_pcie_fifo_out ( WrAddr[0]         ) ,
.encrypt_ena        ( 1'b1           ) ,
// output
.gcm_aes_done       ( gcm_aes_done_0 ) ,
.data_pcie_fifo_out ( WrData[0]         )
) ;