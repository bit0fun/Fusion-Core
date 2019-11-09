/*
*
*  This file is part of Fusion-Core-ISA.
*  Author: Dylan Wadler dylan@fusion-core.org
*
*  Fusion-Core-ISA is free software: you can redistribute it and/or modify
*  it under the terms of the GNU General Public License as published by
*  the Free Software Foundation, either version 3 of the License, or
*  (at your option) any later version.
*
*  Fusion-Core-ISA is distributed in the hope that it will be useful,
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*  GNU General Public License for more details.
*
*  You should have received a copy of the GNU General Public License
*  along with Fusion-Core-ISA.  If not, see <http://www.gnu.org/licenses/>.
*/



/*ALU Module Includes*/
`include "ALUOP/add_32.v"
`include "ALUOP/and_32.v"
`include "ALUOP/not_32.v"
`include "ALUOP/or_32.v"
`include "ALUOP/xor_32.v"
`include "ALUOP/shift_carry_right_32.v"
`include "ALUOP/shift_left_32.v"
`include "ALUOP/shift_right_32.v"
`include "ALUOP/compare_32.v"

module ALU(
//32 bit ALU, will upgrade to 64 bit after tests are done.

	//Values from register file to operate on
	input [31:0] rsa;
	input [31:0] rsb;

	//op code, decoded from instruction
	input [3:0] op_code; //4 bit opcode

	//output from the ALU
	output reg [31:0] out;

	//Flags
	output reg flag_carry;
	output flag_overflow;
	output flag_parity; //even parity of output, 1 valid, 0 invalid
	output flag_neg; //output is negative
	);

	/*Wires*/
	wire [31:0] to_out;
	wire [31:0] w_and;
	wire [31:0] w_or;
	wire [31:0] w_xor;
	wire [31:0] w_not;
	wire [31:0] w_shl; //shift left
	wire [31:0] w_shr; //shift right
	wire [31:0] w_scr; //shift carry right
	wire [31:0] w_cmp; //compare; 0 if true, -1 if less, 1 if greater
	wire [31:0] w_add;
	wire [31:0] w_sub;

	wire flg_carry_sub, flg_carry_add;


	/*Instantiations of ALU Modules*/

	//Add
	add_32 add_32(
	.reg_a(rsa),
	.reg_b(rsb),
	.out(w_add),
	.flg_carry(flg_carry_add),
	.carryin(1'b0)

	);

	//Subtract
	add_32 sub_32(
	.reg_a(rsa),
	.reg_b(rsb),
	.out(w_sub),
	.flg_carry(flg_carry_sub),
	.carryin(1'b1)	//2's compliment, so need this to be a 1

	);

	//Increment
	add_32 inc_32(
	.reg_a(rsa),
	.reg_b(32'b0001),
	.out(w_inc),
	.flg_carry(),
	.carryin(1'b0)
	);

	//Decrement
	add_32 dec_32(
	.reg_a(rsa),
	.reg_b('hFffF), //-1, 2's compliment
	.out(w_dec),
	.flg_carry(),
	.carryin(1'b1)	//2's compliment, so need this to be a 1

	);

	//AND
	and_32 and_32(
	.a(rsa), //input values
	.b(rsb),
	.out(w_and) //output value
	);

	//OR
	or_32 or_32(
	.a(rsa), //input values
	.b(rsb),
	.out(w_or) //output value
	);

	//XOR
	xor_32 xor_32(
	.a(rsa), //input values
	.b(rsb),
	.out(w_xor) //output value
	);


	//NOT
	not_32 not_32(
	.a(rsa), //input value
	.out(w_not) //output value
	);


	always@*

		case(op_code)
		/*0*/	4'b0000:begin	//output for ADD operation
					out <= w_add;
					flag_carry <= flg_carry_add;
				 end
		/*1*/	4'b0001:begin	//output for SUBTRACT operation
					out <= w_sub;
					flag_carry <= flg_carry_sub;
				end
		/*2*/	4'b0010:begin	//reserved
					out <= 0;
				end
		/*3*/	4'b0011:begin 	//reserved
					out<= 0;
				end
		/*4*/	4'b0100:begin	//output NOT operation
					out <= w_not;
				 end
		/*5*/	4'b0101:begin	//output AND operation
					out <= w_and;
				 end
		/*6*/	4'b0110:begin	//output OR operation
					out <= w_or;
				 end
		/*7*/	4'b0111:begin  //output XOR operation
					out <= w_xor;
				 end
		/*8*/	4'b1000:begin	//output shift left operation (arithmetic)
					out	<= w_scl;
				 end
		/*9*/	4'b1001:begin 	//output shift right operation (arithmetic)
					out <= w_scr;

				 end
		/*10*/	4'b1010:begin //output shift right operation 
					out <= w_shr;
				 end
		/*11*/	4'b1011:begin //output shift left operation
					out <= w_scl; //shift left and shift carry left are the same thing
				 end
		/*12*/	4'b1100:begin //output compare operation
					out <= w_cmp;
				 end
		/*13*/	4'b1101:begin
					out <= 0;
				 end
		/*14*/	4'b1110:begin
					out <= 0;
				 end
		/*15*/	4'b1111:begin
					out <= 0;
				 end
			endcase


endmodule:
