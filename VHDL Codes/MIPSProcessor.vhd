--This is not the top module, it is the integration of the processor's components into onle vhd file
--VHDL Code for the entire MIPS Processor as a whole which integrates all the individual components--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MIPSProcessor is
---------//ports//---------
PORT (
clk: in STD_LOGIC;
clr: in STD_LOGIC;
din: in STD_LOGIC_VECTOR(63 DOWNTO 0);--Accepts din from the fpga board for rc5 encypt/decrypt 
ukey: in STD_LOGIC_VECTOR(127 DOWNTO 0);--Accepts ukey from fpga board for rc5
EorD: in STD_LOGIC;--Encrypt or Decrypt signal
Reg1: out STD_LOGIC_VECTOR(31 DOWNTO 0);--To show register content on 7seg display
Reg2: out STD_LOGIC_VECTOR(31 DOWNTO 0)

);
---------------------------
end MIPSProcessor;

architecture Behavioral of MIPSProcessor is
----------//components//-----------------------------------------------------------------
component alu
PORT (
SrcA: in STD_LOGIC_VECTOR(31 DOWNTO 0);
SrcB: in STD_LOGIC_VECTOR(31 DOWNTO 0);
ALUControl: in STD_LOGIC_VECTOR(2 DOWNTO 0);
Zero: out STD_LOGIC;
GreatThan: out STD_LOGIC;
LessThan: out STD_LOGIC;
ALUResult: out STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

component controlunit 
PORT (
Op: in STD_LOGIC_VECTOR(5 DOWNTO 0);
Funct: in STD_LOGIC_VECTOR(5 DOWNTO 0);
Jump:	out STD_LOGIC;
MemtoReg: out STD_LOGIC;
MemWrite: out STD_LOGIC;
BranchEQ: out STD_LOGIC;
BranchLT: out STD_LOGIC;
BranchGT: out STD_LOGIC;
ALUControl: out STD_LOGIC_VECTOR(2 DOWNTO 0);
ALUSrc: out STD_LOGIC;
RegDst: out STD_LOGIC;
RegWrite: out STD_LOGIC);
end component;

component datamemory 
PORT (
ukey: in STD_LOGIC_VECTOR(127 DOWNTO 0);
din: in STD_LOGIC_VECTOR(63 DOWNTO 0);
A: in STD_LOGIC_VECTOR(31 DOWNTO 0);
WD: in STD_LOGIC_VECTOR(31 DOWNTO 0);
WE: in STD_LOGIC; 
clk: in STD_LOGIC; 	   	
RD: out STD_LOGIC_VECTOR(31 DOWNTO 0);
----Test/debug signals---
dmem_00h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_01h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_02h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_03h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_04h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_05h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_06h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_07h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_08h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_09h: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_0Ah: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_0Bh: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_0Ch: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_0Dh: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_0Eh: out STD_LOGIC_VECTOR(31 DOWNTO 0);
dmem_0Fh: out STD_LOGIC_VECTOR(31 DOWNTO 0));
-------------------
end component;

component instructionmemory 
PORT (address: in STD_LOGIC_VECTOR(31 DOWNTO 0);
 	   data: out STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

component programcounter 
PORT (
EorD: in STD_LOGIC;
din: in STD_LOGIC_VECTOR(31 DOWNTO 0);
clk: in STD_LOGIC;
clr: in STD_LOGIC;
dout: out STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;

component registerfile 
PORT (
A1: in STD_LOGIC_VECTOR(4 DOWNTO 0);
A2: in STD_LOGIC_VECTOR(4 DOWNTO 0);
A3: in STD_LOGIC_VECTOR(4 DOWNTO 0);
WD3: in STD_LOGIC_VECTOR(31 DOWNTO 0);
WE3: in STD_LOGIC;
clk: in STD_LOGIC;
RD1: out STD_LOGIC_VECTOR(31 DOWNTO 0);
RD2: out STD_LOGIC_VECTOR(31 DOWNTO 0);
---Test/ Debug signals-----
R0:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R1:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R2:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R3:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R4:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R5:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R6:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R7:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R8:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R9:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R10:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R11:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R12:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R13:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R14:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R15:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R16:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R17:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R18:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R19:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R20:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R21:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R22:out STD_LOGIC_VECTOR(31 DOWNTO 0));
--------------------
end component;

component signextend 
PORT (
A: in STD_LOGIC_VECTOR(15 DOWNTO 0);
SignImm: out STD_LOGIC_VECTOR(31 DOWNTO 0));
end component;


------------------//signals//---------------------------------------------------------
signal PCmuxout : STD_LOGIC_VECTOR(31 downto 0);--:=x"00000000";
signal instIN : STD_LOGIC_VECTOR(31 downto 0);--:=x"00000000";
signal instOUT : STD_LOGIC_VECTOR(31 downto 0);
signal RegDstMuxOut : STD_LOGIC_VECTOR(4 downto 0);
signal MemtoRegMuxOut : STD_LOGIC_VECTOR(31 downto 0);
signal RegWriteSignal : STD_LOGIC;
--signal RegWriteSignalFF : STD_LOGIC;
signal RD1Out : STD_LOGIC_VECTOR(31 downto 0);
signal RD2Out : STD_LOGIC_VECTOR(31 downto 0);
signal SignImmOut : STD_LOGIC_VECTOR(31 downto 0);
signal ALUSrcMuxOut : STD_LOGIC_VECTOR(31 downto 0);
signal ALUControlSignal: STD_LOGIC_VECTOR(2 downto 0);
signal ZeroSignal : STD_LOGIC;
signal GreatThanSignal : STD_LOGIC;
signal LessThanSignal : STD_LOGIC;
signal ALUResultOut : STD_LOGIC_VECTOR(31 downto 0);
signal MemWriteSignal : STD_LOGIC;
signal ReadDataOut : STD_LOGIC_VECTOR(31 downto 0);
signal JumpSignal : STD_LOGIC;
signal MemtoRegSignal : STD_LOGIC;
signal BranchEQSignal : STD_LOGIC;
signal BranchLTSignal : STD_LOGIC;
signal BranchGTSignal : STD_LOGIC;
signal ALUSrcSignal : STD_LOGIC;
signal RegDstSignal : STD_LOGIC;
signal Branch : STD_LOGIC;
signal PCMuxSignal : STD_LOGIC_VECTOR(1 downto 0):="00";
signal PC00Signal : STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal PC01Signal : STD_LOGIC_VECTOR(31 downto 0):=x"00000000";
signal PC10Signal : STD_LOGIC_VECTOR(31 downto 0):=x"00000000";

----Additional signals from reg file for test/debug purpose---------
signal R0: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R1: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R2: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R3: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R4: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R5: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R6: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R7: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R8: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R9: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R10: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R11: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R12: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R13: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R14: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R15: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R16: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R17: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R18: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R19: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R20: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R21: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal R22: STD_LOGIC_VECTOR(31 DOWNTO 0);

----Additional signals from dmem for test/debug purpose-------------------
signal dmem_00h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_01h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_02h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_03h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_04h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_05h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_06h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_07h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_08h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_09h: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_0Ah: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_0Bh: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_0Ch: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_0Dh: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_0Eh: STD_LOGIC_VECTOR(31 DOWNTO 0);
signal dmem_0Fh: STD_LOGIC_VECTOR(31 DOWNTO 0);
-------------------
--------------------------------------------------------------------------------------
begin
-----------//code//-------------------------------------------------------------------
PC: programcounter PORT MAP(EorD,PCmuxout,clk,clr,instIN);
IM: instructionmemory PORT MAP(instIN,instOUT);
RF: registerfile PORT MAP(instOUT(25 downto 21),instOUT(20 downto 16),RegDstMuxOut,MemtoRegMuxOut,RegWriteSignal,clk,RD1Out,RD2Out,R0,R1,R2,R3,R4,R5,R6,R7,R8,R9,R10,R11,R12,R13,R14,R15,R16,R17,R18,R19,R20,R21,R22);
SImm: signextend PORT MAP(instOUT(15 downto 0),SignImmOut);
AL: alu PORT MAP(RD1Out,ALUSrcMuxOut,ALUControlSignal,ZeroSignal,GreatThanSignal,LessThanSignal,ALUResultOut);
DM: datamemory PORT MAP(ukey,din,ALUResultOut,RD2Out,MemWriteSignal,clk,ReadDataOut,dmem_00h,dmem_01h,dmem_02h,dmem_03h,dmem_04h,dmem_05h,dmem_06h,dmem_07h,dmem_08h,dmem_09h,dmem_0Ah,dmem_0Bh,dmem_0Ch,dmem_0Dh,dmem_0Eh,dmem_0Fh);
CU: controlunit PORT MAP(instOUT(31 downto 26),instOUT(5 downto 0),JumpSignal,MemtoRegSignal,MemWriteSignal,BranchEQSignal,BranchLTSignal,BranchGTSignal,ALUControlSignal,ALUSrcSignal,RegDstSignal,RegWriteSignal);

Reg1<=R1;
Reg2<=R2;
--RegDst MUX---
with RegDstSignal select
RegDstMuxOut <= instOUT(15 downto 11) when '1',
					 instOUT(20 downto 16) when others;
--ALUSrc MUX---
with ALUSrcSignal select
ALUSrcMuxOut <= SignImmOut when '1',
					 RD2Out when others;
--MemtoReg MUX--
with MemtoRegSignal select
MemtoRegMuxOut <= ReadDataOut when '1',
						ALUResultOut when others;
--Branch---
Branch <= (BranchEQSignal and ZeroSignal)or(BranchLTSignal and LessThanSignal)or(BranchGTSignal and GreatThanSignal);
--PCmuxout--
with PCMuxSignal select
PCmuxout <= PC01Signal when "01",
				PC10Signal when "10",
				PC00Signal when others;
--PCMuxSignal--
PCMuxSignal(1)<=JumpSignal;
PCMuxSignal(0)<=Branch;
--PC00Signal--
PC00Signal<=instIN + x"00000001";
--PC01Signal--
PC01Signal<=PC00Signal+SignImmOut;
--PC10Signal--
PC10Signal(31 downto 26)<=PC00Signal(31 downto 26);
PC10Signal(25 downto 0)<=instOUT(25 downto 0);
--------------------------------------------------------------------------------------
end Behavioral;

