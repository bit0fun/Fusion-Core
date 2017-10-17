module decode_32(
	input[31:0] 	inst_in;			//input instruction
	input			reset_in;			//input reset line
	input			clk_in;				//input clock


	/*Register output connections*/
	output[4:0] reg reg_select_out;		//output register bank select
	output[4:0]	reg reg_a_out;			//output of register a address
	output[4:0] reg reg_b_out;			//output of register b address
	output[4:0]	reg reg_dest_out;		//output of destination register address

	output		reg illeg_inst_flg_out;	//output of illegal instruction flag


	);

/**************************************************/
/*			32 Bit Instruction					  */
/**************************************************/
/*				Integer instructions			  */
/*|		   |	  |		 |		|  		|		 |*/
/*| opcode |  rd  |  ra  |  rb  | 	?	| aluop  |*/
/*|	       |	  |	 	 |		|  		|		 |*/
/* 31    26 25  21 20  16 15  11 10	   4 3		0 */
/**************************************************/
/*				Immediate Instruction		      */
/*|		   |	  |		 		 		|		 |*/
/*| opcode |  rd  |   	Immediate		| aluop  |*/
/*|	       |	  |	 	 		  		|		 |*/
/* 31    26 25  21 20  		    	   4 3		0*/
/**************************************************/
/*			Branch/Jump instructions			  */
/*|		   |	  |		 |		  		|		 |*/
/*| opcode |  rd  |  ra  |   Address 	| aluop  |*/
/*|	       |	  |	 	 |		  		|		 |*/
/* 31    26 25  21 20  16 15  	 	   4 3 		0 */
/**************************************************/
/*				Load/Store Instruction		      */
/*|		   |	  |		 |		 				 |*/
/*| opcode |  rd  |  ra  |		  Address		 |*/
/*|	       |	  |	 	 |		  				 |*/
/* 31    26 25  21 20  16 15    	    		0 */

/*Instructions need byte alignment, need to figure out how to implement*/

/**************************************/
/*		 	Opcode breakdown		  */
/**************************************/
/* 			  Bits				  	  */
/* 	 31    30   29   28   27   26  	  */
/* | ALU | SP | MEM |    |    |    |  */
/*			Definitions			  	  */
/*	31:		ALU; 	Use ALUOP bits    */
/*  30:		SP; 	Supervisor Inst	  */
/*	29:		MEM; 	Memory Access	  */
/*	28:*/
/*	27:*/
/*	26:*/



	/*Wire connections*/
	wire[5:0] opcode_w;
	wire[4:0] reg_a_addr_w;
	wire[4:0] reg_b_addr_w;
	wire[4:0] reg_dest_w;
	wire[3:0] aluop_w;
	wire[15:0] immed_w;
	wire[15:0] addr_ldsw_w; //wire for load/store address
	wire[11:0] addr_brj_w; 	//wire for branch/jump address


	/*Assignments*/
	assign opcode_w 	= inst_in[31:26];
    assign aluop_w  	= inst_in[3:0];
	assign reg_a_addr_w = inst_in[20:16];
	assign reg_b_addr_w = inst_in[15:11]; //Not always used
	assign reg_dest_w	= inst_in[25:21];

	always@(posedge clk) begin



	end



	endmodule;
