module top_gcm_aes_128(
input                clk         ,
input                rstn        ,
input                ibDataValid ,
output logic         ibSRAMValid ,
output logic         ib_rd_en    ,
output logic [7:0]   ib_rd_addr  ,
input  [127:0]       ib_rd_data  ,


output logic         obDataValid ,
input                obSRAMValid ,
output logic         ob_wr_en    ,
output logic [7:0]   ob_wr_addr  ,
output logic [127:0] ob_wr_data   
);

logic [7:0] Cntr;


always_ff @(posedge clk or negedge rstn) begin : proc_
   if(~rstn) begin
      Cntr <= 0;
      ibSRAMValid <= 1'h1;
      ob_wr_addr  <= 0;
      obDataValid <= 0;
   end else begin
      Cntr <= Cntr + 'h1;

      if (ibDataValid) begin
         if (Cntr != 'hFF) begin 
            ibSRAMValid <= 0;
         end else begin
            ibSRAMValid <= 1;
         end
      end else begin
      ob_wr_data <= Cntr;
      if (~ibSRAMValid) begin
         ob_wr_addr <= ob_wr_addr + 'h1;
      end else begin
         ob_wr_addr <= 0;
      end
   end
end





endmodule