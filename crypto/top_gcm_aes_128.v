//=======================================================================
// Ho Chi Minh City University of Technology
// Project     : IPSec
// File name   : top_gcm_aes_128.v
// Description : verilog top module GCM-AES 128 bits 
// Teachers    : Hoang Trang - Bui Quoc Bao
// Authors     : FPGA BKSTEK team 
//               + Nguyen Trong Ngo Nhat Du 
//               + Vo Ngoc Hieu 
//               + Do Quang Thinh
//               + Truong
//               + Hieu
//               + Trong
//=======================================================================

module top_gcm_aes_128(clk ,rstn ,
ib_ipsec_valid, 
ob_ipsec_valid,
encrypt_ena,
ib_rd_data,
// output
ib_pcie_valid,
ob_pcie_valid,
ib_rd_en,
ob_wr_en,
ib_rd_addr,
ob_wr_addr,
ob_wr_data);

parameter DATA_WIDTH = 128;

parameter INIT    = 4'b0000;
parameter RD_INFO = 4'b0001;
parameter RD_KEY1 = 4'b0010;
parameter RD_KEY2 = 4'b0011;
parameter RD_IV   = 4'b0100;
parameter RD_AAD  = 4'b0101;
parameter RD_DATA = 4'b0110;
parameter WR_DATA = 4'b0111;
parameter WR_TAG  = 4'b1000;
parameter WR_INFO = 4'b1001;
parameter WAIT    = 4'b1010;
parameter DONE    = 4'b1011;

input clk;
input rstn;
input ib_ipsec_valid;
input ob_ipsec_valid;
input ib_rd_en;
input encrypt_ena;
input [DATA_WIDTH-1:0] ib_rd_data;

output ib_pcie_valid;
output ob_pcie_valid;
output ob_wr_en;
output [7:0] ib_rd_addr;
output [7:0] ob_wr_addr;
output [DATA_WIDTH-1:0] ob_wr_data;

reg  [DATA_WIDTH-1:0] gcm_aes_data_input;
reg  [DATA_WIDTH-1:0] info_data;
reg  [DATA_WIDTH-1:0] info_data_next;
reg  [DATA_WIDTH-1:0] key_data_1;
reg  [DATA_WIDTH-1:0] key_data_1_pre;
reg  [DATA_WIDTH-1:0] key_data_2;
reg  [DATA_WIDTH-1:0] key_data_2_pre;
wire [DATA_WIDTH-1:0] gcm_aes_data_output;
wire [DATA_WIDTH-1:0] ib_rd_data;
reg  [DATA_WIDTH-1:0] ob_wr_data;
wire [255:0] key_data;
wire [1:0] leng_key;

reg  [3:0] state;
reg  [3:0] next_state;

reg  [10:0] leng_msg;
reg  [10:0] leng_msg_next;
reg  [10:0] leng_ct;
reg  [10:0] leng_ct_next;
reg  [3:0] tag_size;
reg  [3:0] tag_size_next;
reg  [3:0] msg_size;
reg  [3:0] gcm_aes_data_input_size;
wire [3:0] gcm_aes_data_output_size;
reg  [7:0] ib_rd_addr;
reg  [7:0] ib_rd_addr_next;
reg  [7:0] ob_wr_addr;
reg  [7:0] ob_wr_addr_next;

wire clk;
wire rstn;
wire ib_ipsec_valid;
wire ob_ipsec_valid;

wire  ena_aes;
reg  ib_ipsec_valid_d1;
wire is_data_not_ready;
wire rd_data_flag;
wire wr_data_flag;
reg  wr_data_flag_d1;
reg  wr_data_flag_d2;
reg  wr_data_flag_d3;
reg  wr_data_flag_d4;
wire wr_tag_flag;
reg  wr_tag_flag_d1;
reg  wr_tag_flag_d2;
reg  wr_tag_flag_d3;
reg  wr_tag_flag_d4;
reg  wr_info_flag;
reg  wr_info_flag_d1;
reg  wr_info_flag_d2;
reg  wr_info_flag_d3;
reg  wr_info_flag_d4;
reg  key_ena;
reg  iv_ena;
reg  aad_msg_ena;
reg  gcm_aes_data_input_type;
reg  is_last_word;
reg  ib_pcie_valid;
reg  ob_pcie_valid;
wire ob_wr_en;
wire ib_rd_en;

assign rd_data_flag = ~is_data_not_ready;
assign ena_aes = ~ib_ipsec_valid_d1 & ib_ipsec_valid;
assign ib_rd_en = 1'b1;

//  start design

always@ (posedge clk or negedge rstn) begin
	if (!rstn) begin
		state <= INIT;
	end 
	else begin
		state <= next_state;
	end
end
// state controller
always@ (*) begin
	case (state)
		INIT:begin 
			if (ena_aes) begin
				next_state = RD_INFO;
			end
			else begin
				next_state = state;
			end
		end
		RD_INFO:begin
			next_state = RD_KEY1;
		end
		RD_KEY1:begin
			next_state = RD_KEY2;
		end
		RD_KEY2:begin
			next_state = RD_IV;
		end
		RD_IV: begin
			if (rd_data_flag) begin
				next_state = RD_AAD;
			end
			else begin
				next_state = state;
			end
		end
		RD_AAD:begin
			if (rd_data_flag) begin
				next_state = RD_DATA;
			end
			else begin
				next_state = state;
			end
		end
		RD_DATA:begin
			if (wr_data_flag) begin
				next_state = WR_DATA;
			end
			else begin
				next_state = state;
			end
		end
		WR_DATA:begin
			if (rd_data_flag) begin
				next_state = RD_DATA;
			end
			else if (wr_tag_flag)  begin
				next_state = WR_TAG;
			end
			else begin
				next_state = state;
			end
		end 
		WR_TAG:begin
			if (wr_tag_flag_d4) begin
				next_state = WR_INFO;
			end
			else begin
				next_state = state;
			end
		end
		WR_INFO:begin
			if (wr_info_flag_d4) begin
				next_state = WAIT;
			end
			else begin
				next_state = state;
			end
		end
		WAIT:begin
			if (ob_ipsec_valid) begin
				next_state = DONE;
			end
			else begin
				next_state = state;
			end
		end
		DONE:begin
			if (ena_aes) begin
				next_state = RD_INFO;
			end
			else begin
				next_state = state;
			end
		end
		default:begin
			next_state = state;
		end
	endcase
end
// data controller
always@ (*) begin
	case (state)
		INIT:begin 
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b1;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = 128'd0;
      key_data_2          = 128'd0;
      info_data_next      = 128'd0;	
			ib_rd_addr_next = 8'd1;
			ob_wr_addr_next = 8'd0;
      leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		RD_INFO:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = 128'd0;
      key_data_2          = 128'd0;
      info_data_next      = ib_rd_data;	
			ib_rd_addr_next = 8'd2;
			ob_wr_addr_next = 8'd0;
      leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		RD_KEY1:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = ib_rd_data;	
      key_data_2          = 128'd0;
      info_data_next      = info_data;	
			ib_rd_addr_next = 8'd3;
			ob_wr_addr_next = 8'd0;
      leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		RD_KEY2:begin
      key_ena      = 1'b1;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = key_data_1_pre;
      key_data_2          = ib_rd_data;	
      info_data_next      = info_data;	
		  ib_rd_addr_next = 8'd4;
			ob_wr_addr_next = 8'd0;
      leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		RD_IV: begin
      key_ena      = 1'b0;
      iv_ena       = 1'b1;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = ib_rd_data;
      key_data_1          = key_data_1_pre;
      key_data_2          = key_data_2_pre;
      info_data_next      = info_data;	
			if (rd_data_flag) begin
			 	ib_rd_addr_next = 8'd5;
			end
			else begin 
			 	ib_rd_addr_next = 8'd4;
			end
			ob_wr_addr_next = 8'd0;
      leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		RD_AAD:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b1;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b1;
      gcm_aes_data_input_size = info_data[7:4] - 1;
      gcm_aes_data_input  = ib_rd_data;
      key_data_1          = key_data_1_pre;
      key_data_2          = key_data_2_pre;
      info_data_next      = info_data;	
			ib_rd_addr_next = 8'd6;
			ob_wr_addr_next = 8'd1;
			leng_msg_next = info_data[18:8];
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		RD_DATA:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b1;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = msg_size;
      gcm_aes_data_input  = ib_rd_data;
      key_data_1          = key_data_1_pre;
      key_data_2          = key_data_2_pre;
      info_data_next      = info_data;	
			ib_rd_addr_next = ib_rd_addr;
			ob_wr_addr_next = ob_wr_addr;
			leng_msg_next = leng_msg;
      leng_ct_next  = leng_ct;
      tag_size_next = 4'd0;
		end
		WR_DATA:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = msg_size;
      gcm_aes_data_input  = ib_rd_data;
      key_data_1          = key_data_1_pre;
      key_data_2          = key_data_2_pre;
      info_data_next      = info_data;	
			if (rd_data_flag) begin
			 	ib_rd_addr_next = ib_rd_addr + 1;
				leng_msg_next = leng_msg - 16;
			end
			else begin 
			 	ib_rd_addr_next = ib_rd_addr;
				leng_msg_next = leng_msg;
			end
			if (wr_data_flag_d1) begin
				ob_wr_addr_next = ob_wr_addr + 1;
        leng_ct_next  = leng_ct + gcm_aes_data_output_size + 1;
			end
			else begin 
				ob_wr_addr_next = ob_wr_addr;
        leng_ct_next  = leng_ct;
			end
      tag_size_next = 4'd0;
		end 
		WR_TAG:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = msg_size;
      gcm_aes_data_input  = ib_rd_data;
      key_data_1          = key_data_1_pre;
      key_data_2          = key_data_2_pre;
      info_data_next      = info_data;	
			ib_rd_addr_next = ib_rd_addr;
			if (wr_tag_flag_d1) begin
				ob_wr_addr_next = ob_wr_addr + 1;
        tag_size_next = gcm_aes_data_output_size + 1;        
			end
			else begin 
				ob_wr_addr_next = ob_wr_addr;
        tag_size_next = tag_size;
			end
			leng_msg_next = leng_msg;
      leng_ct_next  = leng_ct;
		end
		WR_INFO:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = 128'd0;
      key_data_2          = 128'd0;
      info_data_next      = 128'd0;	
			ib_rd_addr_next = 8'd0;
			if (wr_info_flag_d1) begin
				ob_wr_addr_next = 8'd1;
			end
			else begin 
				ob_wr_addr_next = ob_wr_addr;
			end
			leng_msg_next = 11'd0;
      leng_ct_next  = leng_ct;
      tag_size_next = tag_size;
		end
		
		WAIT:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b1;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = 128'd0;
      key_data_2          = 128'd0;
      info_data_next      = 128'd0;	
			ib_rd_addr_next = 8'd1;
			ob_wr_addr_next = 8'd0;
			leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		
		DONE:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b1;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = 128'd0;
      key_data_2          = 128'd0;
      info_data_next      = 128'd0;	
			ib_rd_addr_next = 8'd1;
			ob_wr_addr_next = 8'd0;
			leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
		end
		
		default:begin
      key_ena      = 1'b0;
      iv_ena       = 1'b0;
      aad_msg_ena  = 1'b0;
      ib_pcie_valid = 1'b0;
      ob_pcie_valid = 1'b0;
      gcm_aes_data_input_type = 1'b0;
      gcm_aes_data_input_size = 4'd0;
      gcm_aes_data_input  = 128'd0;
      key_data_1          = 128'd0;
      key_data_2          = 128'd0;
      info_data_next      = 128'd0;	
			ib_rd_addr_next = 8'd0;
			ob_wr_addr_next = 8'd0;
			leng_msg_next = 11'd0;
      leng_ct_next  = 11'd0;
      tag_size_next = 4'd0;
			end
	endcase
end

always@ (*) begin
	if (leng_msg == 16) begin
		msg_size = 4'd15;
    is_last_word = 1'b1;
	end
	else if (leng_msg > 16) begin
		msg_size = 4'd15;
    is_last_word = 1'b0;
	end
	else begin
		msg_size = leng_msg[3:0] - 1;
    if (state==WR_DATA) begin
      is_last_word = 1'b1;
    end
    else begin 
      is_last_word = 1'b0;
    end
	end
end

always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin 
  	leng_msg <= 11'd0;
  	leng_ct  <= 11'd0;
    tag_size <= 4'd0;
  	ib_rd_addr <= 8'b0;
    ob_wr_addr <= 8'b0;
    key_data_1_pre <= 128'd0;
    key_data_2_pre <= 128'd0;
    info_data    <= 128'd0;
    ib_ipsec_valid_d1 <= 1'b0;
  
    wr_tag_flag_d1 <= 1'b0;
    wr_tag_flag_d2 <= 1'b0;
    wr_tag_flag_d3 <= 1'b0;
    wr_tag_flag_d4 <= 1'b0;
  
    wr_data_flag_d1 <= 1'b0;
    wr_data_flag_d2 <= 1'b0;
    wr_data_flag_d3 <= 1'b0;
    wr_data_flag_d4 <= 1'b0;
  
    wr_info_flag    <= 1'b0;
    wr_info_flag_d1 <= 1'b0;
    wr_info_flag_d2 <= 1'b0;
    wr_info_flag_d3 <= 1'b0;
    wr_info_flag_d4 <= 1'b0;
    
  end
  else begin 
  	leng_msg <= leng_msg_next;
  	leng_ct  <= leng_ct_next;
    tag_size <= tag_size_next;
  	ib_rd_addr <= ib_rd_addr_next;
    ob_wr_addr <= ob_wr_addr_next;
    key_data_1_pre <= key_data_1;
    key_data_2_pre <= key_data_2;
    info_data <= info_data_next;
    ib_ipsec_valid_d1 <= ib_ipsec_valid;
  
    wr_tag_flag_d1 <= wr_tag_flag;
    wr_tag_flag_d2 <= wr_tag_flag_d1;
    wr_tag_flag_d3 <= wr_tag_flag_d2;
    wr_tag_flag_d4 <= wr_tag_flag_d3;
  
    wr_data_flag_d1 <= wr_data_flag;
    wr_data_flag_d2 <= wr_data_flag_d1;
    wr_data_flag_d3 <= wr_data_flag_d2;
    wr_data_flag_d4 <= wr_data_flag_d3;
  
    wr_info_flag <= wr_tag_flag_d4;
    wr_info_flag_d1 <= wr_info_flag;
    wr_info_flag_d2 <= wr_info_flag_d1;
    wr_info_flag_d3 <= wr_info_flag_d2;
    wr_info_flag_d4 <= wr_info_flag_d3;
    
  end
end

assign ob_wr_en = wr_tag_flag_d3 | wr_data_flag_d3 | wr_info_flag_d3 ;

always@ (*) begin
  if (state == WR_INFO) begin 
    ob_wr_data = {113'b0,leng_ct,tag_size};
  end
  else if (state == DONE) begin
    ob_wr_data = 128'd0;
  end
  else begin 
    case (gcm_aes_data_output_size)
    	0: ob_wr_data  = {120'b0,gcm_aes_data_output[127:120]};
    	1: ob_wr_data  = {112'b0,gcm_aes_data_output[127:112]};
    	2: ob_wr_data  = {104'b0,gcm_aes_data_output[127:104]};
    	3: ob_wr_data  = {96'b0,gcm_aes_data_output[127:96]};
    	4: ob_wr_data  = {88'b0,gcm_aes_data_output[127:88]};
    	5: ob_wr_data  = {80'b0,gcm_aes_data_output[127:80]};
    	6: ob_wr_data  = {72'b0,gcm_aes_data_output[127:72]};
    	7: ob_wr_data  = {64'b0,gcm_aes_data_output[127:64]};
    	8: ob_wr_data  = {56'b0,gcm_aes_data_output[127:56]};
    	9: ob_wr_data  = {48'b0,gcm_aes_data_output[127:48]};
    	10: ob_wr_data  = {40'b0,gcm_aes_data_output[127:40]};
    	11: ob_wr_data  = {32'b0,gcm_aes_data_output[127:32]};
    	12: ob_wr_data  = {24'b0,gcm_aes_data_output[127:24]};
    	13: ob_wr_data  = {16'b0,gcm_aes_data_output[127:16]};
    	14: ob_wr_data  = {8'b0,gcm_aes_data_output[127:8]};
    	default: ob_wr_data = gcm_aes_data_output;
    endcase
  end
end

assign leng_key = info_data[1:0];
assign key_data = {key_data_1,key_data_2};

gcm_aes_core gcm_aes_1 (.clk(clk),.rstn(rstn), 
.key_data(key_data),  
.leng_key(leng_key),
.gcm_aes_data_input(gcm_aes_data_input),  
.is_data_not_ready(is_data_not_ready),  
.gcm_aes_data_input_size(gcm_aes_data_input_size), 
.gcm_aes_data_input_type(gcm_aes_data_input_type),  
.aad_msg_ena(aad_msg_ena),  
.key_ena(key_ena),  
.iv_ena(iv_ena),  
.is_last_word(is_last_word),
.encrypt_ena(encrypt_ena),
.gcm_aes_data_output(gcm_aes_data_output), 
.gcm_aes_data_output_size(gcm_aes_data_output_size),
.wr_data_flag(wr_data_flag), 
.wr_tag_flag(wr_tag_flag)         
);


endmodule
