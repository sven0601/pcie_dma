input    clk ,
input    rst_n ,

input   [127:0] IbWrData ,
input    IbWrEn ,
input   [31:0] IbWrAddr ,
output  [7:0][127:0] IbRdData ,
input   [7:0] IbRdEn ,
input   [7:0][31:0] IbRdAddr ,
output  [127:0] ObRdData ,
input    ObRdEn ,
input   [31:0] ObRdAddr ,
input   [7:0][127:0] ObWrData ,
input   [7:0] ObWrEn ,
input   [7:0][31:0] ObWrAddr ,

input   [31:0] m_axi_araddr ,
input   [0:0]  m_axi_arid ,
input   [1:0]  m_axi_arburst ,
input   [7:0]  m_axi_arlen ,
input   [2:0]  m_axi_arsize ,
output         m_axi_arready ,
input          m_axi_arvalid ,

output  [63:0] m_axi_rdata ,
output  [0:0]  m_axi_rid ,
output         m_axi_rlast ,
input          m_axi_rready ,
output  [1:0]  m_axi_rresp ,
output         m_axi_rvalid ,
 
// input   [31:0] m_axi_awaddr ,
// input   [1:0] m_axi_awburst ,
// input   [0:0] m_axi_awid ,
// input   [7:0] m_axi_awlen ,
// output   m_axi_awready ,
// input   [2:0] m_axi_awsize ,
// input    m_axi_awvalid ,
// output  [0:0] m_axi_bid ,
// input    m_axi_bready ,
// output  [1:0] m_axi_bresp ,
// output   m_axi_bvalid ,
// input    m_axi_wlast ,
// output   m_axi_wready ,
// input   [7:0] m_axi_wstrb ,
// input    m_axi_wvalid ,
// input   [63:0] m_axi_wdata ,

logic JtagAcc ;

logic arready ;

logic [1:0] State ;
enum logic [2:0] {
   IDLE     = 3'h0 ,
   GET_ADDR = 3'h1 ,
   GET_DATA = 3'h2 ,
   FAULT    = 3'h4  
} State ;



assign m_axi_arready = arready ;


always_ff @(posedge clk or negedge rst_n) begin : proc_Read
   if(~rst_n) begin
      JtagAcc  <= 0 ;
      arready  <= 1 ;
      State    <= GET_ADDR ;
   end else begin

      case (State)
         IDLE : begin
         end
         GET_ADDR : begin
            if (arready & m_axi_arvalid) begin
               arready  <= 0 ;
               if (m_axi_arlen != 8'h0 || m_axi_arsize != 3'h4) begin
                  State    <= FAULT ;
               end else begin
                  State    <= GET_DATA ;
               end
            end
            
         end
         GET_DATA : begin

         end
         FAULT : begin

         end
      endcase


      if (arready & m_axi_arvalid) begin
         arready   <= 1 ;
         if (m_axi_araddr == 32'h1_0000_0000) begin
            JtagAcc <= ~JtagAcc ;
         end
      end
   end
end



1600Bx8 = 12800B < 32k 