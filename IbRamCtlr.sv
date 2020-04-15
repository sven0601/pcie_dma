//=======================================================
// Author : 
// Module : IbRamCtlr
//=======================================================

module IbRamCtlr (
   output         DataValid ,
   input          RamValid ,
   input          tlast ,
   input          enableUseRam ,

   input          clk ,
   input          rst_n
) ;

// logic state ; // 0 Ram is valid, 1 Ram is reading by IPSec core

enum logic[2:0] {
   RESET          = 3'h0,
   GET            = 3'h1,
   RAM_GET_DATA   = 3'h2
} State, StateNxt ;

logic lg_DataValid ;


assign DataValid = lg_DataValid ;

always_ff @(posedge clk or negedge rst_n) begin : proc_State
   if(~rst_n) begin
      State <= RESET;
   end else begin
      State <= StateNxt;
   end
end

always_comb begin : proc_StateNxt
   lg_DataValid = 1'h0;
   case (State)
      RESET : begin
         lg_DataValid = 1'h0;

         StateNxt = (tlast & enableUseRam) ? GET : State;
      end
      GET   : begin
         lg_DataValid = 1'h1;

         StateNxt = RAM_GET_DATA;
      end
      RAM_GET_DATA : begin
         lg_DataValid = ~RamValid;

         StateNxt = (RamValid) ? RESET : State;
      end
   endcase
end

// always_ff @(posedge clk or negedge rst_n or posedge RamValid) begin : proc_DataValid
//    if(~rst_n) begin
//       DataValid   <= 1'b0 ;
//       state       <= 1'b0 ;
//    end else begin
//       if (tlast & enableUseRam) begin
//          DataValid   <= 1'b1 ;
//       end
//       if (~RamValid & DataValid) begin
//          state       <= 1'b1 ;
//       end
//       if (state & RamValid) begin
//          DataValid   <= 1'b0 ;
//          state       <= 1'b0 ;
//       end
//    end
// end


endmodule