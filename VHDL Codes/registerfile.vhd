--VHDL Code for the RF (Register File) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registerfile is
---------//ports//----------------------------------------------------------------------
PORT (
A1: in STD_LOGIC_VECTOR(4 DOWNTO 0);--addr port 1 to read reg, reg content goes to RD1
A2: in STD_LOGIC_VECTOR(4 DOWNTO 0);--addr port 2 to read reg, reg content goes to RD2
A3: in STD_LOGIC_VECTOR(4 DOWNTO 0);--addr port 3 to write data in WD3 into register 
WD3: in STD_LOGIC_VECTOR(31 DOWNTO 0);--data to be written into reg specified by A3
WE3: in STD_LOGIC;--write enable for A3 and WD3
clk: in STD_LOGIC;--clock

RD1: out STD_LOGIC_VECTOR(31 DOWNTO 0);--shows reg content of the reg specified by A1 
RD2: out STD_LOGIC_VECTOR(31 DOWNTO 0);--shows reg content of the reg specified by A2 
-----------------------------------------------------------------------------------------

---------------//additional testing ports//-----------------------------------------------
R0:out STD_LOGIC_VECTOR(31 DOWNTO 0);--Probing additional signals directly to these 
R1:out STD_LOGIC_VECTOR(31 DOWNTO 0);--ports to directly see and check the the register content
R2:out STD_LOGIC_VECTOR(31 DOWNTO 0);--of a few registers in simulation instead of using   
R3:out STD_LOGIC_VECTOR(31 DOWNTO 0);--a load instruction for each individual register
R4:out STD_LOGIC_VECTOR(31 DOWNTO 0);
R5:out STD_LOGIC_VECTOR(31 DOWNTO 0);--Probed only regs R0-R22 beacuse they were beign used
R6:out STD_LOGIC_VECTOR(31 DOWNTO 0);--in our test programs
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
--32x32 ram is the reg file 
--so totally 32 registers and each reg is 32bit wide
--since 5 bits were allocated to the regs in the ISA, we have 32 regs
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
RD1<=regfile(CONV_INTEGER(A1));--read data from reg specified by addr A1
RD2<=regfile(CONV_INTEGER(A2));--read data from reg specified by addr A2
process(clk)
begin
if (clk'EVENT AND clk='1') then
if(WE3='1')then                 --write enable
regfile(CONV_INTEGER(A3))<=WD3; --write data in WD3 into reg specified by addr A3
end if;
end if;
end process;

-----//additional testing ports//--------
R0<=regfile(0);--Probing additional signals directly to these
R1<=regfile(1);--ports to directly see and check the the register content
R2<=regfile(2);--of a few registers in simulation instead of using
R3<=regfile(3);--a load instruction for each individual register
R4<=regfile(4);
R5<=regfile(5);--Probed only regs R0-R22 beacuse they were beign used
R6<=regfile(6);--in our test programs
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

