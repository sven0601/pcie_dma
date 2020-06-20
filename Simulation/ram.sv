module ram (
   input             WrEn ,
   input  [31:0]     WrAddr ,
   input  [127:0]    WrData ,
   input             RdEn ,
   input  [31:0]     RdAddr ,
   output logic [127:0]   RdData ,

   input             clk ,
   input             rst_n  
) ;


logic [127:0][31:0] mem;


always_ff @(posedge clk or negedge rst_n) begin : proc_
   if(~rst_n) begin
      mem    <= '{default: '0};
      RdData <= '0;
   end else begin
      if (WrEn) begin
         mem[WrAddr] <= WrData;
      end
      if (RdEn) begin
         RdData      <= mem[RdAddr];
      end
   end
end


endmodule