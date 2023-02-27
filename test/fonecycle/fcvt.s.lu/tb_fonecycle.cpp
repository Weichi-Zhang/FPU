#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfonecycle.h"

#define NUM_OF_TESTCASES 2
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 5)
#define SUBMODULE_DEPTH 5
int sim_time = 0;

static signed int rs1_data[NUM_OF_TESTCASES] = {
	2,
	-2
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
	/* The operation is fcvt.s.lu */
	dut->ftype = 16;
	dut->fcontrol = 0;
	/* roundingMode is 000 */
	dut->roundingMode = 0;


	while (sim_time < MAX_SIM_TIME) {
		
		dut->long_rs = rs1_data[sim_time / 5];

		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
