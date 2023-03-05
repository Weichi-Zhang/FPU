#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vrvc_decoder.h"

#define NUM_OF_TESTCASES 4
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
int sim_time = 0;

static unsigned int instructions[NUM_OF_TESTCASES] = {
	0x0000E040,
	0x00006040,
	0x00006412,
	0x0000E222
};


int main() {
	Vrvc_decoder *dut = new Vrvc_decoder;
	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;  
	dut->trace(m_trace, SUBMODULE_DEPTH);               
	m_trace->open("waveform.vcd");

	
	while (sim_time < MAX_SIM_TIME) {
		
		dut->instruction_i = instructions[sim_time / 5];

		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
