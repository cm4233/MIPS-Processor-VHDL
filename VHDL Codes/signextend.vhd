--VHDL Code for the SImm (Sign Immediate Extention 16bits to 32bits) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signextend is
---------//ports//---------
PORT (
A: in STD_LOGIC_VECTOR(15 DOWNTO 0);

SignImm: out STD_LOGIC_VECTOR(31 DOWNTO 0));
--------------------------
end signextend;

architecture Behavioral of signextend is
begin
----------//code//---------
SignImm(15 downto 0)<=A(15 downto 0);
with A(15) select
SignImm(31 downto 16) <= 	x"FFFF" when '1',
									x"0000" when others;	
---------------------------
end Behavioral;

