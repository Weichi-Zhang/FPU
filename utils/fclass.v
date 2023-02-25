module fclass(
	input [FLEN - 1 : 0] frs,
	output reg [9 : 0] class
);

/* Variables for implementing fclass */
reg is_neg_infinity;
reg is_neg_normal_number;
reg is_neg_subnormal_number;
reg is_neg_zero;
reg is_pos_zero;
reg is_pos_subnormal_number;
reg is_pos_normal_number;
reg is_pos_infinity;
reg is_signaling_NaN;
reg is_quiet_NaN;



endmodule
