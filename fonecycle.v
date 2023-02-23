`ifndef _FONECYCLE_V_
`define _FONECYCLE_V_
`include "./params.vh"

module fonecycle(
	input [EXPWIDTH + SIGWIDTH - 1 : 0] frs1,
	input [EXPWIDTH + SIGWIDTH - 1 : 0] frs2,
	input [EXPWIDTH + SIGWIDTH - 1 : 0] frs3,
	input [XLEN - 1 : 0] rs,
	input [4 : 0] ftype,
	input fcontrol,
	input [2 : 0] roundingMode,
	output reg [EXPWIDTH + SIGWIDTH - 1 : 0] farithematic_res,
	output reg fcompare_res,
	output reg [3 : 0] fclass_res,
	output reg [5 : 0] exception_flags
);

/* Used to hold the rec format of input */
wire [EXPWIDTH + SIGWIDTH : 0] rec_frs1;
wire [EXPWIDTH + SIGWIDTH : 0] rec_frs2;
wire [EXPWIDTH + SIGWIDTH : 0] rec_frs3;


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

fNToRecFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) fn2recfn_frs3(
	.in(frs3),
	.out(rec_frs3)
);

/* Used to store rec format result */
wire [EXPWIDTH + SIGWIDTH : 0] rec_add_res;
wire [EXPWIDTH + SIGWIDTH : 0] rec_sub_res;
wire [EXPWIDTH + SIGWIDTH : 0] rec_mul_res;

/* used to store exception from different modules */
wire [5 : 0] add_exception_flags;
wire [5 : 0] sub_exception_flags;
wire [5 : 0] mul_exception_flags;

/* floating point add */
addRecFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) fadder(
	.control(fcontrol),
	.subOp(1'b0),
	.a(rec_frs1),
	.b(rec_frs2),
	.roundingMode(roundingMode),
	.out(rec_add_res),
	.exceptionFlags(add_exception_flags)
);

/* floating point sub */
addRecFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) fsuber(
	.control(fcontrol),
	.subOp(1'b1),
	.a(rec_frs1),
	.b(rec_frs2),
	.roundingMode(roundingMode),
	.out(rec_sub_res),
	.exceptionFlags(sub_exception_flags)
);

/* floating point mul */
mulRecFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) fmuler(
	.control(fcontrol),
	.a(rec_frs1),
	.b(rec_frs2),
	.roundingMode(roundingMode),
	.out(rec_mul_res),
	.exceptionFlags(mul_exception_flags)
);

/* Used to store IEEE754 format res */
wire [EXPWIDTH + SIGWIDTH - 1 : 0] add_res;
wire [EXPWIDTH + SIGWIDTH - 1 : 0] sub_res;
wire [EXPWIDTH + SIGWIDTH - 1 : 0] mul_res;

/* Convert rec format to IEEE754 format */
recFNToFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) rec2fn_add(
	.in(rec_add_res),
	.out(add_res)
);

recFNToFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) rec2fn_sub(
	.in(rec_sub_res),
	.out(sub_res)
);

recFNToFN#(
	.expWidth(EXPWIDTH),
	.sigWidth(SIGWIDTH)
) rec2fn_mul(
	.in(rec_mul_res),
	.out(mul_res)
);

/* Assign the output reg according to type */
always @ (*) begin
	case(ftype)
		5'd0: begin
			farithematic_res = add_res;
			fcompare_res = 1'b0;
			fclass_res = 4'b1010;
			exception_flags = add_exception_flags;
		end
		5'd1: begin
			farithematic_res = sub_res;
			fcompare_res = 1'b0;
			fclass_res = 4'b1010;
			exception_flags = sub_exception_flags;
			
		end
		5'd2: begin
			farithematic_res = mul_res;
			fcompare_res = 1'b0;
			fclass_res = 4'b1010;
			exception_flags = mul_exception_flags;
		end
		default: begin
			farithematic_res = 0;
			fcompare_res = 1'b0;
			fclass_res = 4'b1010;
			exception_flags = 5'b0;
		end
	endcase
end

endmodule

`endif // _FONECYCLE_V_
