# Description of the included files
* **NYU6463Processor.vhd** *Is the top module for the entire project which implements the MIPS processor for Artix-7 FPGA.*
* **MIPSProcessor.vhd** *Is the MIPS processor's VHDL code which has the following components (below).*
  * **programcounter.vhd**
  * **instructionmemory.vhd**
  * **registerfile.vhd**
  * **signextend.vhd**
  * **alu.vhd**
  * **datamemory.vhd**
  * **controlunit.vhd**
![Image of components](https://raw.githubusercontent.com/cm4233/MIPS-Processor-VHDL/master/processorComponents.png)
* **Nexys4DDR_Master.ucf** *Is the ucf file for the Nexys4DDR development board that houses the Artix-7 FPGA.*
* **Hex2SevenSegConverter.vhd**	*Is the VHDL code for converting hexadecimal values to 7 segment display code.*
* **assembly_code.txt** *Is the assembly level and machine code instructions for running RC5 encryption and decryption.*
