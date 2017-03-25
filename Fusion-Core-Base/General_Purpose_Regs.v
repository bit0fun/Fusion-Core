module General_Purpose_Regs(
	/*Data*/
	input[31:0] d_in, //input data
	output[31:0] out_a, //register outputs
	output[31:0] out_b,

	/*Address*/
	input[4:0] addr_a,
	input[4:0] addr_b,
	
	/*Control Lines*/
	input[1:0] file_sel, //register file select lines
	input rw, //rw == 1, then read; rw == 0, write
	input clk //clock for synchronous registers
	);

	/*Registers*/
	reg [3:0] gp_sel; //selection line for register files

	/*Wires*/
	wire [31:0] w_out_a;
	wire [31:0] w_out_b;
	

	/*Instantiations of GP register files*/
RegisterFile GPRF0(
	.in_reg(d_in), //only one input needed
	.out_a(w_out_a),
	.out_b(w_out_b),
	.addr_a(addr_a), //used for input addresses
	.addr_b(addr_b),
	.rw(rw), //rw == 1, then read; rw == 0, write
	.clk(clk), //clock for synchronous registers
	.sel(gp_sel[0])
	);

RegisterFile GPRF1(
	.in_reg(d_in), //only one input needed
	.out_a(w_out_a),
	.out_b(w_out_b),
	.addr_a(addr_a), //used for input addresses
	.addr_b(addr_b),
	.rw(rw), //rw == 1, then read; rw == 0, write
	.clk(clk), //clock for synchronous registers
	.sel(gp_sel[1])
	);

RegisterFile GPRF2(
	.in_reg(d_in), //only one input needed
	.out_a(w_out_a),
	.out_b(w_out_b),
	.addr_a(addr_a), //used for input addresses
	.addr_b(addr_b),
	.rw(rw), //rw == 1, then read; rw == 0, write
	.clk(clk), //clock for synchronous registers
	.sel(gp_sel[2])
	);

RegisterFile GPRF3(
	.in_reg(d_in), //only one input needed
	.out_a(w_out_a),
	.out_b(w_out_b),
	.addr_a(addr_a), //used for input addresses
	.addr_b(addr_b),
	.rw(rw), //rw == 1, then read; rw == 0, write
	.clk(clk), //clock for synchronous registers
	.sel(gp_sel[3])
	);


initial
	begin
		 gp_sel <= 4'b1111; //no register file is selected at initialization
	end

//select is active low
always@(*)
begin
	case(file_sel)
		2'b00: gp_sel <= 4'b1110;
		2'b01: gp_sel <= 4'b1101;
		2'b10: gp_sel <= 4'b1011;
		2'b11: gp_sel <= 4'b0111;
	endcase
end




assign out_a = w_out_a;
assign out_b = w_out_b;


endmodule
