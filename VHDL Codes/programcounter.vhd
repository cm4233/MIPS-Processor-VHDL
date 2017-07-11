--VHDL Code for the PC (Program Counter) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity programcounter is
---------//ports//---------
PORT (
EorD: in STD_LOGIC;
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
  IF (clr='0' and EorD='0') THEN dout <= x"00000000";
  ELSIF (clr='0' and EorD='1') THEN dout <= x"0000006E";
  ELSIF (clk'EVENT AND clk='1') THEN dout<=din;
  END IF;
END PROCESS;
--------------------------
end Behavioral;

