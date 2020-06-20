`define IpSec(idx)                     \
top_gcm_aes_128 gcm_aes_``idx (        \
.clk            (clk               ) , \
.rstn           (rst_n             ) , \
.ib_ipsec_valid (IbPCIeValid[idx]  ) , \
.ob_ipsec_valid (ObPCIeValid[idx]  ) , \
.encrypt_ena    (1'b1              ) , \
.ib_rd_data     (RdData[idx]       ) , \
.ib_pcie_valid  (IbIPSECValid[idx] ) , \
.ob_pcie_valid  (ObIPSECValid[idx] ) , \
.ib_rd_en       (RdEn[idx]         ) , \
.ob_wr_en       (WrEn[idx]         ) , \
.ib_rd_addr     (RdAddr[idx]       ) , \
.ob_wr_addr     (WrAddr[idx]       ) , \
.ob_wr_data     (WrData[idx]       )   \
);

`IpSec(0)
`IpSec(1)
`IpSec(2)
`IpSec(3)
`IpSec(4)
`IpSec(5)
`IpSec(6)
`IpSec(7)