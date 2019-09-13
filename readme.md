# MIPS Processor using VHDL
This project describes an emulation of a 32-bit MIPS processor on Artix-7 FPGA using a hardware description language (VHDL). The implemented MIPS processor is tested by running RC5 encryption and decryption algorithms. The project highlights the advantage of FPGA based hardware acceleration to significantly reduce execution time. It takes about 7000 clock cycles to perform RC5 Encryption when executed on the general purpose MIPS processor as opposed to just 90 clock cycles when the algorithm is directly implemented on the FPGA.  
## Description of the included files (Code in "VHDL Codes" folder)
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
## Testing the MIPS Processor
The implemented MIPS Processor was tested by running RC5 encryption and decryption algorithms. The assembly/machine-code instructions for the encryption and decryption algorithms can be found in assembly_code.txt file.
* Simulation Output on Xilinx ISE/ModelSim
![Image of simout](https://github.com/cm4233/MIPS-Processor-VHDL/blob/master/Outputs/simulation%20output-rc5%20encrypt.png?raw=true)
* FPGA Output on Nexys4DDR development board with Artix-7 FPGA

![Image of fpgaout](https://github.com/cm4233/MIPS-Processor-VHDL/blob/master/Outputs/onboard%20output-rc5%20encrypt.png?raw=true)
