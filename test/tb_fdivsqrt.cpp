#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vfdivsqrt.h"


#define MAX_SIM_TIME 20
#define SUBMODULE_DEPTH 5
int sim_time = 0;

int main() {
	Vfdivsqrt *dut = new Vfdivsqrt;
	Verilated::traceEverOn(true);
	VerilatedVcdC *m_trace = new VerilatedVcdC;  
	dut->trace(m_trace, SUBMODULE_DEPTH);               
	m_trace->open("waveform.vcd");

	while (sim_time < MAX_SIM_TIME) {
		
		
		m_trace->dump(sim_time);
		sim_time++;
	}

	m_trace->close();
	delete dut;
	exit(EXIT_SUCCESS);
}
