# Fusion-Core

##Introduction
As ISAs age, to retain code compatibility with older implementations, they
often keep poor design choices and other baggage. Also, the introduction of
new extensions to the ISA results in older implementations to be unable to run
newer programs. The Fusion-Core ISA is an attempt to resolve some of these
issues in allowing for the implementation to select what co-processors to use
without code compatibility issues. The core of the processor retains only
simple integer instructions, flow control instructions, and system control
instructions. This is to reduce the complexity of an implementation and in turn
to achieve faster clock speeds of the core. Each co-processor can be clocked
independently, with the Atomic Memory Controller aggregating the memory
accesses and thusly allowing for a shared memory model between co-processors.


##Benefits
This architecture attempts to allow implementations to use different
co-processors, without having to worry about code compatibility. Through use of
opcode allocation within the decode unit, different instruction queues and
clock domains become availble to the various co-processors without having to
alter the ISA. Only defining psuedo instructions would be required, and a
simple check by an operating system, or bare metal program at the start.
Exceptions for common software implementations of co-processors, such as
floating point instructions can be used for common case compatibility.


## To-do list:
<b>Item&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Status</b>
***
Instruction Set Architecture
	-Documentation					In Progress

Main Core			
	-Decoder						In Progress
	-ALU							In Progress
	-Register Files					In Progress
	-Co-Processor Interface			N/A
	-Atomic Memory Controller		N/A
	-Clock Controller				N/A
	-Hazard Handling Unit			N/A
	-Caching System					N/A
	-Memory Interface				N/A
	-Networking Interface			N/A

Coprocessor Cores/Misc.
	
	-Graphics Co-Processor			N/A
	-Floating Point					N/A
	-Network Manager				N/A
	-GPIO Controller				N/A

**
## Notes

