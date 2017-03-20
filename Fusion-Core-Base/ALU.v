/*
  This file is part of Fusion-Core-ISA.

    Fusion-Core-ISA is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Fusion-Core-ISA is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Fusion-Core-ISA.  If not, see <http://www.gnu.org/licenses/>.
*/


/*ALU Module Includes*/
`include "carry_lookahead_8b.v"


module ALU(op_a, op_b, out, op_code, flag_carry, flag_overflow, flag_parity, flag_neg);
//32 bit ALU, will upgrade to 64 bit after tests are done.

	//Values from register file to operate on
	input [31:0] op_a;
	input [31:0] op_b;

	//op code, decoded from instruction
	input [4:0] op_code; //5 bit opcode

	//output from the ALU
	output reg [31:0] out;

	//Flags
	output flag_carry;
	output flag_overflow;
	output flag_parity; //even parity of output, 1 valid, 0 invalid
	output flag_neg; //output is negative


	/*Wires*/
	wire [31:0] to_out;
	wire [31:0] w_and;
	wire [31:0] w_or;
	wire [31:0] w_xor;
	wire [31:0] w_not;
	wire [31:0] w_shl; //shift left
	wire [31:0] w_shr; //shift right
	wire [31:0] w_scl; //shift carry left
	wire [31:0] w_scr; //shift carry right
	wire [31:0] w_slt; //set less than, 1 if true, 0 if false
	wire [31:0] w_add;
	wire [31:0] w_sub;
	wire [31:0] w_inc; //increment
	wire [31:0] w_dec; //decrement

	


	/*Instantiations of ALU Modules*/

	//Add
	add_32 add_32(
	.reg_a(op_a),
	.reg_b(op_b),
	.out(w_add),
	.flg_carry(flag_carry),
	.carryin(1'b0)

	);

	//Subtract
	add_32 sub_32(
	.reg_a(op_a),
	.reg_b(op_b),
	.out(w_sub),
	.flg_carry(flag_carry),
	.carryin(1'b1)	//2's compliment, so need this to be a 1

	);


	always@*
		
		case(op_code)
		/*0*/	5'b00000:begin	//for NOP
					out <= 0; 			
				 end
		/*1*/	5'b00001:begin	//output AND operation
					out <= w_add;
				 end
		/*2*/	5'b00010:begin	//output OR operation
					out <= w_or;
				 end
		/*3*/	5'b00011:begin  //output XOR operation
					out <= w_xor;
				 end
		/*4*/	5'b00100:begin	//output NOT operation
					out <= w_not;
				 end
		/*5*/	5'b00101:begin	//output shift left operation
					out <= w_shl;
				 end
		/*6*/	5'b00110:begin 	//output shift right operation
					out <= w_shr;
				 end
		/*7*/	5'b00111:begin //output shift carry left operation
					out <= w_scl;
				 end
		/*8*/	5'b01000:begin //output shift carry left operation
					out <= w_scr;
				 end
		/*9*/	5'b01001:begin //output set less than operation
					out <= w_slt;
		 		 end
/*------------------------------RESERVED START-----------------------------------*/
		/*10*/	5'b01010:begin
					out <= 0;
				 end
		/*11*/	5'b01011:begin
					out <= 0;
				 end
		/*12*/	5'b01100:begin
					out <= 0;
				 end
		/*13*/	5'b01101:begin
					out <= 0;
				 end
		/*14*/	5'b01110:begin
					out <= 0;
				 end
		/*15*/	5'b01111:begin
					out <= 0;
				 end
/*-------------------------------RESERVED END-----------------------------------*/
		/*16*/	5'b10000:begin	//output for ADD operation
					out <= w_add;
				 end
		/*17*/	5'b10001:begin	//output for SUBTRACT operation
					out <= w_sub;
				 end
		/*18*/	5'b10010:begin	//output for INCREMENT operation
					out <= w_inc;
				 end
		/*19*/	5'b10011:begin	//output for DECREMENT operation
					out <= w_dec;
				 end

/*------------------------------RESERVED START-----------------------------------*/
		/*20*/	5'b10100:begin
					out <= 0;
				 end
		/*21*/	5'b10101:begin
					out <= 0;
				 end
		/*22*/	5'b10110:begin
					out <= 0;
				 end
		/*23*/	5'b10111:begin
					out <= 0;
				 end
		/*24*/	5'b11000:begin
					out <= 0;
				 end
		/*25*/	5'b11001:begin
					out <= 0;
				 end
		/*26*/	5'b11010:begin
					out <= 0;
				 end
		/*27*/	5'b11011:begin
					out <= 0;
				 end
		/*28*/	5'b11100:begin
					out <= 0;
				 end
		/*29*/	5'b11101:begin
					out <= 0;
				 end
		/*30*/	5'b11110:begin
					out <= 0;
				 end
		/*31*/	5'b11111:begin
					out <= 0;
				 end
/*-------------------------------RESERVED END-----------------------------------*/
			endcase


endmodule

