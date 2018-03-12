/* Decode Unit Testbench*/
`timescale 1ns / 100ps
`include "../decode_32.v"

module decode_test();

localparam	MEM_SIZE =	91;


/* Clocks */
reg clk;
always
	#10 clk = ~ clk; //100MHz

/* Input signals to drive */
reg			reset;
reg			stall;
reg	[31:0]	insn;	
reg	[31:0]	insn_address;
//integer		insn_address;
reg	[7:0]	sysreg_data_input;

/* Output signals to observe*/
wire 	[4:0]	reg_select;
wire	[4:0]	rsa;
wire	[4:0]	rsb;
wire	[4:0]	rd;
wire	[20:0]	imm;
wire	[3:0]	aluop;
wire			jlnk;
wire			pc_change_relative;
wire			pc_change_absolute;
wire			mem_read;
wire			mem_write;
wire			nri_flag;
wire	[1:0]	branch_funct;
wire			stall_output;
wire			memsync;
wire			syscall;
wire			permission_inc;
wire			permission_dec;
wire	[7:0]	sysreg_addr;
wire	[7:0]	sysreg_data;
wire	[31:0]	insn_pc_output;
wire	[30:0]	cp_insn;

/* Memory Test Registers */
reg	[31:0]	insn_mem	[0:MEM_SIZE-1]; //1024 addresses, 2^10

decode_32 decode_ut(		//Decode unit under test
	.insn_in(insn),				//Instruction Input
	.reset_in(reset),			//Reset line input (active low)
	.clk_in(clk),				//Clock input
	.insn_pc_in(insn_address),			//Current instruction PC Address
	.stall_in(stall),			//CCCP Leader... nah just a stall signal
	.reg_select_out(reg_select),		//What register bank the instruction wants to access
	.rsa_out(rsa),				//RSa address
	.rsb_out(rsb),				//RSb address
	.rd_out(rd),				//Rd address
	.imm_out(imm),				//Immediate value (if used)
	.aluop_out(aluop),			//What operation to tell the ALU to do
	.jlnk_out(jlnk),			//Saving the PC to $R4/RA?
	.pc_change_rel_out(pc_change_relative),	//PC Relative address change
	.pc_change_abs_out(pc_change_absolute),	//PC Absolute address change
	.mem_read_out(mem_read),		//Memory read access
	.mem_write_out(mem_write),		//Memory write access
	.nri_flg_out(nri_flag),			//Not a real instruction, flag
	.branch_funct_out(branch_funct),	//Branch code, determines if branch should be taken or not along with output
	.stall_out(stall_output),			//Send stall signal out
	.memsync_out(memsync),			//Sync memory signal
	.syscall_out(syscall),			//Instruction is system call
	.pem_inc_req_out(permission_inc),		//Permission increase request
	.pem_dec_req_out(permission_dec),		//Permission decrease request
	.sysreg_addr_out(sysreg_addr),		//System/Special purpose register address to access
	.sysreg_data_out(sysreg_data),		//Data to write to System/Special purpose register
	.sysreg_data_in(sysreg_data_input),		//Data read from System/Special purpose register
	.insn_pc_out(insn_pc_output),			//Output PC value (for debugging)

	/*Co-Processor Connections*/
	.cp_insn_out(cp_insn)			//Output instruction to Co-Processor to decode

	);

integer i;

integer count;
/* Initial Conditions  */
initial begin
	$dumpfile("decode.vcd");
	$dumpvars(0,decode_test);
	$readmemh("test_insn.txt", insn_mem); //Fill memory
	for( i = 0; i < MEM_SIZE; i = i + 1) begin
		$display("Data read from insn_mem: %h | address: %h", insn_mem[i], i);
		#10;

	end
	#100 //wait a bit before doing anything
	clk						<= 1'b0;

	reset 					<= 1'b0;	//put into reset to start
	#10	//let the reset propagate
	stall 					<= 1'b0;		
//	insn					<= 32'b0;
	insn_address 			<= 0;
	sysreg_data_input 		<= 8'b0;
	#10
	reset					<= 1'b1;	//and they're off!
	count					<= 0;
/* Testing */
//always @(posedge clk) begin
	#5
	for( insn_address = 0; insn_address <= MEM_SIZE; insn_address = insn_address + 1) begin
		#20;
		insn	<= insn_mem[insn_address];			//get instruction from memory address
		$display("Current Address: %h | Instruction: %h", insn_address, insn);

	end

//end
	$finish;
end
endmodule

