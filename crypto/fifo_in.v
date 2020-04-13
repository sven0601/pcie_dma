module fifo_in(clk,rstn,wr_ena,data_in,data_out,addr_in,addr_out);
parameter DATA_WIDTH = 128;
output reg [DATA_WIDTH-1:0] data_out;
input wire [DATA_WIDTH-1:0] data_in;
input wire [7:0] addr_in;
input wire [7:0] addr_out;
input clk;
input rstn;
input wr_ena;
reg [99:0] addr_in_en;
reg [DATA_WIDTH-1:0] data_0;
reg [DATA_WIDTH-1:0] data_1;
reg [DATA_WIDTH-1:0] data_2;
reg [DATA_WIDTH-1:0] data_3;
reg [DATA_WIDTH-1:0] data_4;
reg [DATA_WIDTH-1:0] data_5;
reg [DATA_WIDTH-1:0] data_6;
reg [DATA_WIDTH-1:0] data_7;
reg [DATA_WIDTH-1:0] data_8;
reg [DATA_WIDTH-1:0] data_9;
reg [DATA_WIDTH-1:0] data_10;
reg [DATA_WIDTH-1:0] data_11;
reg [DATA_WIDTH-1:0] data_12;
reg [DATA_WIDTH-1:0] data_13;
reg [DATA_WIDTH-1:0] data_14;
reg [DATA_WIDTH-1:0] data_15;
reg [DATA_WIDTH-1:0] data_16;
reg [DATA_WIDTH-1:0] data_17;
reg [DATA_WIDTH-1:0] data_18;
reg [DATA_WIDTH-1:0] data_19;
reg [DATA_WIDTH-1:0] data_20;
reg [DATA_WIDTH-1:0] data_21;
reg [DATA_WIDTH-1:0] data_22;
reg [DATA_WIDTH-1:0] data_23;
reg [DATA_WIDTH-1:0] data_24;
reg [DATA_WIDTH-1:0] data_25;
reg [DATA_WIDTH-1:0] data_26;
reg [DATA_WIDTH-1:0] data_27;
reg [DATA_WIDTH-1:0] data_28;
reg [DATA_WIDTH-1:0] data_29;
reg [DATA_WIDTH-1:0] data_30;
reg [DATA_WIDTH-1:0] data_31;
reg [DATA_WIDTH-1:0] data_32;
reg [DATA_WIDTH-1:0] data_33;
reg [DATA_WIDTH-1:0] data_34;
reg [DATA_WIDTH-1:0] data_35;
reg [DATA_WIDTH-1:0] data_36;
reg [DATA_WIDTH-1:0] data_37;
reg [DATA_WIDTH-1:0] data_38;
reg [DATA_WIDTH-1:0] data_39;
reg [DATA_WIDTH-1:0] data_40;
reg [DATA_WIDTH-1:0] data_41;
reg [DATA_WIDTH-1:0] data_42;
reg [DATA_WIDTH-1:0] data_43;
reg [DATA_WIDTH-1:0] data_44;
reg [DATA_WIDTH-1:0] data_45;
reg [DATA_WIDTH-1:0] data_46;
reg [DATA_WIDTH-1:0] data_47;
reg [DATA_WIDTH-1:0] data_48;
reg [DATA_WIDTH-1:0] data_49;
reg [DATA_WIDTH-1:0] data_50;
reg [DATA_WIDTH-1:0] data_51;
reg [DATA_WIDTH-1:0] data_52;
reg [DATA_WIDTH-1:0] data_53;
reg [DATA_WIDTH-1:0] data_54;
reg [DATA_WIDTH-1:0] data_55;
reg [DATA_WIDTH-1:0] data_56;
reg [DATA_WIDTH-1:0] data_57;
reg [DATA_WIDTH-1:0] data_58;
reg [DATA_WIDTH-1:0] data_59;
reg [DATA_WIDTH-1:0] data_60;
reg [DATA_WIDTH-1:0] data_61;
reg [DATA_WIDTH-1:0] data_62;
reg [DATA_WIDTH-1:0] data_63;
reg [DATA_WIDTH-1:0] data_64;
reg [DATA_WIDTH-1:0] data_65;
reg [DATA_WIDTH-1:0] data_66;
reg [DATA_WIDTH-1:0] data_67;
reg [DATA_WIDTH-1:0] data_68;
reg [DATA_WIDTH-1:0] data_69;
reg [DATA_WIDTH-1:0] data_70;
reg [DATA_WIDTH-1:0] data_71;
reg [DATA_WIDTH-1:0] data_72;
reg [DATA_WIDTH-1:0] data_73;
reg [DATA_WIDTH-1:0] data_74;
reg [DATA_WIDTH-1:0] data_75;
reg [DATA_WIDTH-1:0] data_76;
reg [DATA_WIDTH-1:0] data_77;
reg [DATA_WIDTH-1:0] data_78;
reg [DATA_WIDTH-1:0] data_79;
reg [DATA_WIDTH-1:0] data_80;
reg [DATA_WIDTH-1:0] data_81;
reg [DATA_WIDTH-1:0] data_82;
reg [DATA_WIDTH-1:0] data_83;
reg [DATA_WIDTH-1:0] data_84;
reg [DATA_WIDTH-1:0] data_85;
reg [DATA_WIDTH-1:0] data_86;
reg [DATA_WIDTH-1:0] data_87;
reg [DATA_WIDTH-1:0] data_88;
reg [DATA_WIDTH-1:0] data_89;
reg [DATA_WIDTH-1:0] data_90;
reg [DATA_WIDTH-1:0] data_91;
reg [DATA_WIDTH-1:0] data_92;
reg [DATA_WIDTH-1:0] data_93;
reg [DATA_WIDTH-1:0] data_94;
reg [DATA_WIDTH-1:0] data_95;
reg [DATA_WIDTH-1:0] data_96;
reg [DATA_WIDTH-1:0] data_97;
reg [DATA_WIDTH-1:0] data_98;
reg [DATA_WIDTH-1:0] data_99;
wire [DATA_WIDTH-1:0] next_data_0;
wire [DATA_WIDTH-1:0] next_data_1;
wire [DATA_WIDTH-1:0] next_data_2;
wire [DATA_WIDTH-1:0] next_data_3;
wire [DATA_WIDTH-1:0] next_data_4;
wire [DATA_WIDTH-1:0] next_data_5;
wire [DATA_WIDTH-1:0] next_data_6;
wire [DATA_WIDTH-1:0] next_data_7;
wire [DATA_WIDTH-1:0] next_data_8;
wire [DATA_WIDTH-1:0] next_data_9;
wire [DATA_WIDTH-1:0] next_data_10;
wire [DATA_WIDTH-1:0] next_data_11;
wire [DATA_WIDTH-1:0] next_data_12;
wire [DATA_WIDTH-1:0] next_data_13;
wire [DATA_WIDTH-1:0] next_data_14;
wire [DATA_WIDTH-1:0] next_data_15;
wire [DATA_WIDTH-1:0] next_data_16;
wire [DATA_WIDTH-1:0] next_data_17;
wire [DATA_WIDTH-1:0] next_data_18;
wire [DATA_WIDTH-1:0] next_data_19;
wire [DATA_WIDTH-1:0] next_data_20;
wire [DATA_WIDTH-1:0] next_data_21;
wire [DATA_WIDTH-1:0] next_data_22;
wire [DATA_WIDTH-1:0] next_data_23;
wire [DATA_WIDTH-1:0] next_data_24;
wire [DATA_WIDTH-1:0] next_data_25;
wire [DATA_WIDTH-1:0] next_data_26;
wire [DATA_WIDTH-1:0] next_data_27;
wire [DATA_WIDTH-1:0] next_data_28;
wire [DATA_WIDTH-1:0] next_data_29;
wire [DATA_WIDTH-1:0] next_data_30;
wire [DATA_WIDTH-1:0] next_data_31;
wire [DATA_WIDTH-1:0] next_data_32;
wire [DATA_WIDTH-1:0] next_data_33;
wire [DATA_WIDTH-1:0] next_data_34;
wire [DATA_WIDTH-1:0] next_data_35;
wire [DATA_WIDTH-1:0] next_data_36;
wire [DATA_WIDTH-1:0] next_data_37;
wire [DATA_WIDTH-1:0] next_data_38;
wire [DATA_WIDTH-1:0] next_data_39;
wire [DATA_WIDTH-1:0] next_data_40;
wire [DATA_WIDTH-1:0] next_data_41;
wire [DATA_WIDTH-1:0] next_data_42;
wire [DATA_WIDTH-1:0] next_data_43;
wire [DATA_WIDTH-1:0] next_data_44;
wire [DATA_WIDTH-1:0] next_data_45;
wire [DATA_WIDTH-1:0] next_data_46;
wire [DATA_WIDTH-1:0] next_data_47;
wire [DATA_WIDTH-1:0] next_data_48;
wire [DATA_WIDTH-1:0] next_data_49;
wire [DATA_WIDTH-1:0] next_data_50;
wire [DATA_WIDTH-1:0] next_data_51;
wire [DATA_WIDTH-1:0] next_data_52;
wire [DATA_WIDTH-1:0] next_data_53;
wire [DATA_WIDTH-1:0] next_data_54;
wire [DATA_WIDTH-1:0] next_data_55;
wire [DATA_WIDTH-1:0] next_data_56;
wire [DATA_WIDTH-1:0] next_data_57;
wire [DATA_WIDTH-1:0] next_data_58;
wire [DATA_WIDTH-1:0] next_data_59;
wire [DATA_WIDTH-1:0] next_data_60;
wire [DATA_WIDTH-1:0] next_data_61;
wire [DATA_WIDTH-1:0] next_data_62;
wire [DATA_WIDTH-1:0] next_data_63;
wire [DATA_WIDTH-1:0] next_data_64;
wire [DATA_WIDTH-1:0] next_data_65;
wire [DATA_WIDTH-1:0] next_data_66;
wire [DATA_WIDTH-1:0] next_data_67;
wire [DATA_WIDTH-1:0] next_data_68;
wire [DATA_WIDTH-1:0] next_data_69;
wire [DATA_WIDTH-1:0] next_data_70;
wire [DATA_WIDTH-1:0] next_data_71;
wire [DATA_WIDTH-1:0] next_data_72;
wire [DATA_WIDTH-1:0] next_data_73;
wire [DATA_WIDTH-1:0] next_data_74;
wire [DATA_WIDTH-1:0] next_data_75;
wire [DATA_WIDTH-1:0] next_data_76;
wire [DATA_WIDTH-1:0] next_data_77;
wire [DATA_WIDTH-1:0] next_data_78;
wire [DATA_WIDTH-1:0] next_data_79;
wire [DATA_WIDTH-1:0] next_data_80;
wire [DATA_WIDTH-1:0] next_data_81;
wire [DATA_WIDTH-1:0] next_data_82;
wire [DATA_WIDTH-1:0] next_data_83;
wire [DATA_WIDTH-1:0] next_data_84;
wire [DATA_WIDTH-1:0] next_data_85;
wire [DATA_WIDTH-1:0] next_data_86;
wire [DATA_WIDTH-1:0] next_data_87;
wire [DATA_WIDTH-1:0] next_data_88;
wire [DATA_WIDTH-1:0] next_data_89;
wire [DATA_WIDTH-1:0] next_data_90;
wire [DATA_WIDTH-1:0] next_data_91;
wire [DATA_WIDTH-1:0] next_data_92;
wire [DATA_WIDTH-1:0] next_data_93;
wire [DATA_WIDTH-1:0] next_data_94;
wire [DATA_WIDTH-1:0] next_data_95;
wire [DATA_WIDTH-1:0] next_data_96;
wire [DATA_WIDTH-1:0] next_data_97;
wire [DATA_WIDTH-1:0] next_data_98;
wire [DATA_WIDTH-1:0] next_data_99;
always@ (*) begin
  case (addr_in)
  8'd0 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001 ;
  8'd1 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010 ;
  8'd2 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100 ;
  8'd3 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000 ;
  8'd4 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000 ;
  8'd5 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000 ;
  8'd6 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000 ;
  8'd7 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000 ;
  8'd8 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000 ;
  8'd9 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000 ;
  8'd10 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000 ;
  8'd11 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000 ;
  8'd12 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000 ;
  8'd13 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000 ;
  8'd14 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000 ;
  8'd15 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000 ;
  8'd16 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000 ;
  8'd17 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000 ;
  8'd18 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000 ;
  8'd19 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000 ;
  8'd20 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000 ;
  8'd21 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000 ;
  8'd22 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000 ;
  8'd23 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000 ;
  8'd24 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000 ;
  8'd25 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000 ;
  8'd26 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000 ;
  8'd27 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000 ;
  8'd28 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000 ;
  8'd29 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000 ;
  8'd30 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000 ;
  8'd31 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000 ;
  8'd32 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000 ;
  8'd33 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000 ;
  8'd34 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000 ;
  8'd35 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000 ;
  8'd36 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000 ;
  8'd37 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000 ;
  8'd38 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000 ;
  8'd39 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000 ;
  8'd40 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000 ;
  8'd41 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000 ;
  8'd42 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000 ;
  8'd43 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000 ;
  8'd44 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000 ;
  8'd45 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000 ;
  8'd46 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000 ;
  8'd47 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000 ;
  8'd48 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000 ;
  8'd49 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000 ;
  8'd50 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000 ;
  8'd51 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000 ;
  8'd52 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000 ;
  8'd53 : addr_in_en <= 100'b0000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000 ;
  8'd54 : addr_in_en <= 100'b0000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000 ;
  8'd55 : addr_in_en <= 100'b0000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000 ;
  8'd56 : addr_in_en <= 100'b0000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000 ;
  8'd57 : addr_in_en <= 100'b0000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000 ;
  8'd58 : addr_in_en <= 100'b0000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000 ;
  8'd59 : addr_in_en <= 100'b0000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000 ;
  8'd60 : addr_in_en <= 100'b0000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000 ;
  8'd61 : addr_in_en <= 100'b0000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000 ;
  8'd62 : addr_in_en <= 100'b0000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000 ;
  8'd63 : addr_in_en <= 100'b0000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000 ;
  8'd64 : addr_in_en <= 100'b0000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000 ;
  8'd65 : addr_in_en <= 100'b0000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000 ;
  8'd66 : addr_in_en <= 100'b0000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd67 : addr_in_en <= 100'b0000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd68 : addr_in_en <= 100'b0000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd69 : addr_in_en <= 100'b0000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd70 : addr_in_en <= 100'b0000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd71 : addr_in_en <= 100'b0000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd72 : addr_in_en <= 100'b0000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd73 : addr_in_en <= 100'b0000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd74 : addr_in_en <= 100'b0000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd75 : addr_in_en <= 100'b0000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd76 : addr_in_en <= 100'b0000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd77 : addr_in_en <= 100'b0000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd78 : addr_in_en <= 100'b0000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd79 : addr_in_en <= 100'b0000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd80 : addr_in_en <= 100'b0000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd81 : addr_in_en <= 100'b0000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd82 : addr_in_en <= 100'b0000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd83 : addr_in_en <= 100'b0000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd84 : addr_in_en <= 100'b0000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd85 : addr_in_en <= 100'b0000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd86 : addr_in_en <= 100'b0000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd87 : addr_in_en <= 100'b0000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd88 : addr_in_en <= 100'b0000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd89 : addr_in_en <= 100'b0000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd90 : addr_in_en <= 100'b0000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd91 : addr_in_en <= 100'b0000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd92 : addr_in_en <= 100'b0000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd93 : addr_in_en <= 100'b0000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd94 : addr_in_en <= 100'b0000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd95 : addr_in_en <= 100'b0000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd96 : addr_in_en <= 100'b0001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd97 : addr_in_en <= 100'b0010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd98 : addr_in_en <= 100'b0100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  8'd99 : addr_in_en <= 100'b1000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 ;
  endcase
end
assign next_data_0 = ((addr_in_en[0] == 1'b1) && wr_ena)?data_in:data_0;
assign next_data_1 = ((addr_in_en[1] == 1'b1) && wr_ena)?data_in:data_1;
assign next_data_2 = ((addr_in_en[2] == 1'b1) && wr_ena)?data_in:data_2;
assign next_data_3 = ((addr_in_en[3] == 1'b1) && wr_ena)?data_in:data_3;
assign next_data_4 = ((addr_in_en[4] == 1'b1) && wr_ena)?data_in:data_4;
assign next_data_5 = ((addr_in_en[5] == 1'b1) && wr_ena)?data_in:data_5;
assign next_data_6 = ((addr_in_en[6] == 1'b1) && wr_ena)?data_in:data_6;
assign next_data_7 = ((addr_in_en[7] == 1'b1) && wr_ena)?data_in:data_7;
assign next_data_8 = ((addr_in_en[8] == 1'b1) && wr_ena)?data_in:data_8;
assign next_data_9 = ((addr_in_en[9] == 1'b1) && wr_ena)?data_in:data_9;
assign next_data_10 = ((addr_in_en[10] == 1'b1) && wr_ena)?data_in:data_10;
assign next_data_11 = ((addr_in_en[11] == 1'b1) && wr_ena)?data_in:data_11;
assign next_data_12 = ((addr_in_en[12] == 1'b1) && wr_ena)?data_in:data_12;
assign next_data_13 = ((addr_in_en[13] == 1'b1) && wr_ena)?data_in:data_13;
assign next_data_14 = ((addr_in_en[14] == 1'b1) && wr_ena)?data_in:data_14;
assign next_data_15 = ((addr_in_en[15] == 1'b1) && wr_ena)?data_in:data_15;
assign next_data_16 = ((addr_in_en[16] == 1'b1) && wr_ena)?data_in:data_16;
assign next_data_17 = ((addr_in_en[17] == 1'b1) && wr_ena)?data_in:data_17;
assign next_data_18 = ((addr_in_en[18] == 1'b1) && wr_ena)?data_in:data_18;
assign next_data_19 = ((addr_in_en[19] == 1'b1) && wr_ena)?data_in:data_19;
assign next_data_20 = ((addr_in_en[20] == 1'b1) && wr_ena)?data_in:data_20;
assign next_data_21 = ((addr_in_en[21] == 1'b1) && wr_ena)?data_in:data_21;
assign next_data_22 = ((addr_in_en[22] == 1'b1) && wr_ena)?data_in:data_22;
assign next_data_23 = ((addr_in_en[23] == 1'b1) && wr_ena)?data_in:data_23;
assign next_data_24 = ((addr_in_en[24] == 1'b1) && wr_ena)?data_in:data_24;
assign next_data_25 = ((addr_in_en[25] == 1'b1) && wr_ena)?data_in:data_25;
assign next_data_26 = ((addr_in_en[26] == 1'b1) && wr_ena)?data_in:data_26;
assign next_data_27 = ((addr_in_en[27] == 1'b1) && wr_ena)?data_in:data_27;
assign next_data_28 = ((addr_in_en[28] == 1'b1) && wr_ena)?data_in:data_28;
assign next_data_29 = ((addr_in_en[29] == 1'b1) && wr_ena)?data_in:data_29;
assign next_data_30 = ((addr_in_en[30] == 1'b1) && wr_ena)?data_in:data_30;
assign next_data_31 = ((addr_in_en[31] == 1'b1) && wr_ena)?data_in:data_31;
assign next_data_32 = ((addr_in_en[32] == 1'b1) && wr_ena)?data_in:data_32;
assign next_data_33 = ((addr_in_en[33] == 1'b1) && wr_ena)?data_in:data_33;
assign next_data_34 = ((addr_in_en[34] == 1'b1) && wr_ena)?data_in:data_34;
assign next_data_35 = ((addr_in_en[35] == 1'b1) && wr_ena)?data_in:data_35;
assign next_data_36 = ((addr_in_en[36] == 1'b1) && wr_ena)?data_in:data_36;
assign next_data_37 = ((addr_in_en[37] == 1'b1) && wr_ena)?data_in:data_37;
assign next_data_38 = ((addr_in_en[38] == 1'b1) && wr_ena)?data_in:data_38;
assign next_data_39 = ((addr_in_en[39] == 1'b1) && wr_ena)?data_in:data_39;
assign next_data_40 = ((addr_in_en[40] == 1'b1) && wr_ena)?data_in:data_40;
assign next_data_41 = ((addr_in_en[41] == 1'b1) && wr_ena)?data_in:data_41;
assign next_data_42 = ((addr_in_en[42] == 1'b1) && wr_ena)?data_in:data_42;
assign next_data_43 = ((addr_in_en[43] == 1'b1) && wr_ena)?data_in:data_43;
assign next_data_44 = ((addr_in_en[44] == 1'b1) && wr_ena)?data_in:data_44;
assign next_data_45 = ((addr_in_en[45] == 1'b1) && wr_ena)?data_in:data_45;
assign next_data_46 = ((addr_in_en[46] == 1'b1) && wr_ena)?data_in:data_46;
assign next_data_47 = ((addr_in_en[47] == 1'b1) && wr_ena)?data_in:data_47;
assign next_data_48 = ((addr_in_en[48] == 1'b1) && wr_ena)?data_in:data_48;
assign next_data_49 = ((addr_in_en[49] == 1'b1) && wr_ena)?data_in:data_49;
assign next_data_50 = ((addr_in_en[50] == 1'b1) && wr_ena)?data_in:data_50;
assign next_data_51 = ((addr_in_en[51] == 1'b1) && wr_ena)?data_in:data_51;
assign next_data_52 = ((addr_in_en[52] == 1'b1) && wr_ena)?data_in:data_52;
assign next_data_53 = ((addr_in_en[53] == 1'b1) && wr_ena)?data_in:data_53;
assign next_data_54 = ((addr_in_en[54] == 1'b1) && wr_ena)?data_in:data_54;
assign next_data_55 = ((addr_in_en[55] == 1'b1) && wr_ena)?data_in:data_55;
assign next_data_56 = ((addr_in_en[56] == 1'b1) && wr_ena)?data_in:data_56;
assign next_data_57 = ((addr_in_en[57] == 1'b1) && wr_ena)?data_in:data_57;
assign next_data_58 = ((addr_in_en[58] == 1'b1) && wr_ena)?data_in:data_58;
assign next_data_59 = ((addr_in_en[59] == 1'b1) && wr_ena)?data_in:data_59;
assign next_data_60 = ((addr_in_en[60] == 1'b1) && wr_ena)?data_in:data_60;
assign next_data_61 = ((addr_in_en[61] == 1'b1) && wr_ena)?data_in:data_61;
assign next_data_62 = ((addr_in_en[62] == 1'b1) && wr_ena)?data_in:data_62;
assign next_data_63 = ((addr_in_en[63] == 1'b1) && wr_ena)?data_in:data_63;
assign next_data_64 = ((addr_in_en[64] == 1'b1) && wr_ena)?data_in:data_64;
assign next_data_65 = ((addr_in_en[65] == 1'b1) && wr_ena)?data_in:data_65;
assign next_data_66 = ((addr_in_en[66] == 1'b1) && wr_ena)?data_in:data_66;
assign next_data_67 = ((addr_in_en[67] == 1'b1) && wr_ena)?data_in:data_67;
assign next_data_68 = ((addr_in_en[68] == 1'b1) && wr_ena)?data_in:data_68;
assign next_data_69 = ((addr_in_en[69] == 1'b1) && wr_ena)?data_in:data_69;
assign next_data_70 = ((addr_in_en[70] == 1'b1) && wr_ena)?data_in:data_70;
assign next_data_71 = ((addr_in_en[71] == 1'b1) && wr_ena)?data_in:data_71;
assign next_data_72 = ((addr_in_en[72] == 1'b1) && wr_ena)?data_in:data_72;
assign next_data_73 = ((addr_in_en[73] == 1'b1) && wr_ena)?data_in:data_73;
assign next_data_74 = ((addr_in_en[74] == 1'b1) && wr_ena)?data_in:data_74;
assign next_data_75 = ((addr_in_en[75] == 1'b1) && wr_ena)?data_in:data_75;
assign next_data_76 = ((addr_in_en[76] == 1'b1) && wr_ena)?data_in:data_76;
assign next_data_77 = ((addr_in_en[77] == 1'b1) && wr_ena)?data_in:data_77;
assign next_data_78 = ((addr_in_en[78] == 1'b1) && wr_ena)?data_in:data_78;
assign next_data_79 = ((addr_in_en[79] == 1'b1) && wr_ena)?data_in:data_79;
assign next_data_80 = ((addr_in_en[80] == 1'b1) && wr_ena)?data_in:data_80;
assign next_data_81 = ((addr_in_en[81] == 1'b1) && wr_ena)?data_in:data_81;
assign next_data_82 = ((addr_in_en[82] == 1'b1) && wr_ena)?data_in:data_82;
assign next_data_83 = ((addr_in_en[83] == 1'b1) && wr_ena)?data_in:data_83;
assign next_data_84 = ((addr_in_en[84] == 1'b1) && wr_ena)?data_in:data_84;
assign next_data_85 = ((addr_in_en[85] == 1'b1) && wr_ena)?data_in:data_85;
assign next_data_86 = ((addr_in_en[86] == 1'b1) && wr_ena)?data_in:data_86;
assign next_data_87 = ((addr_in_en[87] == 1'b1) && wr_ena)?data_in:data_87;
assign next_data_88 = ((addr_in_en[88] == 1'b1) && wr_ena)?data_in:data_88;
assign next_data_89 = ((addr_in_en[89] == 1'b1) && wr_ena)?data_in:data_89;
assign next_data_90 = ((addr_in_en[90] == 1'b1) && wr_ena)?data_in:data_90;
assign next_data_91 = ((addr_in_en[91] == 1'b1) && wr_ena)?data_in:data_91;
assign next_data_92 = ((addr_in_en[92] == 1'b1) && wr_ena)?data_in:data_92;
assign next_data_93 = ((addr_in_en[93] == 1'b1) && wr_ena)?data_in:data_93;
assign next_data_94 = ((addr_in_en[94] == 1'b1) && wr_ena)?data_in:data_94;
assign next_data_95 = ((addr_in_en[95] == 1'b1) && wr_ena)?data_in:data_95;
assign next_data_96 = ((addr_in_en[96] == 1'b1) && wr_ena)?data_in:data_96;
assign next_data_97 = ((addr_in_en[97] == 1'b1) && wr_ena)?data_in:data_97;
assign next_data_98 = ((addr_in_en[98] == 1'b1) && wr_ena)?data_in:data_98;
assign next_data_99 = ((addr_in_en[99] == 1'b1) && wr_ena)?data_in:data_99;
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_0 <= 128'b0;
  end
  else begin 
    data_0 <= next_data_0;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_1 <= 128'b0;
  end
  else begin 
    data_1 <= next_data_1;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_2 <= 128'b0;
  end
  else begin 
    data_2 <= next_data_2;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_3 <= 128'b0;
  end
  else begin 
    data_3 <= next_data_3;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_4 <= 128'b0;
  end
  else begin 
    data_4 <= next_data_4;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_5 <= 128'b0;
  end
  else begin 
    data_5 <= next_data_5;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_6 <= 128'b0;
  end
  else begin 
    data_6 <= next_data_6;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_7 <= 128'b0;
  end
  else begin 
    data_7 <= next_data_7;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_8 <= 128'b0;
  end
  else begin 
    data_8 <= next_data_8;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_9 <= 128'b0;
  end
  else begin 
    data_9 <= next_data_9;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_10 <= 128'b0;
  end
  else begin 
    data_10 <= next_data_10;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_11 <= 128'b0;
  end
  else begin 
    data_11 <= next_data_11;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_12 <= 128'b0;
  end
  else begin 
    data_12 <= next_data_12;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_13 <= 128'b0;
  end
  else begin 
    data_13 <= next_data_13;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_14 <= 128'b0;
  end
  else begin 
    data_14 <= next_data_14;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_15 <= 128'b0;
  end
  else begin 
    data_15 <= next_data_15;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_16 <= 128'b0;
  end
  else begin 
    data_16 <= next_data_16;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_17 <= 128'b0;
  end
  else begin 
    data_17 <= next_data_17;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_18 <= 128'b0;
  end
  else begin 
    data_18 <= next_data_18;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_19 <= 128'b0;
  end
  else begin 
    data_19 <= next_data_19;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_20 <= 128'b0;
  end
  else begin 
    data_20 <= next_data_20;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_21 <= 128'b0;
  end
  else begin 
    data_21 <= next_data_21;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_22 <= 128'b0;
  end
  else begin 
    data_22 <= next_data_22;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_23 <= 128'b0;
  end
  else begin 
    data_23 <= next_data_23;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_24 <= 128'b0;
  end
  else begin 
    data_24 <= next_data_24;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_25 <= 128'b0;
  end
  else begin 
    data_25 <= next_data_25;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_26 <= 128'b0;
  end
  else begin 
    data_26 <= next_data_26;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_27 <= 128'b0;
  end
  else begin 
    data_27 <= next_data_27;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_28 <= 128'b0;
  end
  else begin 
    data_28 <= next_data_28;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_29 <= 128'b0;
  end
  else begin 
    data_29 <= next_data_29;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_30 <= 128'b0;
  end
  else begin 
    data_30 <= next_data_30;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_31 <= 128'b0;
  end
  else begin 
    data_31 <= next_data_31;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_32 <= 128'b0;
  end
  else begin 
    data_32 <= next_data_32;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_33 <= 128'b0;
  end
  else begin 
    data_33 <= next_data_33;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_34 <= 128'b0;
  end
  else begin 
    data_34 <= next_data_34;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_35 <= 128'b0;
  end
  else begin 
    data_35 <= next_data_35;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_36 <= 128'b0;
  end
  else begin 
    data_36 <= next_data_36;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_37 <= 128'b0;
  end
  else begin 
    data_37 <= next_data_37;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_38 <= 128'b0;
  end
  else begin 
    data_38 <= next_data_38;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_39 <= 128'b0;
  end
  else begin 
    data_39 <= next_data_39;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_40 <= 128'b0;
  end
  else begin 
    data_40 <= next_data_40;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_41 <= 128'b0;
  end
  else begin 
    data_41 <= next_data_41;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_42 <= 128'b0;
  end
  else begin 
    data_42 <= next_data_42;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_43 <= 128'b0;
  end
  else begin 
    data_43 <= next_data_43;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_44 <= 128'b0;
  end
  else begin 
    data_44 <= next_data_44;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_45 <= 128'b0;
  end
  else begin 
    data_45 <= next_data_45;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_46 <= 128'b0;
  end
  else begin 
    data_46 <= next_data_46;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_47 <= 128'b0;
  end
  else begin 
    data_47 <= next_data_47;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_48 <= 128'b0;
  end
  else begin 
    data_48 <= next_data_48;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_49 <= 128'b0;
  end
  else begin 
    data_49 <= next_data_49;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_50 <= 128'b0;
  end
  else begin 
    data_50 <= next_data_50;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_51 <= 128'b0;
  end
  else begin 
    data_51 <= next_data_51;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_52 <= 128'b0;
  end
  else begin 
    data_52 <= next_data_52;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_53 <= 128'b0;
  end
  else begin 
    data_53 <= next_data_53;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_54 <= 128'b0;
  end
  else begin 
    data_54 <= next_data_54;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_55 <= 128'b0;
  end
  else begin 
    data_55 <= next_data_55;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_56 <= 128'b0;
  end
  else begin 
    data_56 <= next_data_56;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_57 <= 128'b0;
  end
  else begin 
    data_57 <= next_data_57;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_58 <= 128'b0;
  end
  else begin 
    data_58 <= next_data_58;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_59 <= 128'b0;
  end
  else begin 
    data_59 <= next_data_59;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_60 <= 128'b0;
  end
  else begin 
    data_60 <= next_data_60;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_61 <= 128'b0;
  end
  else begin 
    data_61 <= next_data_61;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_62 <= 128'b0;
  end
  else begin 
    data_62 <= next_data_62;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_63 <= 128'b0;
  end
  else begin 
    data_63 <= next_data_63;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_64 <= 128'b0;
  end
  else begin 
    data_64 <= next_data_64;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_65 <= 128'b0;
  end
  else begin 
    data_65 <= next_data_65;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_66 <= 128'b0;
  end
  else begin 
    data_66 <= next_data_66;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_67 <= 128'b0;
  end
  else begin 
    data_67 <= next_data_67;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_68 <= 128'b0;
  end
  else begin 
    data_68 <= next_data_68;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_69 <= 128'b0;
  end
  else begin 
    data_69 <= next_data_69;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_70 <= 128'b0;
  end
  else begin 
    data_70 <= next_data_70;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_71 <= 128'b0;
  end
  else begin 
    data_71 <= next_data_71;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_72 <= 128'b0;
  end
  else begin 
    data_72 <= next_data_72;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_73 <= 128'b0;
  end
  else begin 
    data_73 <= next_data_73;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_74 <= 128'b0;
  end
  else begin 
    data_74 <= next_data_74;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_75 <= 128'b0;
  end
  else begin 
    data_75 <= next_data_75;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_76 <= 128'b0;
  end
  else begin 
    data_76 <= next_data_76;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_77 <= 128'b0;
  end
  else begin 
    data_77 <= next_data_77;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_78 <= 128'b0;
  end
  else begin 
    data_78 <= next_data_78;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_79 <= 128'b0;
  end
  else begin 
    data_79 <= next_data_79;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_80 <= 128'b0;
  end
  else begin 
    data_80 <= next_data_80;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_81 <= 128'b0;
  end
  else begin 
    data_81 <= next_data_81;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_82 <= 128'b0;
  end
  else begin 
    data_82 <= next_data_82;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_83 <= 128'b0;
  end
  else begin 
    data_83 <= next_data_83;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_84 <= 128'b0;
  end
  else begin 
    data_84 <= next_data_84;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_85 <= 128'b0;
  end
  else begin 
    data_85 <= next_data_85;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_86 <= 128'b0;
  end
  else begin 
    data_86 <= next_data_86;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_87 <= 128'b0;
  end
  else begin 
    data_87 <= next_data_87;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_88 <= 128'b0;
  end
  else begin 
    data_88 <= next_data_88;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_89 <= 128'b0;
  end
  else begin 
    data_89 <= next_data_89;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_90 <= 128'b0;
  end
  else begin 
    data_90 <= next_data_90;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_91 <= 128'b0;
  end
  else begin 
    data_91 <= next_data_91;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_92 <= 128'b0;
  end
  else begin 
    data_92 <= next_data_92;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_93 <= 128'b0;
  end
  else begin 
    data_93 <= next_data_93;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_94 <= 128'b0;
  end
  else begin 
    data_94 <= next_data_94;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_95 <= 128'b0;
  end
  else begin 
    data_95 <= next_data_95;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_96 <= 128'b0;
  end
  else begin 
    data_96 <= next_data_96;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_97 <= 128'b0;
  end
  else begin 
    data_97 <= next_data_97;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_98 <= 128'b0;
  end
  else begin 
    data_98 <= next_data_98;
  end
end
always@ (posedge clk or negedge rstn) begin
  if (!rstn) begin
    data_99 <= 128'b0;
  end
  else begin 
    data_99 <= next_data_99;
  end
end
always@ (*) begin
  case (addr_out)
  8'd0 : data_out <= data_0 ;
  8'd1 : data_out <= data_1 ;
  8'd2 : data_out <= data_2 ;
  8'd3 : data_out <= data_3 ;
  8'd4 : data_out <= data_4 ;
  8'd5 : data_out <= data_5 ;
  8'd6 : data_out <= data_6 ;
  8'd7 : data_out <= data_7 ;
  8'd8 : data_out <= data_8 ;
  8'd9 : data_out <= data_9 ;
  8'd10 : data_out <= data_10 ;
  8'd11 : data_out <= data_11 ;
  8'd12 : data_out <= data_12 ;
  8'd13 : data_out <= data_13 ;
  8'd14 : data_out <= data_14 ;
  8'd15 : data_out <= data_15 ;
  8'd16 : data_out <= data_16 ;
  8'd17 : data_out <= data_17 ;
  8'd18 : data_out <= data_18 ;
  8'd19 : data_out <= data_19 ;
  8'd20 : data_out <= data_20 ;
  8'd21 : data_out <= data_21 ;
  8'd22 : data_out <= data_22 ;
  8'd23 : data_out <= data_23 ;
  8'd24 : data_out <= data_24 ;
  8'd25 : data_out <= data_25 ;
  8'd26 : data_out <= data_26 ;
  8'd27 : data_out <= data_27 ;
  8'd28 : data_out <= data_28 ;
  8'd29 : data_out <= data_29 ;
  8'd30 : data_out <= data_30 ;
  8'd31 : data_out <= data_31 ;
  8'd32 : data_out <= data_32 ;
  8'd33 : data_out <= data_33 ;
  8'd34 : data_out <= data_34 ;
  8'd35 : data_out <= data_35 ;
  8'd36 : data_out <= data_36 ;
  8'd37 : data_out <= data_37 ;
  8'd38 : data_out <= data_38 ;
  8'd39 : data_out <= data_39 ;
  8'd40 : data_out <= data_40 ;
  8'd41 : data_out <= data_41 ;
  8'd42 : data_out <= data_42 ;
  8'd43 : data_out <= data_43 ;
  8'd44 : data_out <= data_44 ;
  8'd45 : data_out <= data_45 ;
  8'd46 : data_out <= data_46 ;
  8'd47 : data_out <= data_47 ;
  8'd48 : data_out <= data_48 ;
  8'd49 : data_out <= data_49 ;
  8'd50 : data_out <= data_50 ;
  8'd51 : data_out <= data_51 ;
  8'd52 : data_out <= data_52 ;
  8'd53 : data_out <= data_53 ;
  8'd54 : data_out <= data_54 ;
  8'd55 : data_out <= data_55 ;
  8'd56 : data_out <= data_56 ;
  8'd57 : data_out <= data_57 ;
  8'd58 : data_out <= data_58 ;
  8'd59 : data_out <= data_59 ;
  8'd60 : data_out <= data_60 ;
  8'd61 : data_out <= data_61 ;
  8'd62 : data_out <= data_62 ;
  8'd63 : data_out <= data_63 ;
  8'd64 : data_out <= data_64 ;
  8'd65 : data_out <= data_65 ;
  8'd66 : data_out <= data_66 ;
  8'd67 : data_out <= data_67 ;
  8'd68 : data_out <= data_68 ;
  8'd69 : data_out <= data_69 ;
  8'd70 : data_out <= data_70 ;
  8'd71 : data_out <= data_71 ;
  8'd72 : data_out <= data_72 ;
  8'd73 : data_out <= data_73 ;
  8'd74 : data_out <= data_74 ;
  8'd75 : data_out <= data_75 ;
  8'd76 : data_out <= data_76 ;
  8'd77 : data_out <= data_77 ;
  8'd78 : data_out <= data_78 ;
  8'd79 : data_out <= data_79 ;
  8'd80 : data_out <= data_80 ;
  8'd81 : data_out <= data_81 ;
  8'd82 : data_out <= data_82 ;
  8'd83 : data_out <= data_83 ;
  8'd84 : data_out <= data_84 ;
  8'd85 : data_out <= data_85 ;
  8'd86 : data_out <= data_86 ;
  8'd87 : data_out <= data_87 ;
  8'd88 : data_out <= data_88 ;
  8'd89 : data_out <= data_89 ;
  8'd90 : data_out <= data_90 ;
  8'd91 : data_out <= data_91 ;
  8'd92 : data_out <= data_92 ;
  8'd93 : data_out <= data_93 ;
  8'd94 : data_out <= data_94 ;
  8'd95 : data_out <= data_95 ;
  8'd96 : data_out <= data_96 ;
  8'd97 : data_out <= data_97 ;
  8'd98 : data_out <= data_98 ;
  8'd99 : data_out <= data_99 ;
  endcase
end
endmodule
