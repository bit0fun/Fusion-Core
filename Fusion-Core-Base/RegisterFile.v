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


module RegisterFile(

	/*Data*/
	input[31:0] in_reg, //only one input needed

	output reg[31:0] out_a,
	output reg[31:0] out_b,

	/*Addresses*/
	input[4:0]  addr_a, //used for input addresses
	input[4:0]  addr_b,
	
	/*Control Lines*/
	input rw, //rw == 1, then read; rw == 0, write
	input clk, //clock for synchronous registers
	input sel //chip select line, active low
	);


	/*Registers*/
	//reg[31:0] reg_out_a; //for keeping verilog happy
	//reg[31:0] reg_out_b;

	reg [31:0] r0;
	reg [31:0] r1;
	reg [31:0] r2;
	reg [31:0] r3;
	reg [31:0] r4;
	reg [31:0] r5;
	reg [31:0] r6;
	reg [31:0] r7;
	reg [31:0] r8;
	reg [31:0] r9;
	reg [31:0] r10;
	reg [31:0] r11;
	reg [31:0] r12;
	reg [31:0] r13;
	reg [31:0] r14;
	reg [31:0] r15;
	reg [31:0] r16;
	reg [31:0] r17;
	reg [31:0] r18;
	reg [31:0] r19;
	reg [31:0] r20;
	reg [31:0] r21;
	reg [31:0] r22;
	reg [31:0] r23;
	reg [31:0] r24;
	reg [31:0] r25;
	reg [31:0] r26;
	reg [31:0] r27;
	reg [31:0] r28;
	reg [31:0] r29;
	reg [31:0] r30;
	reg [31:0] r31;

initial //initialize all registers to 0
begin
	r0 <= 32'b0;
	r1 <= 32'b0;
	r2 <= 32'b0;
	r3 <= 32'b0;
	r4 <= 32'b0;
	r5 <= 32'b0;
	r6 <= 32'b0;
	r7 <= 32'b0;
	r8 <= 32'b0;
	r9 <= 32'b0;
	r10 <= 32'b0;
	r11 <= 32'b0;
	r12 <= 32'b0;
	r13 <= 32'b0;
	r14 <= 32'b0;
	r15 <= 32'b0;
	r16 <= 32'b0;
	r17 <= 32'b0;
	r18 <= 32'b0;
	r19 <= 32'b0;
	r20 <= 32'b0;
	r21 <= 32'b0;
	r22 <= 32'b0;
	r23 <= 32'b0;	
	r24 <= 32'b0;
	r25 <= 32'b0;
	r26 <= 32'b0;
	r27 <= 32'b0;	
	r28 <= 32'b0;
	r29 <= 32'b0;
	r30 <= 32'b0;
	r31 <= 32'b0;

end


always @(posedge clk)
if(rw == 0 && sel == 0)
begin
	out_a <= 0;
	out_b <= 0;
	
	case(addr_a)
		5'b00000: r0 = in_reg;
		5'b00001: r1 <= in_reg;
		5'b00010: r2 <= in_reg;
		5'b00011: r3 <= in_reg;
		5'b00100: r4 <= in_reg;
		5'b00101: r5 <= in_reg;
		5'b00110: r6 <= in_reg;
		5'b00111: r7 <= in_reg;
		5'b01000: r8 <= in_reg;
		5'b01001: r9 <= in_reg;
		5'b01010: r10 <= in_reg;
		5'b01011: r11 <= in_reg;
		5'b01100: r12 <= in_reg;
		5'b01101: r13 <= in_reg;
		5'b01110: r14 <= in_reg;
		5'b01111: r15 <= in_reg;
		5'b10000: r16 <= in_reg;
		5'b10001: r17 <= in_reg;
		5'b10010: r18 <= in_reg;
		5'b10011: r19 <= in_reg;
		5'b10100: r20 <= in_reg;
		5'b10101: r21 <= in_reg;
		5'b10110: r22 <= in_reg;
		5'b10111: r23 <= in_reg;
		5'b11000: r24 <= in_reg;
		5'b11001: r25 <= in_reg;
		5'b11010: r26 <= in_reg;
		5'b11011: r27 <= in_reg; 
		5'b11100: r28 <= in_reg;
		5'b11101: r29 <= in_reg;
		5'b11110: r30 <= in_reg;
		5'b11111: r31 <= in_reg;
	endcase
	end
else if(rw == 1 && sel == 0)
	begin
	case(addr_a)
		5'b00000: out_a <= r0;
		5'b00001: out_a <= r1;
		5'b00010: out_a <= r2;
		5'b00011: out_a <= r3;
		5'b00100: out_a <= r4;
		5'b00101: out_a <= r5;
		5'b00110: out_a <= r6;
		5'b00111: out_a <= r7;
		5'b01000: out_a <= r8;
		5'b01001: out_a <= r9;
		5'b01010: out_a <= r10;
		5'b01011: out_a <= r11;
		5'b01100: out_a <= r12;
		5'b01101: out_a <= r13;
		5'b01110: out_a <= r14;
		5'b01111: out_a <= r15;
		5'b10000: out_a <= r16;
		5'b10001: out_a <= r17;
		5'b10010: out_a <= r18;
		5'b10011: out_a <= r19;
		5'b10100: out_a <= r20;
		5'b10101: out_a <= r21;
		5'b10110: out_a <= r22;
		5'b10111: out_a <= r23;
		5'b11000: out_a <= r24;
		5'b11001: out_a <= r25;
		5'b11010: out_a <= r26;
		5'b11011: out_a <= r27; 
		5'b11100: out_a <= r28;
		5'b11101: out_a <= r29;
		5'b11110: out_a <= r30;
		5'b11111: out_a <= r31;
	endcase

	case(addr_b)
		5'b00000: out_b <= r0;
		5'b00001: out_b <= r1;
		5'b00010: out_b <= r2;
		5'b00011: out_b <= r3;
		5'b00100: out_b <= r4;
		5'b00101: out_b <= r5;
		5'b00110: out_b <= r6;
		5'b00111: out_b <= r7;
		5'b01000: out_b <= r8;
		5'b01001: out_b <= r9;
		5'b01010: out_b <= r10;
		5'b01011: out_b <= r11;
		5'b01100: out_b <= r12;
		5'b01101: out_b <= r13;
		5'b01110: out_b <= r14;
		5'b01111: out_b <= r15;
		5'b10000: out_b <= r16;
		5'b10001: out_b <= r17;
		5'b10010: out_b <= r18;
		5'b10011: out_b <= r19;
		5'b10100: out_b <= r20;
		5'b10101: out_b <= r21;
		5'b10110: out_b <= r22;
		5'b10111: out_b <= r23;
		5'b11000: out_b <= r24;
		5'b11001: out_b <= r25;
		5'b11010: out_b <= r26;
		5'b11011: out_b <= r27; 
		5'b11100: out_b <= r28;
		5'b11101: out_b <= r29;
		5'b11110: out_b <= r30;
		5'b11111: out_b <= r31;
	endcase
	
end
else
	begin
		out_a <= 32'bz;
		out_b <= 32'bz;
end


endmodule
