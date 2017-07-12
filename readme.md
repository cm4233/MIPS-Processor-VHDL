# MIPS Processor
## NYU EL-6463

Description of all the included files

* **Nexys4DDR_Master.ucf** *Is the ucf file for the Nexys4DDR development board that houses the Artix-7 FPGA.*
* **Hex2SevenSegConverter.vhd**	*Is the VHDL code for converting hexadecimal values to 7 segment display code.*
* **assembly_code.txt** *Is the assembly level and machine code instructions for running RC5 encryption and decryption.*
* **NYU6463Processor.vhd** *Is the top module for the entire project. It implements the MIPS processor for xc7a100t-1csg324 FPGA.*
* **MIPSProcessor.vhd** *Is the MIPS processor's VHDL code which has the following components (below).*
  * programcounter.vhd
  * instructionmemory.vhd
  * registerfile.vhd
  * signextend.vhd
  * alu.vhd
  * datamemory.vhd
  * controlunit.vhd
![Image of components](https://raw.githubusercontent.com/cm4233/MIPS-Processor-VHDL/master/processor%20components.png)

