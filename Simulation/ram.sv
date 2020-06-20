`timescale 10ns/1ns
module ram (
   input             WrEn ,
   input  [31:0]     WrAddr ,
   input  [127:0]    WrData ,
   input             RdEn ,
   input  [31:0]     RdAddr ,
   output logic [127:0]   RdData ,

   input             clk/* ,
   input             rst_n*/
) ;

logic [127:0][31:0] mem;


logic rst_n;

initial begin
   rst_n = 0;
   #10ns;
   rst_n = 1;
end


always_ff @(posedge clk or negedge rst_n) begin : proc_
   if(~rst_n) begin
      mem    <= '{default: '0};
      RdData <= '0;
   end else begin
      if (WrEn) begin
         mem[WrAddr] <= WrData;
      end
      // if (RdEn) begin
      RdData      <= mem[RdAddr];
      // end
   end
end


endmodule