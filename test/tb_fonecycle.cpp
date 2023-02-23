#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfonecycle.h"


#define MAX_SIM_TIME 20
#define SUBMODULE_DEPTH 5
int sim_time = 0;

int main() {
	Vfonecycle *dut = new Vfonecycle;
	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;  
	dut->trace(m_trace, SUBMODULE_DEPTH);               
	m_trace->open("waveform.vcd");

	while (sim_time < MAX_SIM_TIME) {
		
		dut->frs1 = 0x3F8CCCCD;
		dut->frs2 = 0x400CCCCD;
		dut->frs3 = 0x0;
		dut->rs = 0x0;
		dut->fcontrol = 1;
		dut->roundingMode = 0;
		
		if (0 <= sim_time && sim_time <= 10) {
			dut->ftype = 0;
		}
		else {
			dut->ftype = 2;
		}
		dut->eval();  
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
