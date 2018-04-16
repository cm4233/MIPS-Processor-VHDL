--VHDL Code for the PC (Program Counter) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity programcounter is
---------//ports//---------
PORT (
EorD: in STD_LOGIC;--this signal is for our test program to either encrypt or decrypt first
din: in STD_LOGIC_VECTOR(31 DOWNTO 0);
clk: in STD_LOGIC;
clr: in STD_LOGIC;
dout: out STD_LOGIC_VECTOR(31 DOWNTO 0));
--------------------------
end programcounter;

architecture Behavioral of programcounter is
begin
----------//code//---------
PROCESS (clr, clk)  BEGIN
  IF (clr='0' and EorD='0') THEN dout <= x"00000000"; --start PC from here to start encryption for our test program inside IM
  ELSIF (clr='0' and EorD='1') THEN dout <= x"0000006E";-- PC start from here to do decryption for our test program inside the IM 
  ELSIF (clk'EVENT AND clk='1') THEN dout<=din;-- The ProgCounter here is just a flip flop whose output will go into the addr port 
  END IF;                                      -- of the IM. It's input comes from the top module and CU which decides whether to pass
END PROCESS;                                   -- "PC+1" or "PC+branchOffset" to the program counter depending on the current instr. 
--------------------------
end Behavioral;

