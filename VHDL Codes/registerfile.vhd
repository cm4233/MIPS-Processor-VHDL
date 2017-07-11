--VHDL Code for the RF (Register File) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registerfile is
---------//ports//---------
PORT (
A1: in STD_LOGIC_VECTOR(4 DOWNTO 0);
A2: in STD_LOGIC_VECTOR(4 DOWNTO 0);
A3: in STD_LOGIC_VECTOR(4 DOWNTO 0);
WD3: in STD_LOGIC_VECTOR(31 DOWNTO 0);
WE3: in STD_LOGIC;
clk: in STD_LOGIC;

RD1: out STD_LOGIC_VECTOR(31 DOWNTO 0);
RD2: out STD_LOGIC_VECTOR(31 DOWNTO 0);

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
R22:out STD_LOGIC_VECTOR(31 DOWNTO 0)
-----------------------
);
--------------------------
end registerfile;

architecture Behavioral of registerfile is
-----//signals//----------
TYPE ram IS ARRAY (0 TO 31) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL regfile: 
ram:=ram'(x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000",
x"00000000", x"00000000", x"00000000", x"00000000");
---------------------------
begin
----------//code//---------
RD1<=regfile(CONV_INTEGER(A1));
RD2<=regfile(CONV_INTEGER(A2));
process(clk)
begin
if (clk'EVENT AND clk='1') then
if(WE3='1')then
regfile(CONV_INTEGER(A3))<=WD3;
end if;
end if;
end process;

R0<=regfile(0);
R1<=regfile(1);
R2<=regfile(2);
R3<=regfile(3);
R4<=regfile(4);
R5<=regfile(5);
R6<=regfile(6);
R7<=regfile(7);
R8<=regfile(8);
R9<=regfile(9);
R10<=regfile(10);
R11<=regfile(11);
R12<=regfile(12);
R13<=regfile(13);
R14<=regfile(14);
R15<=regfile(15);
R16<=regfile(16);
R17<=regfile(17);
R18<=regfile(18);
R19<=regfile(19);
R20<=regfile(20);
R21<=regfile(21);
R22<=regfile(25);
--------------------
--------------------------
end Behavioral;

