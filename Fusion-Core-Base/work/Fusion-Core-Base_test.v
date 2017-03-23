ALU ALU_inst
(
	.op_a(op_a_sig) ,	// input [31:0] op_a_sig
	.op_b(op_b_sig) ,	// input [31:0] op_b_sig
	.out(out_sig) ,	// output [31:0] out_sig
	.op_code(op_code_sig) ,	// input [4:0] op_code_sig
	.flag_carry(flag_carry_sig) ,	// output  flag_carry_sig
	.flag_overflow(flag_overflow_sig) ,	// output  flag_overflow_sig
	.flag_parity(flag_parity_sig) ,	// output  flag_parity_sig
	.flag_neg(flag_neg_sig) 	// output  flag_neg_sig
);
