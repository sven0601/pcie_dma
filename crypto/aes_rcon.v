
/*module aes_rcon(clk, kld, out);
input		clk;
input		kld;
output	[31:0]	out;
reg	[31:0]	out;
reg	[3:0]	rcount;
wire	[3:0]	rcount_next;

always @(posedge clk)
	if(kld)		out <=  32'h01_00_00_00;
	else		out <=  frcon(rcount_next);

assign rcount_next = rcount + 4'h1;
always @(posedge clk)
	if(kld)		rcount <=  4'h0;
	else		rcount <=  rcount_next;

function [31:0]	frcon;
input	[3:0]	i;
case(i)	// synopsys parallel_case
   4'h0: frcon=32'h01_00_00_00;		//1
   4'h1: frcon=32'h02_00_00_00;		//x
   4'h2: frcon=32'h04_00_00_00;		//x^2
   4'h3: frcon=32'h08_00_00_00;		//x^3
   4'h4: frcon=32'h10_00_00_00;		//x^4
   4'h5: frcon=32'h20_00_00_00;		//x^5
   4'h6: frcon=32'h40_00_00_00;		//x^6
   4'h7: frcon=32'h80_00_00_00;		//x^7
   4'h8: frcon=32'h1b_00_00_00;		//x^8
   4'h9: frcon=32'h36_00_00_00;		//x^9
   default: frcon=32'h00_00_00_00;
endcase
endfunction

endmodule
*/


module aes_rcon(count, len, out);

input	  [4:0]	   count;
input	  [1:0]	   len;
output	[7:0]	   out;

assign out[0] = ((~count[3])&(~count[2])&(~count[1]))
               |(len[1]&(~count[3])&(~count[2]))
               |((~len[0])&count[3]&count[0]);
assign out[1] = ((~len[1])&(~count[3])&(~count[2])&(~count[0]))
               |((~len[1])&(~len[0])&count[3]&count[1])
               |(len[0]&(~count[2])&count[1]&count[0])
               |(len[1]&(~count[3])&(~count[1]))
               |((~len[0])&count[3]&count[0]);
assign out[2] = (len[0]&(~count[3])&count[2]&(~count[1]))
               |((~len[1])&(~len[0])&count[3]&count[1])
               |((~len[0])&(~count[2])&count[1]&count[0])
               |(len[1]&(~count[3])&count[2]&count[1]);
assign out[3] = ((~len[1])&(~len[0])&count[2]&(~count[1])&(~count[0]))
               |(len[0]&count[2]&count[1]&(~count[0]))
               |(len[1]&(~count[2])&(~count[1]))
               |((~len[0])&count[3]&count[0]);
assign out[4] = ((~len[0])&count[3]&(~count[2])&count[1])
               |((~len[0])&count[3]&count[0])
               |(count[2]&(~count[1])&count[0])
               |(len[0]&count[2]&count[0]);
assign out[5] = ((~len[1])&(~len[0])&count[2]&count[1]&(~count[0]))
               |((~len[1])&(~len[0])&count[3]&count[1])
               |(len[1]&count[3]&count[2]&(~count[1]))
               |(len[0]&count[3]&count[0]);
assign out[6] = ((~len[0])&count[2]&count[1]&count[0])
               |(count[3]&count[2]&count[1])
               |(len[0]&count[3]&count[1]);
assign out[7] = ((~len[1])&count[3]&(~count[1])&(~count[0]));

endmodule
