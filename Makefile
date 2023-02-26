# Compiler
VC = verilator

# TOP Module
TOP_NAME = fonecycle

# Test op
TEST_OP = fadd.s

# Test case
TEST_CASE = normal

# Store .v source file
SRCS_V := ${TOP_NAME}.v $(shell find . -name '*.v')

# Set default goal
.DEFAULT_GOAL := all

all: waveform.vcd

waveform.vcd:${SRCS_V}
	@${VC} -Wno-WIDTH --trace -Iutils -cc $^ --exe ./test/${TOP_NAME}/${TEST_OP}/${TEST_CASE}/tb_${TOP_NAME}.cpp --top-module ${TOP_NAME}
	@cd ./obj_dir && make -f ./V${TOP_NAME}.mk && ./V${TOP_NAME} && mv ./waveform.vcd ..
	@rm -rf obj_dir


wave: waveform.vcd
	@gtkwave waveform.vcd
clean:
	@rm waveform.vcd
