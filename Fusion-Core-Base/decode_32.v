/*** Defines  ***/
/*System because it's special*/
`define	OPC_SYS		 5'b110000;

module decode_32(
	input[31:0] 	insn_in,			//input instruction
	input			reset_in,			//input reset line
	input			clk_in,				//input clock
	input[31:0]		insn_pc_in,			//input program counter address
	input			stall_in,			//input stall signal


	/*Operand output connections*/
	output reg	[4:0] 	reg_select_out,		//output register bank select
	output reg 	[4:0]	rsa_out,			//output of register a address
	output reg	[4:0] 	rsb_out,			//output of register b address
	output reg	[4:0] 	rd_out, 			//output of destination register address
	output reg	[20:0] 	imm_out,			//output of immediate value
											//using largest immediate value
											//size

	/*Control Signals*/
	output 	reg [3:0] aluop_out,
	output	reg jlnk_out,
	output	reg pc_change_rel_out,
	output	reg pc_change_abs_out,
	output	reg mem_read_out,
	output	reg mem_write_out,

	/*Flag outputs*/
	output	reg nri_flg_out,		//output of 'not real instruction' flag
	output	reg [1:0] branch_funct_out,	//branch function; taken from the funct field
	output	reg stall_out,

	/*System instruction signals*/
	output		reg 		memsync_out,
	output		reg 		syscall_out,
	output		reg 		pem_inc_req_out,
	output		reg 		pem_dec_req_out,
	output		reg [7:0]	sysreg_addr_out,	//for reading and writing to system registers
	output		reg [7:0]	sysreg_data_out,
	input 			[7:0]	sysreg_data_in,


	/* Misc. Outputs*/
	output	reg [31:0] insn_pc_out,
	/*Co-processor connections*/
	output	reg [30:0] cp_insn_out

	);

	/* Pipeline information */
	localparam PIPELINE_LENGTH 	= 5; 
	localparam PIPELINEL_2		= $clog2(PIPELINE_LENGTH);
	/*Defining opcodes to make things easier*/
	localparam OPC_INT 	 	= 5'b010011;
	localparam OPC_IMM 		= 5'b010110;
	localparam OPC_LI		= 5'b010000;
	localparam OPC_BRANCH	= 5'b001101;
	localparam OPC_JMP		= 5'b001100;
	localparam OPC_JLNK		= 5'b000100;
	localparam OPC_LD		= 5'b011110;
	localparam OPC_ST		= 5'b011101;

	/*Wire connections*/
	wire[5:0] 	opcode_w;
	wire[4:0] 	rsa_addr_w;
	wire[4:0] 	rsb_addr_w;
	wire[4:0] 	rd_addr_w;
	wire[3:0] 	aluop_w;

	/*Funct Variants*/
	wire[1:0]	funct_ld_w;
	wire[1:0]	funct_st_w;
	wire[3:0]	dsel_li_w;
	wire[1:0]	funct_b_w;
	wire[7:0]	funct_sys_w;

	/*Immediate Variants*/
	wire[11:0]	imm_i_w;
	wire[13:0]	imm_ld_w;
	wire[15:0]	imm_li_w;
	wire[13:0]	imm_st_w;
	wire[20:0]	imm_j_w;
	wire[13:0]	imm_b_w;
	wire[7:0]	imm_sys_w;

	/*OPCode generated signals*/

	/*Resouce usage*/
	wire		use_alu_w;
	wire		is_cp_insn_w;			//is coprocessor instruction
	wire		pc_change_w;			//instruction can change the pc
	wire		mem_access_w;
	wire		pc_link_w;				//jump that requires linking to ra
	wire		sys_insn_w;

	/*secondary calculated resource usage*/
	wire		mem_read_req_w;
	wire		mem_write_req_w;
	wire		pc_abs_w;
	wire		pc_rel_w;
	wire		memsync_w;
	
	/*ALU op signal selection*/
	wire		aluop_intsig_w; // integer/register operation field used
	wire		aluop_addsig_w; // fixed add operation
	wire		aluop_bsig_w;   // branch operation decode value

	/*Operand usage*/
	wire		use_rd_w;
	wire		use_rsa_w;
	wire		use_rsb_w;
	wire		use_imm_w;
	wire [4:0]	imm_sel_w;


	/*Assignments*/
	assign 	opcode_w 		= insn_in[31:26];
	assign 	rsa_addr_w 		= insn_in[20:16];
	assign 	rsb_addr_w 		= insn_in[15:11]; 
	assign 	rd_addr_w		= insn_in[25:21];
	assign 	aluop_w  		= insn_in[3:0];

 	assign	funct_ld_w 		= insn_in[15:14];
	assign	funct_st_w		= insn_in[25:24];
	assign	dsel_li_w		= insn_in[20:16];
	assign	funct_b_w		= insn_in[1:0];
	assign	funct_sys_w		= insn_in[15:8];

	assign	imm_i_w 		= insn_in[15:4];
	assign	imm_ld_w		= insn_in[13:0];
	assign	imm_li_w		= insn_in[15:0];
	assign	imm_st_w		= {insn_in[13:11],insn_in[10:0]};
	assign	imm_j_w			= {insn_in[25:21],insn_in[15:0]};
	assign	imm_b_w			= {insn_in[25:21],insn_in[10:2]};
	assign	imm_sys_w		= insn_in[7:0];   
	assign  imm_sel_w		= (use_imm_w) ?opcode_w[4:0] : 5'b0; //if using immediate, need to determine output

	assign 	is_cp_insn_w	= opcode_w[5];
	assign	pc_change_w		= ~opcode_w[4];				
	assign	mem_access_w	= opcode_w[4] & opcode_w[3];
	assign	pc_link_w		= ~(opcode_w[4] | opcode_w[3]);				
	assign	sys_insn_w		= is_cp_insn_w & opcode_w[4];
	assign 	memsync_w = (sys_insn_w && ( (funct_sys_w & 8'h04) || (funct_sys_w & 8'b0 ) )); //if sync or syscall, need to sync memory 

	assign	use_rd_w		= (opcode_w[1] | opcode_w[0]) & (~opcode_w[2] | opcode_w[1]);
	assign	use_rsa_w		= (opcode_w[2] | opcode_w[1]);
	assign	use_rsb_w		= (opcode_w[2] & opcode_w[0]) | ( opcode_w[1] & opcode_w[0] );
	assign	use_imm_w 		= (opcode_w[2] | ~opcode_w[1]);

    assign 	aluop_intsig_w	= (opcode_w[4] & opcode_w[1]) & ~(opcode_w[5] & opcode_w[3]) & (opcode_w[2] ^ opcode_w[0]); //used for imm and int
    assign	aluop_addsig_w	= pc_rel_w;//used for jump (relative)
    assign	aluop_bsig_w	= (pc_change_w) & (use_rsb_w); //is a branch 

	/*Memory read/write signal creation*/

	/*use_rsb has simpler gate usage, which is better than using use_rd for
	* determining read or writes */
	assign 	mem_write_req_w = (mem_access_w & use_rsb_w); //store instructions use rsb, not rd
	assign 	mem_read_req_w	= (mem_access_w & ~use_rsb_w); //load instructions use rd, not rsb

	assign  pc_rel_w		= (pc_change_w & 	( (opcode_w[2:0] && 3'b101)  || (rsa_addr_w == (5'b0)) ) ); //not jr/jrl or branch
	assign	pc_abs_w		= (pc_change_w & ~( (opcode_w[2:0] && 3'b101)  || (rsa_addr_w == (5'b0)) ) );

/* Internal registers*/
	reg	[PIPELINEL_2 - 1 : 0]	memstall_count; //counter for stalls in pipeline


/*** LOGIC SECTION ****/

always@(~reset_in or stall_in) begin //while in reset or stalling

	reg_select_out 		<= 5'b0;			//output register bank select
	rsa_out 			<= 5'b0;			//output of register a address
	rsb_out 			<= 5'b0;			//output of register b address
	rd_out				<= 5'b0; 			//output of destination register address
	imm_out				<= 21'b0;			//output of immediate value
	  									//using largest immediate value
	  									//size

	aluop_out			<= 4'b0;
	jlnk_out			<= 1'b0;
	pc_change_rel_out	<= 1'b0;
	pc_change_abs_out	<= 1'b0;
	mem_read_out		<= 1'b0;
	mem_write_out		<= 1'b0;

	nri_flg_out			<= 1'b0;		//output of 'not real instruction' flag
	branch_funct_out	<= 2'b0;	//branch function; taken from the funct field

	memsync_out			<= 1'b0;
	syscall_out			<= 1'b0;
	pem_inc_req_out		<= 1'b0;
	pem_dec_req_out		<= 1'b0;
	sysreg_addr_out		<= 8'b0;
	sysreg_data_out		<= 8'b0;

	insn_pc_out			<= 32'h0; 
	cp_insn_out			<= 32'h0;
	stall_out			<= 1'b0;

end


always@(posedge clk_in, reset_in, ~stall_in) begin //make sure that reset has to be high for this to work
	/*** Determining ALUOP value ***/
	if (aluop_intsig_w) begin //uses ALUOP field
		aluop_out = aluop_w;
	end else if (aluop_addsig_w) begin //just add, so jumps
		aluop_out = 4'b0000;
	end else if (aluop_bsig_w) begin //branches, so need to decode the funct field
		aluop_out = 4'b1100; //like compare insn, but does different things
	end else begin
		aluop_out = 4'b1111; //unused code, use as nop? need to define in documentation
	end

	/*Branch funct assignment*/
	branch_funct_out = (aluop_bsig_w) ? (funct_b_w) : (2'b0);

	/*Co-processor instruction output to co-processor decode*/
 	cp_insn_out 	<= (is_cp_insn_w) ? insn_in : 30'b0; 	//if is a co-processor instruction, output instruction to
                   		                                        //co-processor decoder
	/*Memory access signal output*/
	mem_write_out 	<= mem_write_req_w;
	mem_read_out 	<= mem_read_req_w;
	
 	pc_change_rel_out <= pc_rel_w;
	pc_change_abs_out <= pc_abs_w;

	/*Register selection and outputs*/
	if(imm_sel_w == OPC_LI) begin //determine which register bank to use, from DSEL
		reg_select_out	<= { 1'b0, dsel_li_w}; //lower 2 bits determine file, upper two bits determine signed, upper or lower 16 bits
	end else if(sys_insn_w && ( funct_sys_w & (8'h02 ))) begin //if system instruction, need to check if accessing system registers, last two bits matter here
		reg_select_out	<= 5'b10000; //upper most bit is for accessing special purpose registers; maps to memory address to make 8 bit registers easier
	end else begin //everything else should just use general purpose register file
		reg_select_out	<= 5'b0;
	end

	rsa_out <= (use_rsa_w) ? rsa_addr_w : 5'b0;
	rsb_out <= (use_rsb_w) ? rsb_addr_w : 5'b0;
	rd_out  <= (use_rd_w ) ? rd_addr_w  : 5'b0;

	insn_pc_out <= insn_pc_in; //may need to alter this value, but unsure so leave it

	/*** Selecting immediate values ***/
	if(!is_cp_insn_w) begin
		case (imm_sel_w) //figure out what immediate value to use
			OPC_IMM:		imm_out <= {9'b0 ,imm_i_w};
			OPC_LD:			imm_out <= {7'b0, imm_ld_w};
			OPC_ST:			imm_out <= {7'b0, imm_st_w};
			OPC_LI:			imm_out <= {6'b0, imm_li_w};
			OPC_JMP:		imm_out <= imm_j_w;
			OPC_JLNK:		imm_out <= imm_j_w;
			OPC_BRANCH:		imm_out <= {7'b0, imm_b_w};
			default:		imm_out <= 21'b0;	//this may be redundant or cause errors, not sure yet
		endcase
		/*co processor instruction immediates; right now just system insn due to direct
		* affects on main core pipeline */
	end else if(opcode_w[5] & opcode_w[4] & ~(opcode_w[3] | opcode_w[2] | opcode_w[1] | opcode_w[0] ) )begin 
		/*just system instructions*/	
		imm_out <= imm_sys_w;
	end else begin
		imm_out <= 21'b0; //no immediate, default to 0's
	end


	/*System decoding*/
	if( sys_insn_w) begin //if actually a system instruction
		case (funct_sys_w)
			8'h00: begin				//system call
				syscall_out 	<= 1'b1;
				memsync_out		<= 1'b0; 
				pem_inc_req_out	<= 1'b0;
				pem_dec_req_out	<= 1'b0;
			end
		//	8'h01: begin				//system return
		//	end
			8'h04: begin				//memory sync
				syscall_out 	<= 1'b0;
				memsync_out		<= 1'b1;
				pem_inc_req_out	<= 1'b0;
				pem_dec_req_out	<= 1'b0;
				stall_out		<= 1'b1;

			end
			default: begin
				syscall_out 	<= 1'b0;
				memsync_out		<= 1'b0;
				pem_inc_req_out	<= 1'b0;
				pem_dec_req_out	<= 1'b0;
			end
		endcase
	end

	/* Ensure stall_out from memory sync doesn't make the pipeline get stuck */
	if(memsync_w) begin
		if(memstall_count > PIPELINE_LENGTH) begin
			memstall_count 	<= 0;
			memsync_out		<= 1'b0;
		end
		else begin
			memstall_count = memstall_count + 1;
		end
	end


end

endmodule
