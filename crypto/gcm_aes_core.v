
module gcm_aes_core(
  clk,
  rstn,
  gcm_aes_data_input,
  aad_msg_ena,
  gcm_aes_data_input_type,
  is_last_word,
  gcm_aes_data_input_size,
  key_ena,  		
  iv_ena,
  key_data,
  leng_key,
  encrypt_ena,
    // output
  is_data_not_ready,
  gcm_aes_data_output,
  wr_data_flag,
  gcm_aes_data_output_size,
  wr_tag_flag
);

parameter DATA_WIDTH = 128;

parameter IDLE          = 10'd0;
parameter ENCRYPT_0     = 10'd1;
parameter INIT_COUNTER  = 10'd2;
parameter ENCRYPT_Y0    = 10'd3;
parameter DATA_ACCEPT   = 10'd8;
parameter GFM_MULT      = 10'd16;
parameter INC_COUNTER   = 10'd32;
parameter M_ENCRYPT     = 10'd64;
parameter PRE_TAG_CALC  = 10'd128;
parameter TAG_CALC      = 10'd256;
  
input clk;
input rstn;
input [DATA_WIDTH-1:0] gcm_aes_data_input;
input aad_msg_ena;
input gcm_aes_data_input_type;
input is_last_word;
input [3:0] gcm_aes_data_input_size;
/* Control Input Interface */
input key_ena;  			//acts as start signal
input iv_ena;
input encrypt_ena;
input [255:0] key_data;
input [1:0] leng_key;
/* Data Output Interface */
output reg is_data_not_ready;
output reg [DATA_WIDTH-1:0] gcm_aes_data_output;
output reg wr_data_flag;
output reg [3:0] gcm_aes_data_output_size;
/* Tag output Interface */
output reg  wr_tag_flag;

reg  [3:0] aad_size; 
wire [3:0] pre_aad_size; 
wire [3:0] pre_gcm_aes_data_output_size;
//actual registers
reg  [DATA_WIDTH-1:0] H; 
reg  [DATA_WIDTH-1:0] next_H; 
reg  [DATA_WIDTH-1:0] EKY_0; 
reg  [DATA_WIDTH-1:0] next_EKY_0; 
reg  [DATA_WIDTH-1:0] Yi; 
wire [DATA_WIDTH-1:0] pre_Yi; 
reg  [DATA_WIDTH-1:0] Yi_init;
reg  [DATA_WIDTH-1:0] gfm_result;
wire [DATA_WIDTH-1:0] pre_gfm_result;
reg  [63:0] enc_byte_count;
wire [63:0] pre_enc_byte_count;
reg  [63:0] aad_byte_count;
wire [63:0] pre_aad_byte_count;
reg  next_wr_data_flag;
reg  next_wr_tag_flag;
reg  Out_last_word;
reg  [DATA_WIDTH-1:0] gcm_aes_data_input_start;
reg  [DATA_WIDTH-1:0] next_gcm_aes_data_output_start;
reg  [DATA_WIDTH-1:0] next_gcm_aes_data_output;
wire [DATA_WIDTH-1:0] pre_gcm_aes_data_output;
reg  [DATA_WIDTH-1:0] next_Tag_data;
reg  [DATA_WIDTH-1:0] aes_text_in;
reg  aes_key_flag;

wire aes_done;
wire [DATA_WIDTH-1:0] aes_text_out;
  //control signals
reg  mux_aes_text_in_sel;
reg  mux_yi_sel;
  //gfm signals
reg  [DATA_WIDTH-1:0] v_in; 
reg  [DATA_WIDTH-1:0] z_in;
reg  [DATA_WIDTH-1:0] b_in;
reg  [DATA_WIDTH-1:0] gfm_input1;
wire [DATA_WIDTH-1:0] z_out;
wire [DATA_WIDTH-1:0] v_out;
reg  [3:0] gfm_count;
wire [3:0] pre_gfm_count;
//write enables
reg  we_y; 
reg  we_lenA;
reg  we_lenC; 
reg  start_gfm_count;
//FSM signals
reg  [9:0] state;
reg  [9:0] next_state;
//wire encrypt_ena;

//assign encrypt_ena = 1'b0;

// OK
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    aad_size <= 4'd0;
  end
  else begin
    if (gcm_aes_data_input_type == 1) begin
      aad_size <= gcm_aes_data_input_size;
    end
    else begin
      aad_size <= pre_aad_size;
    end
  end
end
assign pre_aad_size = aad_size;
 
  
// AAD hoac Plain_text Message duoc chia thanh nhieu block 16 byte (128bits)
// gcm_aes_data_input : la full block du 16 byte
// block LSB co the khong du byte tuc la gcm_aes_data_input_start
// gcm_aes_data_input_size cho biet len cua block

always@ (*) begin
  case(gcm_aes_data_input_size)
    0:  // 1 valid byte
      begin
        gcm_aes_data_input_start = ({gcm_aes_data_input[7:0],120'b0});
      end
    1: //2 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[15:0],112'b0};
      end
    2: //3 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[23:0],104'b0};
      end
    3: //4 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[31:0],96'b0};
      end
    4: //5 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[39:0],88'b0};
      end
    5: //6 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[47:0],80'b0};
      end
    6: //7 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[55:0],72'b0};
      end
    7: //8 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[63:0],64'b0};
      end
    8:
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[71:0],56'b0};
      end
    9:
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[79:0],48'b0};
      end
    10:
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[87:0],40'b0};
      end
    11:
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[95:0],32'b0};
      end
    12:
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[103:0],24'b0};
      end
    13:	//14 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[111:0],16'b0};
      end
    14: //15 valid bytes
      begin
        gcm_aes_data_input_start = {gcm_aes_data_input[119:0],8'b0};
      end
    default: 
      begin
        gcm_aes_data_input_start = 128'd0;
      end
  endcase 
end

always@ (*) begin      
  case(gcm_aes_data_input_size)
    0:  //1 valid byte
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:120],120'b0};
      end
    1:// 2 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:112],112'b0};
      end
    2:// 3 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:104],104'b0};
      end
    3:// 4 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:96],96'b0};
      end
    4:// 5 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:88],88'b0};
      end
    5:// 6 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:80],80'b0};
      end
    6:// 7 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:72],72'b0};
      end
    7:// 8 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:64],64'b0};
      end
    8:// 9 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:56],56'b0};
      end
    9:// 10 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:48],48'b0};
      end
    10:// 11 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:40],40'b0};
      end
    11:  // 12 valid byte
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:32],32'b0};
      end
    12:// 13 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:24],24'b0};
      end
    13:// 14 valid bytes
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:16],16'b0};
      end
    14:  // 15 valid byte
      begin
        next_gcm_aes_data_output_start = {next_gcm_aes_data_output[127:8],8'b0};
      end
    default: 
      begin
        next_gcm_aes_data_output_start = 128'd0;    // tuong ung cho block thieu byte
      end
  endcase // case (gcm_aes_data_input_size)
end
    
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    state   <= IDLE;
    H       <= 128'd0;
    EKY_0   <= 128'd0;
  end
  else begin
    H       <= next_H;
    EKY_0   <= next_EKY_0;
    state   <= next_state;
  end
end

//out data
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin 
    gcm_aes_data_output      <= 128'd0;
    gcm_aes_data_output_size <= 4'd0;
  end
  else begin 
    if (next_wr_data_flag & ~next_wr_tag_flag) begin
      gcm_aes_data_output 		 <= next_gcm_aes_data_output;
      gcm_aes_data_output_size <= gcm_aes_data_input_size;
    end
    else if (next_wr_tag_flag) begin
	    gcm_aes_data_output      <= next_Tag_data;
      gcm_aes_data_output_size <= aad_size;
    end
    else begin
      gcm_aes_data_output_size <= pre_gcm_aes_data_output_size;
      gcm_aes_data_output      <= pre_gcm_aes_data_output;
    end
  end 
end
assign pre_gcm_aes_data_output = gcm_aes_data_output;
assign pre_gcm_aes_data_output_size = gcm_aes_data_output_size;
  
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    wr_tag_flag  <= 1'b0;
    wr_data_flag <= 1'b0;
  end
  else begin
    wr_tag_flag  <= next_wr_tag_flag;
    wr_data_flag <= next_wr_data_flag;
  end
end

 //aes text_in
always@ (*) begin
  case(mux_aes_text_in_sel)
    0: aes_text_in = 128'd0;  
    1: aes_text_in = Yi;
  endcase
end  
  //initializing IV data
always@ (*) begin
  if (iv_ena) begin
    Yi_init = gcm_aes_data_input; // get IV data
  end
  else begin
    Yi_init = 128'd0;
  end
end 
//FSM

always@ (*) begin
  case (state) 

    IDLE: begin
      if (key_ena) begin
        next_state = ENCRYPT_0;
      end
      else begin
        next_state = state;
      end
    end

    ENCRYPT_0: begin
      if (aes_done) begin
        if (iv_ena) begin
          next_state = INIT_COUNTER;
        end
        else begin
          next_state = state;
        end
      end
      else begin
        next_state = state;
      end
    end 

    INIT_COUNTER: begin
			   // figure out how to launch a GCM op here
				// or go to next state which launches GCM op
      next_state = ENCRYPT_Y0;
    end

    ENCRYPT_Y0: begin
      if (aes_done) begin
        next_state = DATA_ACCEPT;
      end
      else begin
        next_state = state;
      end
    end

    DATA_ACCEPT: begin
      if (aad_msg_ena & gcm_aes_data_input_type) begin  //AAD  : type =1 add type = 0 message, vld = 1 hoac AAD hoac message;  vld = 0 >> nonce
        if (gcm_aes_data_input_size == 4'd15) begin // block  full
          next_state     = GFM_MULT;
        end
        else begin                        // block thieu
          next_state     = GFM_MULT;
        end
      end
      else if (aad_msg_ena & ~gcm_aes_data_input_type) begin //ENC message
        next_state = INC_COUNTER;
      end
      else begin
        next_state = state;
      end
    end // case: AAD_ACCEPT

    INC_COUNTER: begin
      next_state = M_ENCRYPT;
    end

    GFM_MULT: begin //  ton 1 chu ky cho 1 block
      if (gfm_count == 4'd7) begin
        if (~is_last_word) begin
          next_state = DATA_ACCEPT;
        end
        else begin
          next_state = PRE_TAG_CALC;
        end
      end
      else begin
        next_state = state;
      end
    end 

    M_ENCRYPT: begin
      if (aes_done) begin
        next_state = GFM_MULT;
      end
      else begin
        next_state = state;
      end
    end // case: M_ACCEPT

    PRE_TAG_CALC: begin
      next_state = TAG_CALC;
    end

    TAG_CALC: begin
      if (gfm_count == 4'd7) begin
        next_state = IDLE;
      end
      else begin
        next_state = state;
      end
    end

    default: begin
      next_state = state;
    end
        
  endcase    
end

always@ (*) begin
  case(state)

    IDLE: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      mux_yi_sel = 1'b0;
      start_gfm_count = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      if (key_ena) begin
        aes_key_flag = 1'b1;
        mux_aes_text_in_sel = 1'b0;
      end 
      else begin
        aes_key_flag = 1'b0;
        mux_aes_text_in_sel = 1'b0; 
      end
    end

    ENCRYPT_0: begin
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      start_gfm_count = 1'b0;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      if (aes_done) begin
        next_H = aes_text_out;
        if (iv_ena) begin
          we_y = 1'b1;
        end
        else begin 
          we_y = 1'b0;
        end    
      end
      else begin
        next_H = H;
        we_y = 1'b0;
      end  
    end // case: ENCRYPT_0

    INIT_COUNTER: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      mux_yi_sel = 1'b0;
      start_gfm_count = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
			   // figure out how to launch a GCM op here,
				// or go to next state which launches GCM op
      mux_aes_text_in_sel = 1'b1;
      aes_key_flag = 1'b1;
    end

    ENCRYPT_Y0: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      start_gfm_count = 1'b0;
      next_H = H;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      if (aes_done) begin
        next_EKY_0 = aes_text_out;
      end
      else begin
        next_EKY_0 = EKY_0;
      end
    end

    DATA_ACCEPT: begin
      we_lenC = 1'b0;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      is_data_not_ready = 1'b0;
      if (aad_msg_ena & gcm_aes_data_input_type) begin  //AAD  : type =1 add type = 0 message, vld = 1 hoac AAD hoac message;  vld = 0 >> nonce
        if (gcm_aes_data_input_size == 4'd15) begin// block  full
          we_lenA      = 1'b1;
          gfm_input1    = gcm_aes_data_input; 
          start_gfm_count = 1'b1;
        end
        else begin                        // block thieu
          we_lenA      = 1'b1;
          gfm_input1    = gcm_aes_data_input_start; 
          start_gfm_count = 1'b1;
        end
        we_y    = 1'b0;
        mux_yi_sel = 1'b0; 
      end
      else if (aad_msg_ena & ~gcm_aes_data_input_type) begin //ENC message
        we_lenA = 1'b0;
        gfm_input1 = 128'd0;
        start_gfm_count = 1'b0;
        mux_yi_sel = 1'b1;
        we_y = 1'b1;
      end
      else begin
        we_lenA = 1'b0;
        gfm_input1 = 128'd0;
        start_gfm_count = 1'b0;
        we_y    = 1'b0;
        mux_yi_sel = 1'b0; 
      end
    end // case: AAD_ACCEPT

    INC_COUNTER: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      is_data_not_ready = 1'b1;
      mux_yi_sel = 1'b0;
      start_gfm_count = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      we_lenC = 1'b1;
      mux_aes_text_in_sel = 1'b1;
      aes_key_flag = 1'b1;
    end

    GFM_MULT: begin//  ton 1 chu ky cho 1 block
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      if (gfm_count == 4'd7) begin
        start_gfm_count = 1'b0;
      end
      else begin
        start_gfm_count = 1'b0;
      end
    end

    M_ENCRYPT: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_tag_flag   = 1'b0;
      next_Tag_data = 128'd0;
      if (aes_done) begin
        if (gcm_aes_data_input_size == 4'd15) begin // block full byte
          next_gcm_aes_data_output = aes_text_out ^ gcm_aes_data_input;
          next_wr_data_flag  = 1'b1;
          gfm_input1 = (encrypt_ena) ? next_gcm_aes_data_output : gcm_aes_data_input ; //gcm_aes_data_input to do fix tag issue for decrypt
        end
        else begin     // block thieu byte
          next_gcm_aes_data_output = aes_text_out ^ gcm_aes_data_input_start;
          next_wr_data_flag  = 1'b1;
          gfm_input1 = (encrypt_ena) ? next_gcm_aes_data_output_start : gcm_aes_data_input_start ;
        end
        start_gfm_count = 1'b1;
      end
      else begin
        next_gcm_aes_data_output = 128'd0;
        next_wr_data_flag  = 1'b0;			
        gfm_input1 = 128'd0;
        start_gfm_count = 1'b0;
      end
    end // case: M_ACCEPT

    PRE_TAG_CALC: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
      gfm_input1 = {(aad_byte_count << 3),(enc_byte_count << 3)};
      start_gfm_count = 1'b1;
    end

    TAG_CALC: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      if (gfm_count == 4'd7) begin
        start_gfm_count = 1'b0;
        next_Tag_data = EKY_0 ^ z_out;
        next_wr_tag_flag  = 1'b1;
      end
      else begin 
        start_gfm_count = 1'b0;
        next_Tag_data = 128'd0;
        next_wr_tag_flag   = 1'b0;
      end
    end

    default: begin
      we_y    = 1'b0;
      we_lenA = 1'b0;
      we_lenC = 1'b0;
      is_data_not_ready = 1'b1;
      aes_key_flag = 1'b0;
      mux_aes_text_in_sel = 1'b0;
      mux_yi_sel = 1'b0;
      start_gfm_count = 1'b0;
      next_H = H;
      next_EKY_0 = EKY_0;
      next_wr_data_flag  = 1'b0;			
      next_wr_tag_flag   = 1'b0;
      gfm_input1 = 128'd0;
      next_gcm_aes_data_output = 128'd0;
      next_Tag_data = 128'd0;
    end
        
  endcase
end

// register 

always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    Yi <= 128'd0;
  end
  else begin
    if (we_y) begin
      case(mux_yi_sel)
        0: Yi <= Yi_init;
        1: Yi <= pre_Yi + 1;
      endcase
    end
    else begin
      Yi <= pre_Yi;
    end
  end 
end
assign pre_Yi = Yi;

always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    enc_byte_count <= 64'd0;
  end
  else if (we_lenC) begin
    enc_byte_count <= pre_enc_byte_count + gcm_aes_data_input_size + 1;
  end
  else begin
    enc_byte_count <= pre_enc_byte_count;
  end
end
assign pre_enc_byte_count = enc_byte_count;
 
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    aad_byte_count <= 64'd0;
  end
  else if (we_lenA) begin
    aad_byte_count <= pre_aad_byte_count + gcm_aes_data_input_size + 1;
  end
  else begin
    aad_byte_count <= pre_aad_byte_count;
  end
end
assign pre_aad_byte_count = aad_byte_count;

always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin 
    gfm_count <= 4'd0;
  end
  else begin
    if (start_gfm_count) begin
      gfm_count <= 4'd0;
    end
    else if (pre_gfm_count != 4'd7) begin
      gfm_count <= pre_gfm_count + 1;
    end
    else begin
      gfm_count <= pre_gfm_count;
    end
  end
end
assign pre_gfm_count = gfm_count;

always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    gfm_result <= 128'd0;
  end
  else begin 
    if (key_ena) begin
      gfm_result <= 128'd0;
    end
    else if (gfm_count == 4'd7) begin
      gfm_result <= z_out;
    end
    else begin
      gfm_result <= pre_gfm_result;
    end
  end
end
assign pre_gfm_result = gfm_result;
  
// GHASH register
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    v_in <= 128'd0;
    z_in <= 128'd0;
    b_in <= 128'd0;
  end
  else begin
    if (start_gfm_count) begin
      v_in  <= H; 
      //z_in  <= {DATA_WIDTH{1'b0}};
      z_in <= 128'd0;
      b_in  <= gfm_input1 ^ gfm_result;
    end
    else begin
      v_in <= v_out;
      z_in <= z_out;
      b_in <= b_in << 16;
    end
  end
end

// GHash module  
gfm128_16  ghash_01(
  // Inputs
  .v_in              (v_in[127:0]),      
  .z_in              (z_in[127:0]),      
  .b_in              (b_in[127:112]),
  // Outputs
  .v_out             (v_out[127:0]),     
  .z_out             (z_out[127:0])      
);    

// aes module
aes_cipher_top  aes_enc_core_01 (
  // Inputs
  .clk                 (clk),      
  .rstn                (rstn),    
  .aes_key_flag        (aes_key_flag),  
  .key                 (key_data), 
  .leng_key            (leng_key),
  .text_in             (aes_text_in[127:0]),
  // Outputs
  .done                (aes_done),      
  .text_out            (aes_text_out[127:0])
); 

endmodule
