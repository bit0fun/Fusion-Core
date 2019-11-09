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
`include "REGFILES/RegisterFile.v"

module MainCore_Registers(
	input			clk_in,
	input			reset_in,
 
 	input	[3:0]	bank_sel_in,		//register bank select input
	input	[4:0]	rsa_in,
	input	[4:0]	rsb_in,
	input	[4:0]	rd_in,

	output	[31:0]	rsa_val_out,
	output	[31:0]	rsb_val_out,
	input	[31:0]	rd_val_in,
	input	[4:0]	wb_bank_sel_in,		//writeback bank select
	input			wb_in,				//initiate writeback
	input			hi_in,				//High and low register writeback
	input			low_in

 
);
/* Wire defintions */
wire			wb_upper_nlower_w;
assign			wb_upper_nlower_w = bank_sel_in[2];

/* General Purpose Register File*/
wire	[31:0]	rsa_val_gpregf_w;
wire	[31:0]	rsb_val_gpregf_w;
wire			sel_gpregf_w;
wire			wb_gpregf_w;


assign			sel_gpregf_w = ~(bank_sel_in[1] & bank_sel_in[0]);
assign			wb_gpregf_w = ~(wb_bank_sel_in[1] & wb_bank_sel_in[0]);



RegisterFile GPREGF(
		.sel_in(sel_gpregf_w),
		.clk_in(clk_in),
		.reset_in(reset_in),
		.rsa_in(rsa_in),
		.rsb_in(rsb_in),
		.rd_in(rd_in),
		.wb_in(wb_gpregf_w),
		.rsa_val_out(rsa_val_gpregf_w),
		.rsb_val_out(rsb_val_gpregf_w),
		.rd_val_in(rd_val_in),
		.wb_u_nl_in(wb_upper_nlower_w)
);

/* System Register File*/

wire	[31:0]	rsa_val_sysregf_w;
wire	[31:0]	rsb_val_sysregf_w;
wire			sel_sysregf_w;
wire			wb_sysregf_w;


assign			sel_sysregf_w = ~bank_sel_in[1] & bank_sel_in[0];
assign			wb_sysregf_w = ~wb_bank_sel_in[1] & wb_bank_sel_in[0];



RegisterFile SYSREGF(
		.sel_in(sel_sysregf_w),
		.clk_in(clk_in),
		.reset_in(reset_in),
		.rsa_in(rsa_in),
		.rsb_in(rsb_in),
		.rd_in(rd_in),
		.wb_in(wb_sysregf_w),
		.rsa_val_out(rsa_val_sysregf_w),
		.rsb_val_out(rsb_val_sysregf_w),
		.rd_val_in(rd_val_in),
		.wb_u_nl_in(wb_upper_nlower_w)
);



/* Global Register File*/

wire	[31:0]	rsa_val_gblregf_w;
wire	[31:0]	rsb_val_gblregf_w;
wire			sel_gblregf_w;
wire			wb_gblregf_w;


assign			sel_gblregf_w = bank_sel_in[1] & ~bank_sel_in[0];
assign			wb_gblregf_w = wb_bank_sel_in[1] & ~wb_bank_sel_in[0];



RegisterFile GBLREGF(
		.sel_in(sel_gblregf_w),
		.clk_in(clk_in),
		.reset_in(reset_in),
		.rsa_in(rsa_in),
		.rsb_in(rsb_in),
		.rd_in(rd_in),
		.wb_in(wb_gblregf_w),
		.rsa_val_out(rsa_val_gblregf_w),
		.rsb_val_out(rsb_val_gblregf_w),
		.rd_val_in(rd_val_in),
		.wb_u_nl_in(wb_upper_nlower_w)
);

always @(posedge clk) begin
	case ({bank_sel_in[1], bank_sel_in[0]}) //only need to look at lower two bits
		2'b00 : begin	
			rsa_val_out	<= rsa_val_gpregf_w;
			rsb_val_out <= rsa_val_gpregf_w;
			end
		2'b01 : begin	
			rsa_val_out	<= rsa_val_sysregf_w;
			rsb_val_out <= rsa_val_sysregf_w;
			end
		2'b10 : begin	
			rsa_val_out	<= rsa_val_glbregf_w;
			rsb_val_out <= rsa_val_glbregf_w;
			end
		default : begin
			rsa_val_out <= 32'b0;
			rsb_val_out <= 32'b0;
		endcase


end

endmodule
