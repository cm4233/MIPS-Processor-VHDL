NYU EL-6463
MIPS Processor

Description of all the included files

Nexys4DDR_Master.ucf 		    # Is the ucf file for the Nexys4DDR development board that houses the Artix-7 FPGA
Hex2SevenSegConverter.vhd	  # Is the VHDL code for converting hexadecimal values to 7 segment display code
assembly_code.txt 		      # Is the assembly level and machine code instructions for running RC5 encryption and decryption
NYU6463Processor.vhd 		    # Is the top module for the entire project. It implements the MIPS processor for xc7a100t-1csg324 FPGA
MIPSProcessor.vhd 		      # Is the MIPS processor's VHDL code which has the following components (below)
1. programcounter.vhd
2. instructionmemory.vhd
3. registerfile.vhd
4. signextend.vhd
5. alu.vhd
6. datamemory.vhd
7. controlunit.vhd

