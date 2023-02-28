#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfdivsqrt.h"

#define NUM_OF_TESTCASES 3
#define MAX_SIM_TIME (NUM_OF_TESTCASES * 60)
#define SUBMODULE_DEPTH 5
int sim_time = 0;

static unsigned int frs1_data[NUM_OF_TESTCASES] = {
	0x40490FDB,
	0xC49A4000,
	0x40490FDB
};

static unsigned int frs2_data[NUM_OF_TESTCASES] = {
	0x402DF854,
	0x449A6333,
	0x3F800000
};

int main() {
	Vfdivsqrt *dut = new Vfdivsqrt;
	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;  
	dut->trace(m_trace, SUBMODULE_DEPTH);               
	m_trace->open("waveform.vcd");

	
	/* The operation is fdiv.s */
	dut->ftype = 0;
	dut->fcontrol = 0;
	/* roundingMode is 000 */
	dut->roundingMode = 0;
	dut->valid_in = 1;

	while (sim_time < MAX_SIM_TIME) {
		
		dut->clk ^= 1;
		dut->frs1 = frs1_data[sim_time / 60];
		dut->frs2 = frs2_data[sim_time / 60];

		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
