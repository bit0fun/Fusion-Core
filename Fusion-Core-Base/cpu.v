/*
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
`include Maincore_Registers.v

module cpu_core(
	/* Control Signals */
	input			cpu_clk_in,
	input			master_reset,

	/* Instruction Memory Signals */
	input	[31:0]	insn_mem_in,
	output	[31:0]	insn_mem_addr_out,
	output			insn_mem_write_out, /* Only used in special cases */
	output			insn_mem_read_out,
	input			insn_mem_stall_in,
	output			insn_mem_stall_out,

	/* Data Memory Signals */
	input	[31:0]	data_mem_in,
	input	[31:0]	data_mem_addr_out,
	output	[31:0]	data_mem_out,
	output			data_mem_write_out,
	output			data_mem_read_out,
	input			data_mem_stall_in,
	output			data_mem_stall_out,

	/* Debug Connections */
	/* TO-DO */
//	input			debug_si,
//	output			debug_so,
//	input			debug_reset,
	/* END TO-DO */

);

/* Core Global Signals */
wire			g_reset; 								//global reset signal
assign 			g_reset = master_reset | debug_reset;
reg		[31:0]	pc_reg;



/* Instruction Fetch Stage / Co-Proessor Insn Routing */

/* Signals for instruction fetch stage */
wire	[31:0]	if_pc_out;
wire	[31:0]	if_insn_out;
wire	[31:0]	if_cpinsn_out;
wire			pc_change_req;
wire			pc_change_addr;
wire	[31:0]	to_cp_insn;
wire	[31:0]	to_cp_pc;
/* Instantiation of instruction fetch */
insn_fetch_32 InsnFetch(
	.insn_in( insn_mem_in ),
	.insn_pc_in( pc_reg ),
	.reset_in( g_reset ),
	.clk_in( cpu_clk_in ),
	.insn_pc_out( if_pc_out ),
	.cpinsn_out( to_cp_insn ),
	.cpinsn_pc_out( to_cp_pc ),
	.pc_change_req( pc_change_req ),
	.pc_change_addr( pc_change_addr ),

);




/* Decode Stage for Main Core instructions */

/* Decode Unit Signals */
wire	[31:0]		decode_rsa;
wire	[31:0]		decode_rsb;
wire	[31:0]		decode_rd;
wire	[31:0]		decode_regf_sel;
wire	[31:0]		decode_imm;



/* ALU instantiation */

ALU ALU_MAIN(
	.rsa(),
	.rsb(),
	.op_code(),
	.out(),
	.flag_carry(),
	.flag_overflow(),
	.flag_parity(),
	.flag_neg()

);
