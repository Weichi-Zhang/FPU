#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfonecycle.h"

#define NUM_OF_TESTCASES 10
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
#define NaN 0x7FC00000
int sim_time = 0;

static unsigned int frs1_data[NUM_OF_TESTCASES] = {
	0x40200000,
	0xC49A6333,
	0x3F8CCCCD,
	NaN,
	0x40490FDB,
	0xBF800000,
	0x7F800001,
	NaN,
	0x80000000,
	0x00000000
};

static unsigned int frs2_data[NUM_OF_TESTCASES] = {
	0x3F800000,
	0x3F8CCCCD,
	0xC49A6333,
	0xC49A6333,
	0x322BCC77,
	0xC0000000,
	0x3F800000,
	NaN,
	0x00000000,
	0x80000000
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
	/* The operation is fmax.s */
	dut->ftype = 4;
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
