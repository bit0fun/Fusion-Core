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

`include decode_32.v
`include Maincore_Registers.v

module decode_stage(
	input				clk_in,
	input				reset_in,

	/* Instruction Signals */
	input		[31:0]	insn_in,
	input		[31:0]	insn_pc_in,

	output		[31:0]	insn_out,
	output		[31:0]	insn_pc_out,
	
	/* Control output signals */
	input				stall_in,			/* Joseph Stall_in ? */
	output	reg			stall_out,
	output	reg			pc_change_abs_out,	/* Absolute PC Change */
	output	reg			pc_change_rel_out,	/* Relative PC Change */
	output	reg			pc_link_out,		/* PC Link Signal */
	output	reg	[1:0]	branch_funct_out,	/* Branch Function Output */

	output	reg			memsync_out,
	output	reg			syscall_out,
	output	reg			mem_read_out,
	output	reg			mem_write_out,

	/* Register File Signals */
	output	reg [31:0]	rsa_val_out,		/* RSA Value to ALU */
	output	reg [31:0]	rsb_val_out,		/* RSB Value to ALU */

	output	reg [4:0]	rsa_addr_out,		/* RSA Address */
	output	reg [4:0]	rsb_addr_out,		/* RSB Address */
	output	reg [4:0]	rd_addr_out,		/* RD  Address */
	output	reg [4:0]	rd_regf_out,		/* RD Register File */

	input		[4:0]	wb_reg_addr_in,		/* Writeback Register Address */
	input		[31:0]	wb_reg_val_in,		/* Writeback Register Value */
	input		[4:0]	wb_regf_sel_in,		/* Writeback Register Bank */

	/* ALU*/
	output	reg	[3:0]	aluop_out,			/* ALU Operation Output */	
	output	reg [31:0]	imm_out,			/* Immediate Value Output */		
	output	reg 		use_imm_out,		/* Immediate Value Usage */
	);

/* Internal Signals */

/* Register Control Signals */
wire [4:0]	regf_sel;	/* Register Bank Select */
wire [4:0]	rsa_addr;	/* RSA Address */ 
wire [4:0]	rsb_addr;	/* RSB Address */



/* Module Instantiations */

/* Instantiation of Decode Unit */
decode_32 Decode_MAIN(
		.insn_in( insn_in ),
		.reset_in( reset_in ),
		.clk_in( clk_in ),
		.insn_pc_in( insn_pc_in ),
		.stall_in( stall_in ), /* Don't stall, yet */
		
		.reg_select_out( regf_sel ),
		.rsa_out( rsa_addr ),
		.rsb_out( rsb_addr ),
		.rd_out( rd_addr ),
		.imm_out( imm_out ),
	
		.aluop_out( aluop_out ),
		.jlnk_out( pc_link_out ),
		.pc_change_rel_out( pc_change_rel_out ),
		.pc_change_abs_out( pc_change_abs_out ),
		.mem_read_out( mem_read_out ),
		.mem_write_out( mem_write_out ),
		.syscall_out(),
		.pem_inc_req_out(),
		.pem_dec_req_out(),
		.sysreg_addr_out(),
		.sysreg_data_out(),
		.sysreg_data_in()
);

/* Main Core Register Files Instantiation */
MainCore_Registers MCRegFiles(
	.clk_in( clk_in ),
	.reset_in( reset_in ),
	.bank_sel_in( regf_sel ),
	.rsa_in( rsa_addr ),
	.rsb_in( rsb_addr ),
	.rd_in( wb_reg_addr_in ),
	.rd_val_in( wb_reg_val_in ),
	.rsa_val_out( rsa_val_out ),
	.rsb_val_out( rsb_val_out ),
	.wb_bank_sel_in( wb_regf_sel_in ),
	.hi_in(32'b0), /* Not going to use 64 bit writeback yet */
	.low_in(32'b0)

);

