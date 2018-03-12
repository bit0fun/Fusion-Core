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

`include ALU.v
`include decode_32.v

decode_32 Decode_MAIN(
		.insn_in(),
		.reset_in(),
		.clk_in(),
		.insn_pc_in(),
		.stall_in(),
		.reg_select_out(),
		.rsa_out(),
		.rsb_out(),
		.rd_out(),
		.imm_out(),


);
