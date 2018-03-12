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


module RegisterFile(

	/*Data*/
	input[31:0] rd_val_in, //only one input needed
	input[16:0]	rd_half_in,	//for unsigned LI instructions

	output reg[31:0] rsa_val_out,
	output reg[31:0] rsb_val_out,

	/*Addresses*/
	input[4:0]  rsa_in, //used for input addresses
	input[4:0]  rsb_in,
	input[4:0]	rd_in,	//writeback register
	
	/*Control Lines*/
	input wb_in,  //write back signal; if high, write value to rd
	input clk_in, //clock for synchronous registers
	input sel_in, //chip select line, active low
	input reset_in,
	input wb_u_nl_in,	//writeback upper half when 1, low when 0, input
	);


	/*Registers*/
	reg	[31:0] registers [4:0];	//32 registers in 1 bank, 32 bits wide

	always@ (posedge clk_in or negedge reset_in) begin
		if(~reset_in) begin
			registers = {32{32'b0}}; //set all regsiters to 0
		end else begin
			rsa_val_out <= registers[rsa_in];
			rsb_val_out	<= registers[rsb_in];

			if(wb_in & ~wb_uh_in & ~wb_lh_in) begin //we are writing a value 
				registers[rd_in] <= rd_val_in;
			end else if( wb_in & wb_uh_in & ~wb_lh_in) begin
				registers[rd_in][31:16] <= rd_val_in[15:0];
			end else if( wb_in & ~wb_uh_in & wb_lh_in) begin
				registers[rd_in][15:0] <= rd_val_in[15:0];
			end
		end
endmodule
