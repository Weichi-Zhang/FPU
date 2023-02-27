#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfonecycle.h"

#define NUM_OF_TESTCASES 8
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
int sim_time = 0;

static unsigned int frs1_data[NUM_OF_TESTCASES] = {
	0xBF8CCCCD,
	0xBF800000,
	0xBF666666,
	0x3F666666,
	0x3F800000,
	0x3F8CCCCD,
	0xCF32D05E,
	0x4F32D05E
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
	/* The operation is fcvt.w.s */
	dut->ftype = 9;
	dut->fcontrol = 0;
	/* roundingMode is 001 */
	dut->roundingMode = 001;


	while (sim_time < MAX_SIM_TIME) {
		
		dut->frs1 = frs1_data[sim_time / 5];

		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
