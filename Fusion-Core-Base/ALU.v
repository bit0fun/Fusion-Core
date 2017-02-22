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




module ALU(op_a, op_b, out, op_code, ar_code);
//32 bit ALU, will upgrade to 64 bit after tests are done.

	//Values from register file to operate on
	input [31:0] op_a;
	input [31:0] op_b;

	//op code, decoded from instruction
	input [6:0] op_code;

	//arithmetic code, for more math operations
	input [5:0] ar_code;

	//output from the ALU
	output reg [31:0] out;
	


	/*Wires*/
	wire [31:0] to_out;
	wire [31:0] w_and;

	always@*
		if(op_code == 6'b000000)
			case(ar_code)
		/*0*/	5'b00000:begin	//for NOP
					out <= 0; 			
				 end
		/*1*/	5'b00001:begin
					out <= w_add;
				 end
		/*2*/	5'b00010:
		/*3*/	5'b00011:
		/*4*/	5'b00100:
		/*5*/	5'b00101:
		/*6*/	5'b00110:
		/*7*/	5'b00111:
		/*8*/	5'b01000:
		/*9*/	5'b01001:
		/*10*/	5'b01010:
		/*11*/	5'b01011:
		/*12*/	5'b01100:
		/*13*/	5'b01101:
		/*14*/	5'b01110:
		/*15*/	5'b01111:
		/*16*/	5'b10000:
		/*17*/	5'b10001:
		/*18*/	5'b10010:
		/*19*/	5'b10011:
		/*20*/	5'b10100:
		/*21*/	5'b10101:
		/*22*/	5'b10110:
		/*23*/	5'b10111:
		/*24*/	5'b11000:
		/*25*/	5'b11001:
		/*26*/	5'b11010:
		/*27*/	5'b11011:
		/*28*/	5'b11100:
		/*29*/	5'b11101:
		/*30*/	5'b11110:
		/*31*/	5'b11111:
			endcase


endmodule

