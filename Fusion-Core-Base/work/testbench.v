module testbench();

reg [31:0] out;
wire[31:0] a, b;


assign LEDR = out[17:8];
assign LEDG = out[7:0];


assign a = 0 | SW[4:0];
assign b = 0 | SW[9:5];

ALU ALU_inst
(
	.op_a(a) ,	// input [31:0] op_a_sig
	.op_b(b) ,	// input [31:0] op_b_sig
	.out(out) ,	// output [31:0] out_sig
	.op_code(5'b10000) ,	// input [4:0] op_code_sig
	.flag_carry() ,	// output  flag_carry_sig
	.flag_overflow() ,	// output  flag_overflow_sig
	.flag_parity() ,	// output  flag_parity_sig
	.flag_neg() 	// output  flag_neg_sig
);

endmodule
