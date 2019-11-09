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


module adder_1b(
	input a,
	input b,
	output sum,
	//carry bits	
	input carry_in,
	output carry_out	
	
	);
	wire xorab = a ^ b;
	
	
	assign sum 	   =  xorab ^ carry_in;
	assign carry_out = ( a & b ) | (xorab & carry_in); 

endmodule
