//=======================================================
// Author : 
// Module : IbRamCtlr
//=======================================================

module IbRamCtlr (
   output logic   DataValid ,
   input          RamValid ,
   input          tlast ,
   input          enableUseRam ,

   input          clk ,
   input          rst_n
) ;

logic state ; // 0 Ram is valid, 1 Ram is reading by IPSec core

always_ff @(posedge clk or negedge rst_n or posedge RamValid) begin : proc_DataValid
   if(~rst_n) begin
      DataValid   <= 1'b0 ;
      state       <= 1'b0 ;
   end else begin
      if (tlast & enableUseRam) begin
         DataValid   <= 1'b1 ;
      end
      if (~RamValid & DataValid) begin
         state       <= 1'b1 ;
      end
      if (state & RamValid) begin
         DataValid   <= 1'b0 ;
         state       <= 1'b0 ;
      end
   end
end


endmodule