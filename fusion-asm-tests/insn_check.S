###############################################################################
##                                                                           ##
## This program is a simple test for checking that all instructions work.	 ##
## The checks performed are as follows:										 ##
##		-Register Usage (addi insn only)									 ##
##		-All available opcodes/instructions                                  ##
##		                                                                     ##
## Since system instructions are more complex, they will be left out         ##
## in this program.                                                          ##
##                                                                           ##
##  Author: Dylan Wadler												     ##
##  Email:	dylan@fusion-core.org                                            ##
###############################################################################
.globl __start                                                               

.data

#data portions
var1:	.word	0xdeadbeef
var2:	.word	0x00000000 #will have cafebabe

.text

#starting program | each subsequent label will be the proper test
__start:	
	nop
	nop

###############################################################################
## This test adds an immediate value into the register to be tested.		 ##
## Each register should have the same value, except zero as it should be 0.	 ##
## It is also assumed each register is initialized to 0 at the start.		 ##
###############################################################################

reg_test:	
	addi	$lo0,	$zero,	0x2a	#it's the meaning of life, in hex of course
	addi	$hi0,	$zero,	0x2a
	addi	$tmp7,	$zero,	0x2a
	addi	$tmp6,	$zero,	0x2a
	addi	$tmp5,	$zero,	0x2a
	addi	$tmp4,	$zero,	0x2a
	addi	$tmp3,	$zero,	0x2a
	addi	$tmp2,	$zero,	0x2a
	addi	$tmp1,	$zero,	0x2a
	addi	$tmp0,	$zero,	0x2a
	addi	$gr10,	$zero,	0x2a
	addi	$gr9,	$zero,	0x2a
	addi	$gr8,	$zero,	0x2a
	addi	$gr7,	$zero,	0x2a
	addi	$gr6,	$zero,	0x2a
	addi	$gr5,	$zero,	0x2a
	addi	$gr4,	$zero,	0x2a
	addi	$gr3,	$zero,	0x2a
	addi	$gr2,	$zero,	0x2a
	addi	$gr1,	$zero,	0x2a
	addi	$gr0,	$zero,	0x2a
	addi	$rval1,	$zero,	0x2a
	addi	$rval0,	$zero,	0x2a
	addi	$arg3,	$zero,	0x2a
	addi	$arg2,	$zero,	0x2a
	addi	$arg1,	$zero,	0x2a
	addi	$arg0,	$zero,	0x2a
	addi	$ra,	$zero,	0x2a
	addi	$gp,	$zero,	0x2a
	addi	$fp,	$zero,	0x2a
	addi	$sp,	$zero,	0x2a
	addi	$zero,	$zero,	0x2a

# END OF TEST [reg_test]
	nop
	nop
	nop

###############################################################################
## This test checks each instruction. No contention between registers 		 ##
## should occur. 															 ##
## It is also assumed each register is initialized to 0 at the start.		 ##
## The registers should either be "0000beef" "dead0000" or "deadbeef"		 ##
## depending on the instructions, in the respective register file			 ##
###############################################################################

insn_test:
	nop
	nop
# clearing the registers to make each test work
clear_regs_0:
	xor		$lo0,	$lo0,	$lo0
	xor		$hi0,	$hi0,	$hi0
	xor		$tmp7,	$tmp7,	$tmp7
	xor		$tmp6,	$tmp6,	$tmp6
	xor		$tmp5,	$tmp5,	$tmp5
	xor		$tmp4,	$tmp4,	$tmp4
	xor		$tmp3,	$tmp3,	$tmp3
	xor		$tmp2,	$tmp2,	$tmp2
	xor		$tmp1,	$tmp1,	$tmp1
	xor		$tmp0,	$tmp0,	$tmp0
	xor		$gr10,	$gr10,	$gr10
	xor		$gr9,	$gr9,	$gr9
	xor		$gr8,	$gr8,	$gr8
	xor		$gr7,	$gr7,	$gr7
	xor		$gr6,	$gr6,	$gr6
	xor		$gr5,	$gr5,	$gr5
	xor		$gr4,	$gr4,	$gr4
	xor		$gr3,	$gr3,	$gr3
	xor		$gr2,	$gr2,	$gr2
	xor		$gr1,	$gr1,	$gr1
	xor		$gr0,	$gr0,	$gr0
	xor		$rval1,	$rval1,	$rval1
	xor		$rval0,	$rval0,	$rval0
	xor		$arg3,	$arg3,	$arg3
	xor		$arg2,	$arg2,	$arg2
	xor		$arg1,	$arg1,	$arg1
	xor		$arg0,	$arg0,	$arg0
	xor		$ra,	$ra,	$ra
	xor		$gp,	$gp,	$gp
	xor		$fp,	$fp,	$fp
	xor		$sp,	$sp,	$sp
	xor		$zero,	$zero,	$zero
	nop
	nop
	nop
	nop
	nop
load_imm_test:
	li		$gr0,	0xbeef
	lui		$gr1,	0xdead
	lni		$gr2,	0xbeef
	lni		$gr2,	0xdead
# The global register file is not implemented at this time
#	lgi		$gr3,	0xbeef
#	lugi	$gr4,	0xdead
#	lngi	$gr5,	0xbeef
#	lngi	$gr5,	0xdead
	lsi		$gr6,	0xbeef
	lusi	$gr7,	0xdead
	lnsi	$gr8,	0xbeef
	lnsi	$gr8,	0xdead
# END OF TEST [load_imm_test]

# clearing the registers to make each test work
clear_regs_1:
	xor		$lo0,	$lo0,	$lo0
	xor		$hi0,	$hi0,	$hi0
	xor		$tmp7,	$tmp7,	$tmp7
	xor		$tmp6,	$tmp6,	$tmp6
	xor		$tmp5,	$tmp5,	$tmp5
	xor		$tmp4,	$tmp4,	$tmp4
	xor		$tmp3,	$tmp3,	$tmp3
	xor		$tmp2,	$tmp2,	$tmp2
	xor		$tmp1,	$tmp1,	$tmp1
	xor		$tmp0,	$tmp0,	$tmp0
	xor		$gr10,	$gr10,	$gr10
	xor		$gr9,	$gr9,	$gr9
	xor		$gr8,	$gr8,	$gr8
	xor		$gr7,	$gr7,	$gr7
	xor		$gr6,	$gr6,	$gr6
	xor		$gr5,	$gr5,	$gr5
	xor		$gr4,	$gr4,	$gr4
	xor		$gr3,	$gr3,	$gr3
	xor		$gr2,	$gr2,	$gr2
	xor		$gr1,	$gr1,	$gr1
	xor		$gr0,	$gr0,	$gr0
	xor		$rval1,	$rval1,	$rval1
	xor		$rval0,	$rval0,	$rval0
	xor		$arg3,	$arg3,	$arg3
	xor		$arg2,	$arg2,	$arg2
	xor		$arg1,	$arg1,	$arg1
	xor		$arg0,	$arg0,	$arg0
	xor		$ra,	$ra,	$ra
	xor		$gp,	$gp,	$gp
	xor		$fp,	$fp,	$fp
	xor		$sp,	$sp,	$sp
	xor		$zero,	$zero,	$zero
	nop
	nop
	nop
	nop
	nop
integer_test:
	li		$gr0,	0xaaaa	#get start value
	li		$gr1,	0x5555
	nop
	nop
	nop
	nop
	nop
	add		$gr2,	$gr1,	$gr0
	sub		$gr3,	$gr1,	$gr0
	not		$gr4,	$gr0,	$zero
	and		$gr5,	$gr1,	$gr0
	or		$gr6,	$gr1,	$gr0
	xor		$gr7,	$gr1,	$gr0
	comp	$gr8,	$gr1,	$gr0	

#need to set up other registers with values to make the next instruction tests
#work properly
	li		$tmp0,	4
	nop
	nop
	nop
	nop
	nop
	sal		$tmp1,	$gr0,	$tmp0
	sar		$tmp2,	$gr0,	$tmp0
	sll		$tmp3,	$gr0,	$tmp0
	slr		$tmp4,	$gr0,	$tmp0
	
#removing addu and subu since there is no difference between 
#unsigned and signed addition, subtraction

clear_regs_2:
	xor		$lo0,	$lo0,	$lo0
	xor		$hi0,	$hi0,	$hi0
	xor		$tmp7,	$tmp7,	$tmp7
	xor		$tmp6,	$tmp6,	$tmp6
	xor		$tmp5,	$tmp5,	$tmp5
	xor		$tmp4,	$tmp4,	$tmp4
	xor		$tmp3,	$tmp3,	$tmp3
	xor		$tmp2,	$tmp2,	$tmp2
	xor		$tmp1,	$tmp1,	$tmp1
	xor		$tmp0,	$tmp0,	$tmp0
	xor		$gr10,	$gr10,	$gr10
	xor		$gr9,	$gr9,	$gr9
	xor		$gr8,	$gr8,	$gr8
	xor		$gr7,	$gr7,	$gr7
	xor		$gr6,	$gr6,	$gr6
	xor		$gr5,	$gr5,	$gr5
	xor		$gr4,	$gr4,	$gr4
	xor		$gr3,	$gr3,	$gr3
	xor		$gr2,	$gr2,	$gr2
	xor		$gr1,	$gr1,	$gr1
	xor		$gr0,	$gr0,	$gr0
	xor		$rval1,	$rval1,	$rval1
	xor		$rval0,	$rval0,	$rval0
	xor		$arg3,	$arg3,	$arg3
	xor		$arg2,	$arg2,	$arg2
	xor		$arg1,	$arg1,	$arg1
	xor		$arg0,	$arg0,	$arg0
	xor		$ra,	$ra,	$ra
	xor		$gp,	$gp,	$gp
	xor		$fp,	$fp,	$fp
	xor		$sp,	$sp,	$sp
	xor		$zero,	$zero,	$zero
	nop
	nop
	nop
	nop
	nop

integer_imm_test:
	li		$gr1,	0x0aaa
	nop
	nop
	nop
	nop
	nop
	addi	$gr2,	$gr1,	0x555
	subi	$gr3,	$gr1,	0x555
	noti	$gr4,	0x555
	andi	$gr5,	$gr1,	0x555
	ori		$gr6,	$gr1,	0x555
	xori	$gr7,	$gr1,	0x555
	compi	$gr8,	$gr1,	0x555
	sali	$tmp1,	$gr1,	4
	sari	$tmp2,	$gr1,	4
	slli	$tmp3,	$gr1,	4
	slri	$tmp4,	$gr1,	4
clear_regs_3:
	xor		$lo0,	$lo0,	$lo0
	xor		$hi0,	$hi0,	$hi0
	xor		$tmp7,	$tmp7,	$tmp7
	xor		$tmp6,	$tmp6,	$tmp6
	xor		$tmp5,	$tmp5,	$tmp5
	xor		$tmp4,	$tmp4,	$tmp4
	xor		$tmp3,	$tmp3,	$tmp3
	xor		$tmp2,	$tmp2,	$tmp2
	xor		$tmp1,	$tmp1,	$tmp1
	xor		$tmp0,	$tmp0,	$tmp0
	xor		$gr10,	$gr10,	$gr10
	xor		$gr9,	$gr9,	$gr9
	xor		$gr8,	$gr8,	$gr8
	xor		$gr7,	$gr7,	$gr7
	xor		$gr6,	$gr6,	$gr6
	xor		$gr5,	$gr5,	$gr5
	xor		$gr4,	$gr4,	$gr4
	xor		$gr3,	$gr3,	$gr3
	xor		$gr2,	$gr2,	$gr2
	xor		$gr1,	$gr1,	$gr1
	xor		$gr0,	$gr0,	$gr0
	xor		$rval1,	$rval1,	$rval1
	xor		$rval0,	$rval0,	$rval0
	xor		$arg3,	$arg3,	$arg3
	xor		$arg2,	$arg2,	$arg2
	xor		$arg1,	$arg1,	$arg1
	xor		$arg0,	$arg0,	$arg0
	xor		$ra,	$ra,	$ra
	xor		$gp,	$gp,	$gp
	xor		$fp,	$fp,	$fp
	xor		$sp,	$sp,	$sp
	xor		$zero,	$zero,	$zero
	nop
	nop
	nop
	nop
	nop

load_test:
	luni	$gr0,	var1 #to get upper address of var1
	lw		$gr1,	var1($gr0)
	lh  	$gr2,	var1($gr0)
	lb		$gr3,	var1($gr0)
	lth		$gr4,	var1($gr0)
	nop
	nop
	nop
	nop
	nop
store_test:
	lni		$gr5,	0xbabe
	luni	$gr5,	0xcafe
	nop
	nop
	nop
	nop
	nop
	sw		$gr5,	var2($gr0)		#store cafebabe
	sh		$gr5,	var2($gr0)	#store babe
	sb		$gr5,	var2($gr0)	#store be
	sth		$gr5,	var2($gr0)	#store febabe

clear_regs_4:
	xor		$lo0,	$lo0,	$lo0
	xor		$hi0,	$hi0,	$hi0
	xor		$tmp7,	$tmp7,	$tmp7
	xor		$tmp6,	$tmp6,	$tmp6
	xor		$tmp5,	$tmp5,	$tmp5
	xor		$tmp4,	$tmp4,	$tmp4
	xor		$tmp3,	$tmp3,	$tmp3
	xor		$tmp2,	$tmp2,	$tmp2
	xor		$tmp1,	$tmp1,	$tmp1
	xor		$tmp0,	$tmp0,	$tmp0
	xor		$gr10,	$gr10,	$gr10
	xor		$gr9,	$gr9,	$gr9
	xor		$gr8,	$gr8,	$gr8
	xor		$gr7,	$gr7,	$gr7
	xor		$gr6,	$gr6,	$gr6
	xor		$gr5,	$gr5,	$gr5
	xor		$gr4,	$gr4,	$gr4
	xor		$gr3,	$gr3,	$gr3
	xor		$gr2,	$gr2,	$gr2
	xor		$gr1,	$gr1,	$gr1
	xor		$gr0,	$gr0,	$gr0
	xor		$rval1,	$rval1,	$rval1
	xor		$rval0,	$rval0,	$rval0
	xor		$arg3,	$arg3,	$arg3
	xor		$arg2,	$arg2,	$arg2
	xor		$arg1,	$arg1,	$arg1
	xor		$arg0,	$arg0,	$arg0
	xor		$ra,	$ra,	$ra
	xor		$gp,	$gp,	$gp
	xor		$fp,	$fp,	$fp
	xor		$sp,	$sp,	$sp
	xor		$zero,	$zero,	$zero
	nop
	nop
	nop
	nop
	nop
#forward jump
jump_branch_test:
	j		far_address	
	nop
	nop
#testing branching forwards
beq_point:
	beq		$zero,	$gr2,	beq_test_point
	nop
	nop
bne_point:
	bne		$zero,	$gr0,	bne_test_point
	nop
	nop
bgt_point:
	bgt		$gr0,	$zero,	bne_test_point
	nop
	nop
blt_point:	#mmmm blts. could go for one right about now
	blt		$zero,	$gr0,	blt_test_point	
	nop		
	nop
	nop
	nop
	nop
#testing branching backwards
beq_test_point:
	beq		$zero,	$gr2,	bne_point
	nop
	nop
bne_test_point:
	bne		$zero,	$gr0,	bgt_point
	nop
	nop
bgt_test_point:	
	bgt		$gr0,	$zero,	blt_point
	nop
	nop
blt_test_point:	
	blt		$zero,	$gr0,	blt_point
	nop
	nop
	nop
	nop
	nop
jlnk_test:
	luni		$gr0,	far_address_jal
	nop
	nop
	nop
	lni		$gr0,	far_address_jal
	nop
	nop
	nop
	jal		far_address_jal
jrl_test:
	luni		$gr0,	far_address_jrl
	nop
	nop
	nop
	lni		$gr0,	far_address_jrl
	xor		$ra,	$ra,	$ra		#clear return address
	jrl		far_address_jrl($zero)

#.org	0x40000 	#need far address for jumps to work ok
far_address:		#without being too far to make the file ginormous
	luni	$gr0,	jump_branch_test
	nop
	nop
	nop
	nop
	nop
	#backwards jump, register though
	jr	beq_point($gr0)	#and go back to where yee came from!
far_address_jal:
	nop
	nop
	nop
	beq		$ra,	$gr0,	jrl_test	#complete jump and link, go to jrl test
	ret
	nop
far_address_jrl:
	nop
	nop
	nop
	nop
	beq		$ra,	$gr0,	test_complete	#tests completed!
	nop
	nop
	nop
test_complete:
	luni		$gr5,	test_complete
	nop
	nop
	jr		test_complete($gr5)
	nop
