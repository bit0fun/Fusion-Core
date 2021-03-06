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

module shift_right_32(
	input[31:0] a, //value to be shifted
	output[31:0] out //output
	);

	//shifts everything right by 1
	assign out[0] = a[1];
	assign out[1] = a[2];
	assign out[2] = a[3];
	assign out[3] = a[4];
	assign out[4] = a[5];
	assign out[5] = a[6];
	assign out[6] = a[7];
	assign out[7] = a[8];
	assign out[8] = a[9];
	assign out[9] = a[10];
	assign out[10] = a[11];
	assign out[11] = a[12];
	assign out[12] = a[13];
	assign out[13] = a[14];
	assign out[14] = a[15];
	assign out[15] = a[16];
	assign out[16] = a[17];
	assign out[17] = a[18];
	assign out[18] = a[19];
	assign out[19] = a[20];
	assign out[20] = a[21];
	assign out[21] = a[22];
	assign out[22] = a[23];
	assign out[23] = a[24];
	assign out[24] = a[25];
	assign out[25] = a[26];
	assign out[26] = a[27];
	assign out[27] = a[28];
	assign out[28] = a[29];
	assign out[29] = a[30];
	assign out[30] = a[31];
	assign out[31] = a[31];

endmodule
