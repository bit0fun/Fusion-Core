###############################################################################
##                                                                           ##
## This program is a simple test for checking that all instructions work.	 ##
## The checks performed are as follows:										 ##
##		-Registers															 ##
##		-Different immeidates											 	 ##
##		-All available opcodes                                               ##
##		-Branching forwards and backwards                                    ##
##		-jump register instructions                                          ##
##		-relative jumps														 ##
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
var2:	.word	0xcafebabe

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

# TEST IS FINISHED	
	nop
	nop
	nop
	nop
