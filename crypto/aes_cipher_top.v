

module aes_cipher_top(clk, rstn, aes_key_flag , done, key, leng_key, text_in, text_out);

input		clk, rstn;
input		aes_key_flag;
input	  [255:0]	key;
input   [1:0] leng_key;
input	  [127:0]	text_in;
output	[127:0]	text_out;
output	done;

//------------------------------------
//
// Local Wires
//

wire [31:0]	w0, w1, w2, w3;
reg	 [31:0]	w0_r, w1_r, w2_r, w3_r;
reg	 [127:0]	text_in_r;
reg	 [127:0]	text_out;

reg	 [7:0]	sa00, sa01, sa02, sa03;
reg	 [7:0]	sa10, sa11, sa12, sa13;
reg	 [7:0]	sa20, sa21, sa22, sa23;
reg	 [7:0]	sa30, sa31, sa32, sa33;

wire	[7:0]	sa00_next, sa01_next, sa02_next, sa03_next;
wire	[7:0]	sa10_next, sa11_next, sa12_next, sa13_next;
wire	[7:0]	sa20_next, sa21_next, sa22_next, sa23_next;
wire	[7:0]	sa30_next, sa31_next, sa32_next, sa33_next;

wire	[7:0]	sa00_sub, sa01_sub, sa02_sub, sa03_sub;
wire	[7:0]	sa10_sub, sa11_sub, sa12_sub, sa13_sub;
wire  [7:0]	sa20_sub, sa21_sub, sa22_sub, sa23_sub;
wire	[7:0]	sa30_sub, sa31_sub, sa32_sub, sa33_sub;

wire	[7:0]	sa00_sr, sa01_sr, sa02_sr, sa03_sr;
wire	[7:0]	sa10_sr, sa11_sr, sa12_sr, sa13_sr;
wire	[7:0]	sa20_sr, sa21_sr, sa22_sr, sa23_sr;
wire	[7:0]	sa30_sr, sa31_sr, sa32_sr, sa33_sr;

wire	[7:0]	sa00_mc, sa01_mc, sa02_mc, sa03_mc;
wire	[7:0]	sa10_mc, sa11_mc, sa12_mc, sa13_mc;
wire	[7:0]	sa20_mc, sa21_mc, sa22_mc, sa23_mc;
wire	[7:0]	sa30_mc, sa31_mc, sa32_mc, sa33_mc;

reg	 done;
reg  aes_key_flag_r;
reg	 [3:0]	dcnt;
wire [3:0]	pre_dcnt;

////////////////////////////////////////////////////////////////////
//
// Misc Logic
//

always@ (posedge clk or negedge rstn) begin
	if(!rstn)	begin 
    dcnt <=  4'h0;	 
  end
  else begin
	  if(aes_key_flag)	begin	
		  if (leng_key==2'b00) dcnt <=  4'hb;	
		  if (leng_key==2'b01) dcnt <=  4'hd;
		  if (leng_key==2'b10) dcnt <=  4'hf;
		  if (leng_key==2'b11) dcnt <=  4'h0;
	  end
	  else begin
	    if(|pre_dcnt) begin	
        dcnt <=  pre_dcnt - 4'h1;  
      end
    end
  end
end
assign pre_dcnt = dcnt;

always@ (posedge clk or negedge rstn) done           <=  (!rstn) ? 1'b0 : !(|dcnt[3:1]) & dcnt[0] & !aes_key_flag;
always@ (posedge clk or negedge rstn) text_in_r      <=  (!rstn) ? 128'd0 : (aes_key_flag ? text_in : 128'd0);
always@ (posedge clk or negedge rstn) aes_key_flag_r <=  (!rstn) ? 1'b0 : aes_key_flag;
always@ (posedge clk or negedge rstn) w0_r           <=  (!rstn) ? 32'd0 : w0;
always@ (posedge clk or negedge rstn) w1_r           <=  (!rstn) ? 32'd0 : w1;
always@ (posedge clk or negedge rstn) w2_r           <=  (!rstn) ? 32'd0 : w2;
always@ (posedge clk or negedge rstn) w3_r           <=  (!rstn) ? 32'd0 : w3;


////////////////////////////////////////////////////////////////////
//
// Initial Permutation (AddRoundKey)
//

always @(posedge clk or negedge rstn)   	sa33 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[007:000] ^ w3[07:00] : sa33_next);
always @(posedge clk or negedge rstn)   	sa23 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[015:008] ^ w3[15:08] : sa23_next);
always @(posedge clk or negedge rstn)   	sa13 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[023:016] ^ w3[23:16] : sa13_next);
always @(posedge clk or negedge rstn)   	sa03 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[031:024] ^ w3[31:24] : sa03_next);
always @(posedge clk or negedge rstn)   	sa32 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[039:032] ^ w2[07:00] : sa32_next);
always @(posedge clk or negedge rstn)   	sa22 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[047:040] ^ w2[15:08] : sa22_next);
always @(posedge clk or negedge rstn)   	sa12 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[055:048] ^ w2[23:16] : sa12_next);
always @(posedge clk or negedge rstn)   	sa02 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[063:056] ^ w2[31:24] : sa02_next);
always @(posedge clk or negedge rstn)   	sa31 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[071:064] ^ w1[07:00] : sa31_next);
always @(posedge clk or negedge rstn)   	sa21 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[079:072] ^ w1[15:08] : sa21_next);
always @(posedge clk or negedge rstn)   	sa11 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[087:080] ^ w1[23:16] : sa11_next);
always @(posedge clk or negedge rstn)   	sa01 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[095:088] ^ w1[31:24] : sa01_next);
always @(posedge clk or negedge rstn)   	sa30 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[103:096] ^ w0[07:00] : sa30_next);
always @(posedge clk or negedge rstn)   	sa20 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[111:104] ^ w0[15:08] : sa20_next);
always @(posedge clk or negedge rstn)   	sa10 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[119:112] ^ w0[23:16] : sa10_next);
always @(posedge clk or negedge rstn)   	sa00 <= (!rstn) ? 8'd0 : (aes_key_flag_r ? text_in_r[127:120] ^ w0[31:24] : sa00_next);

////////////////////////////////////////////////////////////////////
//
// Modules instantiation
//

aes_key_expand aes_key_expand_u0(
	.clk(	clk	),
	.key_flag( aes_key_flag	),
	.key(	key	),
	.leng_key(leng_key),
	.wo_0(		w0	),
	.wo_1(		w1	),
	.wo_2(		w2	),
	.wo_3(		w3	)
);

//sbox lookup
aes_sbox us00(	.a(	sa00	), .d(	sa00_sub	));
aes_sbox us01(	.a(	sa01	), .d(	sa01_sub	));
aes_sbox us02(	.a(	sa02	), .d(	sa02_sub	));
aes_sbox us03(	.a(	sa03	), .d(	sa03_sub	));
aes_sbox us10(	.a(	sa10	), .d(	sa10_sub	));
aes_sbox us11(	.a(	sa11	), .d(	sa11_sub	));
aes_sbox us12(	.a(	sa12	), .d(	sa12_sub	));
aes_sbox us13(	.a(	sa13	), .d(	sa13_sub	));
aes_sbox us20(	.a(	sa20	), .d(	sa20_sub	));
aes_sbox us21(	.a(	sa21	), .d(	sa21_sub	));
aes_sbox us22(	.a(	sa22	), .d(	sa22_sub	));
aes_sbox us23(	.a(	sa23	), .d(	sa23_sub	));
aes_sbox us30(	.a(	sa30	), .d(	sa30_sub	));
aes_sbox us31(	.a(	sa31	), .d(	sa31_sub	));
aes_sbox us32(	.a(	sa32	), .d(	sa32_sub	));
aes_sbox us33(	.a(	sa33	), .d(	sa33_sub	));

////////////////////////////////////////////////////////////////////
//
// Round Permutations
//

assign sa00_sr = sa00_sub;		//
assign sa01_sr = sa01_sub;		//no shift
assign sa02_sr = sa02_sub;		//
assign sa03_sr = sa03_sub;		//

assign sa10_sr = sa11_sub;		//
assign sa11_sr = sa12_sub;		// left shift by 1
assign sa12_sr = sa13_sub;		//
assign sa13_sr = sa10_sub;		//

assign sa20_sr = sa22_sub;		//
assign sa21_sr = sa23_sub;		//	left shift by 2
assign sa22_sr = sa20_sub;		//
assign sa23_sr = sa21_sub;		//

assign sa30_sr = sa33_sub;		//
assign sa31_sr = sa30_sub;		// left shift by 3
assign sa32_sr = sa31_sub;		//
assign sa33_sr = sa32_sub;		//

// mix column operation
assign {sa00_mc, sa10_mc, sa20_mc, sa30_mc}  = mix_col(sa00_sr,sa10_sr,sa20_sr,sa30_sr);
assign {sa01_mc, sa11_mc, sa21_mc, sa31_mc}  = mix_col(sa01_sr,sa11_sr,sa21_sr,sa31_sr);
assign {sa02_mc, sa12_mc, sa22_mc, sa32_mc}  = mix_col(sa02_sr,sa12_sr,sa22_sr,sa32_sr);
assign {sa03_mc, sa13_mc, sa23_mc, sa33_mc}  = mix_col(sa03_sr,sa13_sr,sa23_sr,sa33_sr);

//// add round key
assign sa00_next = sa00_mc ^ w0[31:24];		
assign sa01_next = sa01_mc ^ w1[31:24];
assign sa02_next = sa02_mc ^ w2[31:24];
assign sa03_next = sa03_mc ^ w3[31:24];
assign sa10_next = sa10_mc ^ w0[23:16];
assign sa11_next = sa11_mc ^ w1[23:16];
assign sa12_next = sa12_mc ^ w2[23:16];
assign sa13_next = sa13_mc ^ w3[23:16];
assign sa20_next = sa20_mc ^ w0[15:08];
assign sa21_next = sa21_mc ^ w1[15:08];
assign sa22_next = sa22_mc ^ w2[15:08];
assign sa23_next = sa23_mc ^ w3[15:08];
assign sa30_next = sa30_mc ^ w0[07:00];
assign sa31_next = sa31_mc ^ w1[07:00];
assign sa32_next = sa32_mc ^ w2[07:00];
assign sa33_next = sa33_mc ^ w3[07:00];

always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin 
    text_out <= 128'd0;
  end
  else begin
	  text_out[127:120] <=  sa00_sr ^ w0[31:24];	 
	  text_out[095:088] <=  sa01_sr ^ w1[31:24];	 
    text_out[063:056] <=  sa02_sr ^ w2[31:24];	 
	  text_out[031:024] <=  sa03_sr ^ w3[31:24];	 
	  text_out[119:112] <=  sa10_sr ^ w0[23:16];	 
	  text_out[087:080] <=  sa11_sr ^ w1[23:16];	 
	  text_out[055:048] <=  sa12_sr ^ w2[23:16];	 
	  text_out[023:016] <=  sa13_sr ^ w3[23:16];	 
	  text_out[111:104] <=  sa20_sr ^ w0[15:08];	 
	  text_out[079:072] <=  sa21_sr ^ w1[15:08];	 
	  text_out[047:040] <=  sa22_sr ^ w2[15:08];	 
	  text_out[015:008] <=  sa23_sr ^ w3[15:08];	 
	  text_out[103:096] <=  sa30_sr ^ w0[07:00];	 
	  text_out[071:064] <=  sa31_sr ^ w1[07:00];	 
	  text_out[039:032] <=  sa32_sr ^ w2[07:00];	 
	  text_out[007:000] <=  sa33_sr ^ w3[07:00];   
  end
end

//----------------------------------------------------------
// Generic Functions
//

function [31:0] mix_col;
  input	[7:0]	s0,s1,s2,s3;
  begin
    mix_col[31:24]=xtime(s0)^xtime(s1)^s1^s2^s3;
    mix_col[23:16]=s0^xtime(s1)^xtime(s2)^s2^s3;
    mix_col[15:08]=s0^s1^xtime(s2)^xtime(s3)^s3;
    mix_col[07:00]=xtime(s0)^s0^s1^s2^xtime(s3);
  end
endfunction

function [7:0] xtime;
  input [7:0] b; 
  xtime={b[6:0],1'b0}^(8'h1b&{8{b[7]}});
endfunction

endmodule



