   // input    clk ,
   // input    rst_n ,
   // input   [127:0] RdData ,
   // output   RdEn ,
   // output  [11:0] RdAddr ,
   // output  [127:0] WrData ,
   // output   WrEn ,
   // output  [11:0] WrAddr 
assign ena_aes_0      = IbDataValid[0] ;
assign IbRamValid[0]  = gcm_aes_done_0 ;
assign ObDataValid[0] = ~gcm_aes_done_0 ;
// ObRamValid[0]


top_gcm_aes_128 gcm_aes_0 (
.clk                ( clk            ) ,
.rstn               ( rst_n          ) ,
.ena_aes            ( ena_aes_0      ) ,
.wr_ena_fifo_in     ( WrEn           ) ,
.addr_pcie_fifo_in  ( RdAddr         ) ,
.data_pcie_fifo_in  ( RdData         ) ,

.addr_pcie_fifo_out ( WrAddr         ) ,
.encrypt_ena        ( 1'b1           ) ,
// output
.gcm_aes_done       ( gcm_aes_done_0 ) ,
.data_pcie_fifo_out ( WrData         )
) ;