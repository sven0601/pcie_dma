
module aes_key_expand(clk, key_flag, key, leng_key, wo_0, wo_1, wo_2, wo_3);


input		clk;
input		key_flag;
input	  [255:0]	key;
input	  [1:0] leng_key;

output	[31:0]	wo_0, wo_1, wo_2, wo_3;			//output

reg  [2:0] count;
reg  [4:0] rcon_count;
wire [2:0] pre_count;
wire [4:0] pre_rcon_count;
wire [31:0] rcon;
wire rcon_en;
wire key_flag_r,key_flag_r2;
reg	 [31:0]	w  [0:7];

wire [31:0] wa0, wa2;
wire [31:0] wb0, wb1, wb2, wb3;
wire [31:0] ra0, ra2;
wire [31:0] w0,w1,w2,w3,w4,w5,w6,w7, o1, sub_rot_7, sub_7, sub_rot_o1;
wire sel_128, sel_192, sel_256;
wire sel_a0_subrot, sel_a0_sub, sel_a0;
wire sel_a2_subrot;
wire count36, count246, count135, count1245, count14;
wire [4:0] sel_out;
wire [1:0] leng_key_r;

dff_kep D0(key_flag,clk,key_flag_r);
dff_kep D6(key_flag_r,clk,key_flag_r2);
dff_kep D5(leng_key[0],clk,leng_key_r[0]);
dff_kep D1(leng_key[1],clk,leng_key_r[1]);

always @(posedge clk) begin
  if (key_flag) begin
	  w[0] <= key[255:224];
	  w[1] <= key[223:192];
	  w[2] <= key[191:160];
	  w[3] <= key[159:128];
	  w[4] <= key[127:096];
	  w[5] <= key[095:064];
	  w[6] <= key[063:032];
	  w[7] <= key[031:000];
	  count <= 0;
	  rcon_count <= 0;
  end
  else begin
  	w[0] <= w[4];
  	w[1] <= w[5];
  	w[2] <= w[6];
  	w[3] <= w[7];
  	w[4] <= wo_0;
  	w[5] <= wo_1;
  	w[6] <= wo_2;
  	w[7] <= wo_3;
	  rcon_count <= pre_rcon_count + 1;
	  if (pre_count==6)
		  count <= 1;
	  else
		  count <= pre_count + 1;
  end
end
assign pre_count = count;
assign pre_rcon_count = rcon_count;


assign w0 = w[0];
assign w1 = w[1];
assign w2 = w[2];
assign w3 = w[3];
assign w4 = w[4];
assign w5 = w[5];
assign w6 = w[6];
assign w7 = w[7];
assign o1 = wo_1;

assign count36 	= (count[2]&count[1])|(count[1]&count[0]);
assign count135 	= count[0];
assign count1245 	= ~count36;
assign count246 	= ~count135;
assign count14 	= (count[2]&(~count[1])&(~count[0]))|((~count[2])&(~count[1])&count[0]);
assign sel_128 = (~leng_key_r[1])&(~leng_key_r[0]);
assign sel_192 = (~leng_key_r[1])&( leng_key_r[0]);
assign sel_256 = ( leng_key_r[1])&(~leng_key_r[0]);
assign sel_a0_subrot 	= (sel_128)|(sel_192&count36)|(sel_256&count246);
assign sel_a0_sub 		= (sel_256&count135);
assign sel_a0 			= (sel_192&count1245);
assign sel_a2_subrot	= (sel_192&count14);
assign rcon_en = ((~leng_key_r[1])&(~leng_key_r[0]))|((~leng_key_r[0])&count[1]&(~count[0]))|(count[2]&(~count[0]))|((~leng_key_r[1])&(~count[2])&count[0]);

assign sel_out[0] = sel_128&key_flag_r;
assign sel_out[1] = sel_192&key_flag_r;
assign sel_out[2] = sel_192&key_flag_r2;
assign sel_out[3] = (sel_256&key_flag_r)|(sel_256&key_flag_r2);
assign sel_out[4] = (sel_128&key_flag_r2)|((~key_flag_r)&(~key_flag_r2));
assign rcon[23:0] = 24'b0;

aes_rcon r0(	.count(rcon_count), .len(leng_key), .out(rcon[31:24]));

aes_sbox u0(	.a(w7[23:16]), .d(sub_rot_7[31:24]));
aes_sbox u1(	.a(w7[15:08]), .d(sub_rot_7[23:16]));
aes_sbox u2(	.a(w7[07:00]), .d(sub_rot_7[15:08]));
aes_sbox u3(	.a(w7[31:24]), .d(sub_rot_7[07:00]));
aes_sbox u4(	.a(w7[31:24]), .d(sub_7[31:24]));
aes_sbox u5(	.a(w7[23:16]), .d(sub_7[23:16]));
aes_sbox u6(	.a(w7[15:08]), .d(sub_7[15:08]));
aes_sbox u7(	.a(w7[07:00]), .d(sub_7[07:00]));

aes_sbox ao0(	.a(o1[23:16]), .d(sub_rot_o1[31:24]));
aes_sbox ao1(	.a(o1[15:08]), .d(sub_rot_o1[23:16]));
aes_sbox ao2(	.a(o1[07:00]), .d(sub_rot_o1[15:08]));
aes_sbox ao3(	.a(o1[31:24]), .d(sub_rot_o1[07:00]));

mux3_1_kep mb0(w4,w2,w0,{sel_256,sel_192,sel_128},wb0);
mux3_1_kep mb1(w5,w3,w1,{sel_256,sel_192,sel_128},wb1);
mux3_1_kep mb2(w6,w4,w2,{sel_256,sel_192,sel_128},wb2);
mux3_1_kep mb3(w7,w5,w3,{sel_256,sel_192,sel_128},wb3);
mux3_1_kep ma0(sub_rot_7,sub_7,w7,{sel_a0,sel_a0_sub,sel_a0_subrot},wa0);
mux3_1_kep mra0(rcon,32'h0,32'h0,{sel_a0,sel_a0_sub,sel_a0_subrot},ra0);
mux2_1_kep ma2(o1,sub_rot_o1,sel_a2_subrot,wa2);
mux2_1_kep mra2(32'h0,rcon,sel_a2_subrot,ra2);

mux5_1_kep mo0(w[4],w[2],w[2],w[0],wa0^wb0^ra0,sel_out,wo_0);
mux5_1_kep mo1(w[5],w[3],w[3],w[1],wo_0^wb1,sel_out,wo_1);
mux5_1_kep mo2(w[6],w[4],wa2^wb2^ra2,w[2],wa2^wb2^ra2,sel_out,wo_2);
mux5_1_kep mo3(w[7],w[5],wo_2^wb3,w[3],wo_2^wb3,sel_out,wo_3);

endmodule

module mux3_1_kep(in0,in1,in2,sel,out);
	input [31:0] in0, in1, in2;
	input [2:0] sel;
	output [31:0] out; 
	reg [31:0] out;

	always @(*)
	case(sel)
		3'b001: out <= in0;
		3'b010: out <= in1;
		3'b100: out <= in2;
		default: out <= 0;
	endcase // sel
endmodule

module mux2_1_kep(in0,in1,sel,out);
	input [31:0] in0;
	input [31:0] in1;
	output [31:0] out;
	input sel;

	assign out = sel?in1:in0;

endmodule

module mux5_1_kep(in0,in1,in2,in3,in4,sel,out);
	input [31:0] in0;
	input [31:0] in1;
	input [31:0] in2;
	input [31:0] in3;
	input [31:0] in4;
	output reg [31:0] out;
	input [4:0] sel;

	always @(*)
	case(sel)
		5'b00001: out <= in0;
		5'b00010: out <= in1;
		5'b00100: out <= in2;
		5'b01000: out <= in3;
		5'b10000: out <= in4;
		default: out <= 0;
	endcase // sel

endmodule

module dff_kep(in,clk,out);
	input in;
	input clk;
	output reg out;

	always @(posedge clk)
	out <= in;

endmodule
