module IbObRamCtlr (
   input clk ,
   input rst_n ,

   input          IbWrDone ,
   output logic   IbDataValid ,
   input          IbRamValid ,

   input          ObRdDone ,
   input          ObDataValid ,
   output logic   ObRamValid  
) ;

logic [1:0] IbSt;
logic       ObSt;


always_comb begin : proc_IbDataValid
   IbDataValid = (IbSt == 2'h1 || (IbSt == 2'h2 && IbRamValid == 1'b0));
end


always_ff @(posedge clk or negedge rst_n) begin : proc_IbSt
   if(~rst_n) begin
      IbSt <= 0;
   end else begin
      case (IbSt)
         2'h0: begin
            if (IbWrDone) begin
               IbSt <= 2'h1;
            end else begin
               IbSt <= 2'h0;
            end
         end
         2'h1: begin
            if (IbRamValid) begin
               IbSt <= 2'h1;
            end else begin
               IbSt <= 2'h2;
            end
         end
         2'h2: begin
            if (IbRamValid) begin
               IbSt <= 2'h0;
            end else begin
               IbSt <= 2'h2;
            end
         end
         default : IbSt <= IbSt;
      endcase
   end
end


always_comb begin : proc_ObRamVaid
   ObRamValid = !(ObSt == 1'h1);
end

always_ff @(posedge clk or negedge rst_n) begin : proc_ObSt
   if(~rst_n) begin
      ObSt <= 0;
   end else begin
      if (ObSt) begin
         if (ObRdDone) begin
            ObSt <= 1'h0;
         end
      end else begin
         if (ObDataValid) begin
            ObSt <= 1'h1;
         end
      end
   end
end



endmodule