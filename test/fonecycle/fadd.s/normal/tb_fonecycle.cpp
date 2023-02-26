#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfonecycle.h"

#define NUM_OF_TESTCASES 4
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
int sim_time = 0;

static unsigned int frs1_data[NUM_OF_TESTCASES] = {
	0x3f800000,
	0x40200000,
	0xC49A6333,
	0x40490FDB
};

static unsigned int frs2_data[NUM_OF_TESTCASES] = {
	0x40400000,
	0x3F800000,
	0x3F8CCCCD,
	0x322BCC77
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
	dut->rs = 0;
	/* The operation is fadd.s */
	dut->ftype = 0;
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
