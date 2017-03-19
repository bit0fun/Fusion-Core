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

`include "adder_1b.v"

module carry_lookahead_8b(

	input[7:0] reg_a,
	input[7:0] reg_b,
	input	carryin,
	output[7:0] out,
	output	carry_out

	);
	parameter NBIT = 8;
	//parameter carryin = 1'b0;

	/*Wires*/



	wire[(NBIT-1):0] bit_sum; 	//only 1 bit, make
	wire[(NBIT-1):0] p;	    	//values for fast carry
	wire[(NBIT-1):0] g;
	wire[(NBIT-1):0] carry;		//intermediary carry bits, carry_out value is just assigned instead of last carry 
	
	/*Carry generator intermediary step*/
	wire[(NBIT):1] carry_p; 	//p[n] & p[n-1] & ... & carryin
	wire[(NBIT):1] carry_g;		//(g[0] & p[n] & p[n-1]...)


	genvar i; //for counter

	begin
	for(i = 0; i < NBIT; i = i+1)
		assign g[i] = reg_a[i] & reg_b[i];
	end

	begin
	for(i = 0; i < NBIT; i = i+1)
		assign p[i] = reg_a[i] | reg_b[i];
	end


	/*Intermediary Carry Assignments*/

	/*p value generate*/
	assign carry_p[1]  = p[0] & carryin;
	assign carry_p[2]  = p[0] & p[1] & carryin;
	assign carry_p[3]  = p[0] & p[1] & p[2] & carryin;
	assign carry_p[4]  = p[0] & p[1] & p[2] & p[3] & carryin;
	assign carry_p[5]  = p[0] & p[1] & p[2] & p[3] & p[4] & carryin;
	assign carry_p[6]  = p[0] & p[1] & p[2] & p[3] & p[4] & p[5] & carryin;
	assign carry_p[7]  = p[0] & p[1] & p[2] & p[3] & p[4] & p[5] & p[6] & carryin;
	assign carry_p[8]  = p[0] & p[1] & p[2] & p[3] & p[4] & p[5] & p[6] & p[7] & carryin;

	/*g value generate*/
	assign carry_g[1] = g[0];
	assign carry_g[2] = (g[0] & p[1]) + g[1];
	assign carry_g[3] = (g[0] & p[1] & p[2]) + (g[1] & p[2]) + g[2];
	assign carry_g[4] = (g[0] & p[1] & p[2] & p[3]) + (g[1] & p[2] & p[3]) + (g[2] & p[3]) + g[3];
	assign carry_g[5] = (g[0] & p[1] & p[2] & p[3] & p[4]) + (g[1] & p[2] & p[3] & p[4]) + (g[2] & p[3] & p[4]) + (g[3] & p[4]) + g[4];
	assign carry_g[6] = (g[0] & p[1] & p[2] & p[3] & p[4] & p[5]) + (g[1] & p[2] & p[3] & p[4] & p[5]) + (g[2] & p[3] & p[4] & p[5]) 
		+ (g[3] & p[4] & p[5]) + (g[4] & p[5]) + g[5];
	assign carry_g[7] = (g[0] & p[1] & p[2] & p[3] & p[4] & p[5] & p[6]) + (g[1] & p[2] & p[3] & p[4] & p[5] & p[6]) + (g[2] & p[3] & p[4] & p[5] & p[6]) 
		+ (g[3] & p[4] & p[5] & p[6]) + (g[4] & p[5] & p[6]) + (g[5] & p[6]) + g[6];
	assign carry_g[8] = (g[0] & p[1] & p[2] & p[3] & p[4] & p[5] & p[6] & p[7]) + (g[1] & p[2] & p[3] & p[4] & p[5] & p[6]& p[7]) 
		+ (g[2] & p[3] & p[4] & p[5] & p[6]& p[7]) + (g[3] & p[4] & p[5] & p[6] & p[7]) + (g[4] & p[5] & p[6] & p[7]) 
		+ (g[5] & p[6] & p[7]) + (g[6] & p[7]) + g[7];

	/*Final carry values generate*/
	assign carry[0]  = carryin;
	assign carry[1]  = carry_p[1] + carry_g[1];
	assign carry[2]  = carry_p[2] + carry_g[2];
	assign carry[3]  = carry_p[3] + carry_g[3];
	assign carry[4]  = carry_p[4] + carry_g[4];
	assign carry[5]  = carry_p[5] + carry_g[5];
	assign carry[6]  = carry_p[6] + carry_g[6];
	assign carry[7]  = carry_p[7] + carry_g[7];
	assign carry_out  = carry_p[8] + carry_g[8];
	


	/*Instantiated modules*/
	
	adder_1b add_b0( //Bit 0
	.a(reg_a[0]),
	.b(reg_b[0]),
	.sum(out[0]),
	.carry_in(carry[0]),
	.carry_out()
	);

	adder_1b add_b1( //Bit 1
	.a(reg_a[1]),
	.b(reg_b[1]),
	.sum(out[1]),
	.carry_in(carry[1]),
	.carry_out()
	);	

	adder_1b add_b2( //Bit 2
	.a(reg_a[2]),
	.b(reg_b[2]),
	.sum(out[2]),
	.carry_in(carry[2]),
	.carry_out()
	);

	adder_1b add_b3( //Bit 3
	.a(reg_a[3]),
	.b(reg_b[3]),
	.sum(out[3]),
	.carry_in(carry[3]),
	.carry_out()
	);	

	adder_1b add_b4( //Bit 4
	.a(reg_a[4]),
	.b(reg_b[4]),
	.sum(out[4]),
	.carry_in(carry[4]),
	.carry_out()
	);

	adder_1b add_b5( //Bit 5
	.a(reg_a[5]),
	.b(reg_b[5]),
	.sum(out[5]),
	.carry_in(carry[5]),
	.carry_out()
	);	

	adder_1b add_b6( //Bit 6
	.a(reg_a[6]),
	.b(reg_b[6]),
	.sum(out[6]),
	.carry_in(carry[6]),
	.carry_out()
	);

	adder_1b add_b7( //Bit 7
	.a(reg_a[7]),
	.b(reg_b[7]),
	.sum(out[7]),
	.carry_in(carry[7]),
	.carry_out()
	);	
	






endmodule