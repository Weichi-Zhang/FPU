#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfonecycle.h"

#define NUM_OF_TESTCASES 5
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
#define NaN 0x7FC00000
int sim_time = 0;

static unsigned int frs1_data[NUM_OF_TESTCASES] = {
	0xBFAE147B,
	0xBFAF5C29,
	NaN,
	NaN,
	0x7F800001
};

static unsigned int frs2_data[NUM_OF_TESTCASES] = {
	0xBFAE147B,
	0xBFAE147B,
	0x00000000,
	NaN,
	0x00000000
};

int main() {
	Vfonecycle *dut = new Vfonecycle;
	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;  
	dut->trace(m_trace, SUBMODULE_DEPTH);               
	m_trace->open("waveform.vcd");

	
	dut->frs1 = 0;
	dut->frs2 = 0;
	dut->frs3 = 0;
	/* The operation is feq.s */
	dut->ftype = 20;
	dut->fcontrol = 0;
	/* roundingMode is 000 */
	dut->roundingMode = 0;


	while (sim_time < MAX_SIM_TIME) {
		
		dut->frs1 = frs1_data[sim_time / 5];
		dut->frs2 = frs2_data[sim_time / 5];

		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
