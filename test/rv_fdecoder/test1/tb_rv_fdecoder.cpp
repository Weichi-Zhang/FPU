#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vrv_fdecoder.h"

#define NUM_OF_TESTCASES 32
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
int sim_time = 0;

static unsigned int instructions[NUM_OF_TESTCASES] = {
	0x01248433,
	0x41248433,
	0x001171D3,
	0x0821F253,
	0x103272D3,
	0x28428353,
	0x285313D3,
	0x2863F443,
	0x307474CF,
	0x3884F547,
	0x409575CB,
	0xC0067453,
	0xC016F4D3,
	0xC0277953,
	0xC037F9D3,
	0xD00A7853,
	0xD01AF8D3,
	0xD022F953,
	0xD03379D3,
	0xA00A23D3,
	0xA00A9E53,
	0xA00B0ED3,
	0xE00B9F53,
	0x180C7353,
	0x580CF3D3,
	0xF0050D53,
	0xE00D85D3,
	0xF525AE07,
	0xB5D62127,
	0x201101D3,
	0x21CE9F53,
	0x21DF2FD3
};


int main() {
	Vrv_fdecoder *dut = new Vrv_fdecoder;
	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;  
	dut->trace(m_trace, SUBMODULE_DEPTH);               
	m_trace->open("waveform.vcd");

	
	while (sim_time < MAX_SIM_TIME) {
		
		dut->instruction = instructions[sim_time / 5];

		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
