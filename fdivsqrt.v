`ifndef _FDIVSQRT_V_
`define _FDIVSQRT_V_
`include "./params.vh"

module fdivsqrt(
	input clk,
	input rst,
	input [EXPWIDTH + SIGWIDTH - 1 : 0] frs1,
	input [EXPWIDTH + SIGWIDTH - 1 : 0] frs2,
	input ftype,
	input fcontrol,
	input valid_in,
	input [2 : 0] roundingMode,
	output reg [EXPWIDTH + SIGWIDTH - 1 : 0] farithematic_res,
	output reg [4 : 0] exception_flags,
	output reg ready_out,
	output reg finish
);

reg [EXPWIDTH + SIGWIDTH : 0] rec_frs1;
reg [EXPWIDTH + SIGWIDTH : 0] rec_frs2;
reg sqrtop;
reg [EXPWIDTH + SIGWIDTH : 0] divsqrt_res;

/* Convert IEEE754 to rec format */
fNToRecFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) fn2recfn_frs1(
	.in(frs1),
	.out(rec_frs1)
);

fNToRecFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) fn2recfn_frs2(
	.in(frs2),
	.out(rec_frs2)
);

/* div or sqrt */
divSqrtRecFN_small#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) divsqrt(
	.clock(clk),
	.nReset(~rst),
	.control(fcontrol),
	.inValid(valid_in),
	.sqrtOp(ftype),
	.a(rec_frs1),
	.b(rec_frs2),
	.roundingMode(roundingMode),
	.outValid(finish),
	.sqrtOpOut(sqrtop),
	.out(divsqrt_res),
	.exceptionFlags(exception_flags),
	.inReady(ready_out)
);

/* Convert res to IEEE754 */
recFNToFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) rec2fn_divsqrt (
	.in(divsqrt_res),
	.out(farithematic_res)
);
endmodule
`endif // _FDIVSQRT_V_
