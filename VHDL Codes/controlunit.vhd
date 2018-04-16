--VHDL Code for the CU (Control Unit) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity controlunit is
---------//ports//---------
PORT (
Op: in STD_LOGIC_VECTOR(5 DOWNTO 0);--The opcode from the current instruction
Funct: in STD_LOGIC_VECTOR(5 DOWNTO 0);
--Control signals branching from the CU go into different muxes inside the processor
--which select specific data paths depending on the instruction
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
---------------------------
end controlunit;

architecture Behavioral of controlunit is
----------//signals//------------

---------------------------------
begin
---------//code//----------------

----------ALUControl--ALUOp--------------------------
with Op select
ALUControl(2 downto 0) <= 	"000" when "000111",
									"000" when "001000",
									"001" when "001001",
									"001" when "001010",
									"001" when "001011",
									"101" when "000101",
									"110" when "000110",
									Funct(2 downto 0) when "000000",					
									Op(2 downto 0)-"001" when others;	
----------MemtoReg--isLoad-----------------------									
with Op select
MemtoReg <= 	'1' when "000111",
					'0' when others;
----------MemWrite--isStore---------------------
with Op select
MemWrite <= 	'1' when "001000",
					'0' when others;
-----------BranchEQ----------------------------------
with Op select
BranchEQ <= 	'1' when "001010",
					'0' when others;
-----------BranchLT----------------------------------
with Op select
BranchLT <= 	'1' when "001001",
					'0' when others;
-----------BranchGT----------------------------------
with Op select
BranchGT <= 	'1' when "001011",
					'0' when others;
-----------Jump----------------------------------
with Op select
Jump <= 	'1' when "001100",
			'0' when others;
-----------RegDst---(!iType)-------------------------------------
with Op select
RegDst <= 	'1' when "000000",
				'1' when "001100",
				'0' when others;				
------------ALUSrc----------------------------------------------
with Op select
ALUSrc <= 	'0' when "000000",
				'0' when "001001",
				'0' when "001010",
				'0' when "001011",
				'1' when others;	
------------RegWrite---------------------------------------------
with Op select
RegWrite <= 	'1' when "000000",
					'1' when "000001",
					'1' when "000010",
					'1' when "000011",
					'1' when "000100",
					'1' when "000101",
					'1' when "000110",
					'1' when "000111",
					'1' when "111111",
					'0' when others;
----------------------------------------------------------------
end Behavioral;

