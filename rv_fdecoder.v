`ifndef RV_FDECODER_V
`define RV_FDECODER_V
`ifndef SYNTHESIS
`include "./params.vh"
`endif

module rv_fdecoder(
	input [31 : 0] instruction,
	output is_float_instruction,
	output reg f_uses_rs1_o,
	output reg f_uses_rs2_o,
	output reg f_uses_rs3_o,
	output reg f_uses_rd_o,
	output reg [VIR_REG_ADDR_WIDTH - 1 : 0] f_rs1_address_o,
	output reg [VIR_REG_ADDR_WIDTH - 1 : 0] f_rs2_address_o,
	output reg [VIR_REG_ADDR_WIDTH - 1 : 0] f_rs3_address_o,
	output reg [VIR_REG_ADDR_WIDTH - 1 : 0] f_rd_address_o,
	output reg [11 : 0] f_immediate_o,
	output reg [4 : 0] f_fu_function_o,
	output reg [1 : 0] f_fu_select_a_o,
	output reg [1 : 0] f_fu_select_b_o,
	output reg [1 : 0] f_fu_select_c_o,
);

wire [4 :0] funct5;
wire [1 : 0] fmt;
wire [VIR_REG_ADDR - 1 : 0] rs3;
wire [VIR_REG_ADDR - 1 : 0] rs2;
wire [VIR_REG_ADDR - 1 : 0] rs1;
wire [2 : 0] rm;
wire [VIR_REG_ADDR - 1 : 0] rd;
wire [6 : 0] opcode;
wire [31 : 0] offset;
wire [2 : 0] width;
wire [6 : 0] offset_first_part;
wire [4 : 0] offset_second_part;

assign funct5 = instruction[31 : 27];
assign fmt = instruction[26 : 25];
assign rs3 = instruction[31 : 27];
assign rs2 = instruction[24 : 20];
assign rs1 = instruction[19 : 15];
assign rm = instruction[14 : 12];
assign rd = instruction[11 : 7];
assign opcode = instruction[6 : 0];
assign offset = instruction[31 : 20];
assign width = instruction[14 : 12];
assign offset_first_part = instruction[31 : 25];
assign offset_second_part = instruction[11 : 7];

wire is_fadds;
wire is_fsubs;
wire is_fmuls;
wire is_fmins;
wire is_fmaxs;
wire is_fmadds;
wire is_fnmadds;
wire is_fmsubs;
wire is_fnmsubs;
wire is_fcvtws;
wire is_fcvtwus;
wire is_fcvtls;
wire is_fcvtlus;
wire is_fcvtsw;
wire is_fcvtswu;
wire is_fcvtsl;
wire is_fcvtslu;
wire is_fsgnjs;
wire is_fsgnjns;
wire is_fsgnjxs;
wire is_feqs;
wire is_flts;
wire is_fles;
wire is_fclass;
wire is_fmvwx;
wire is_fmvxw;
wire is_fdivs;
wire is_fsqrts;
wire is_flw;
wire is_fsw;

assign is_fadds = (funct5 == 5'b00000) && (fmt == 2'b00) && (opcode == 7'b1010011);
assign is_fsubs = (funct5 == 5'b00001) && (fmt == 2'b00) && (opcode == 7'b1010011);
assign is_fmuls = (funct5 == 5'b00010) && (fmt == 2'b00) && (opcode == 7'b1010011);
assign is_fmins = (funct5 == 5'b00101) && (fmt == 2'b00) && (opcode == 7'b1010011) && (rm == 3'b000);
assign is_fmaxs = (funct5 == 5'b00101) && (fmt == 2'b00) && (opcode == 7'b1010011) && (rm == 3'b001);
assign is_fmadds = (fmt == 2'b00) && (opcode == 7'b1000011);
assign is_fnmadds = (fmt == 2'b00) && (opcode == 7'b1001111);
assign is_fmsubs = (fmt == 2'b00) && (opcode == 7'b1000111);
assign is_fnmsubs = (fmt == 2'b00) && (opcode == 7'b1001011);
assign is_fcvtws = (funct5 == 5'b11000) && (fmt == 2'b00) && (rs2 == 5'b00000) && (opcode == 7'b1010011);
assign is_fcvtwus = (funct5 == 5'b11000) && (fmt == 2'b00) && (rs2 == 5'b00001) && (opcode == 7'b1010011);
assign is_fcvtls = (funct5 == 5'b11000) && (fmt == 2'b00) && (rs2 == 5'b00010) && (opcode == 7'b1010011);
assign is_fcvtlus = (funct5 == 5'b11000) && (fmt == 2'b00) && (rs2 == 5'b00011) && (opcode == 7'b1010011);
assign is_fcvtsw = (funct5 == 5'b11010) && (fmt == 2'b00) && (rs2 == 5'b00000) && (opcode == 7'b1010011);
assign is_fcvtswu = (funct5 == 5'b11010) && (fmt == 2'b00) && (rs2 == 5'b00001) && (opcode == 7'b1010011);
assign is_fcvtsl = (funct5 == 5'b11010) && (fmt == 2'b00) && (rs2 == 5'b00010) && (opcode == 7'b1010011);
assign is_fcvtslu = (funct5 == 5'b11010) && (fmt == 2'b00) && (rs2 == 5'b00011) && (opcode == 7'b1010011);
assign is_fsgnjs = (funct5 == 5'b00100) && (fmt == 2'b00) && (rm == 3'b000) && (opcode == 7'b1010011);
assign is_fsgnjns = (funct5 == 5'b00100) && (fmt == 2'b00) && (rm == 3'b001) && (opcode == 7'b1010011);
assign is_fsgnjxs = (funct5 == 5'b00100) && (fmt == 2'b00) && (rm == 3'b010) && (opcode == 7'b1010011);
assign is_feqs = (funct5 == 5'b10100) && (fmt == 2'b00) && (rm == 3'b010) && (opcode == 7'b1010011);
assign is_flts = (funct5 == 5'b10100) && (fmt == 2'b00) && (rm == 3'b001) && (opcode == 7'b1010011);
assign is_fles = (funct5 == 5'b10100) && (fmt == 2'b00) && (rm == 3'b000) && (opcode == 7'b1010011);
assign is_fclass = (funct5 == 5'b11100) && (fmt == 2'b00) && (rs2 == 5'b00000) && (rm == 3'b001) && (opcode == 7'b1010011);
assign is_fmvwx = (funct5 == 5'b11110) && (fmt == 2'b00) && (rs2 == 5'b00000) && (rm == 3'b000) && (opcode == 7'b1010011);
assign is_fmvxw = (funct5 == 5'b11100) && (fmt == 2'b00) && (rs2 == 5'b00000) && (rm == 3'b000) && (opcode == 7'b1010011);
assign is_fdivs = (funct5 == 5'b00011) && (fmt == 2'b00) && (opcode == 7'b1010011);
assign is_fsqrts = (funct5 == 5'b01011) && (fmt == 2'b00) && (rs2 == 5'b00000) && (opcode == 7'b1010011);
assign is_flw = (width == 3'b010) && (opcode == 7'b0000111);
assign is_fsw = (width == 3'b010) && (opcode == 7'b0100111);

assign is_float_instruction = is_fadds | is_fsubs | is_fmuls | is_fmins | is_fmaxs | is_fmadds | is_fmsubs | is_fnmadds | is_fnmsubs | is_fcvtws | is_fcvtwus | is_fcvtls | is_fcvtlus | is_fcvtsw | is_fcvtswu | is_fcvtsl | is_fcvtslu | is_fsgnjs | is_fsgnjns | is_fsgnjxs | is_feqs | is_flts | is_fles | is_fclass | is_fmvwx | is_fmvxw | is_fdivs | is_fsqrts | is_flw | is_fsw;

always @ (*) begin
	if (is_fadds) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 0;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fsubs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 1;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fmuls) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 2;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fmins) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 3;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fmaxs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 4;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fmadds) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b1;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = rs3 + 32;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 5;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_REG;
	end
	else if (is_fnmadds) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b1;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = rs3 + 32;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 6;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_REG;
	end
	else if (is_fmsubs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b1;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = rs3 + 32;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 7;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_REG;
	end
	else if (is_fnmsubs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b1;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = rs3 + 32;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 8;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_REG;
	end
	else if (is_fcvtws) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 9;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtwus) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 10;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtls) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 11;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtlus) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 12;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtsw) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 13;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtswu) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 14;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtsl) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 15;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fcvtslu) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 16;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fsgnjs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 17;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fsgnjns) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 18;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fsgnjxs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 19;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_feqs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 20;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_flts) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 21;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fles) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 22;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fclass) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd;
		f_immediate_o = 0;
		f_fu_function_o = 23;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fmvwx) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 24;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fmvxw) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 25;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fdivs) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 26;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_REG;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fsqrts) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1 + 32;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = 0;
		f_fu_function_o = 27;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_flw) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b1;
		f_rs1_address_o = rs1;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = rd + 32;
		f_immediate_o = {{ 20{ offset[11] } } , offset};
		f_fu_function_o = 28;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else if (is_fsw) begin
		f_uses_rs1_o = 1'b1;
		f_uses_rs2_o = 1'b1;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b0;
		f_rs1_address_o = rs1;
		f_rs2_address_o = rs2 + 32;
		f_rs3_address_o = 0;
		f_rd_address_o = 0;
		f_immediate_o = {{ 20{ offset_first_part[6] } }, offset_first_part, offset_second_part};
		f_fu_function_o = 29;
		f_fu_select_a_o = ALU_SEL_REG;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
	else begin
		f_uses_rs1_o = 1'b0;
		f_uses_rs2_o = 1'b0;
		f_uses_rs3_o = 1'b0;
		f_uses_rd_o = 1'b0;
		f_rs1_address_o = 0;
		f_rs2_address_o = 0;
		f_rs3_address_o = 0;
		f_rd_address_o = 0;
		f_immediate_o = 0;
		f_fu_function_o = 0;
		f_fu_select_a_o = ALU_SEL_IMM;
		f_fu_select_b_o = ALU_SEL_IMM;
		f_fu_select_c_o = ALU_SEL_IMM;
	end
end

endmodule

`endif //RV_FDECODER_V
