--VHDL Code for the DM (Data Memory) of the MIPS Processor--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.std_logic_arith.all;

entity datamemory is
---------//ports//--------------------------------------
PORT (
ukey: in STD_LOGIC_VECTOR(127 DOWNTO 0);--a way to write ukey into dmem from fpga for our test program
din: in STD_LOGIC_VECTOR(63 DOWNTO 0);--a way to write data into dmem from fpga for our test program
A: in STD_LOGIC_VECTOR(31 DOWNTO 0);--addr port
WD: in STD_LOGIC_VECTOR(31 DOWNTO 0);-- the data to be written in a location specified by addr A
WE: in STD_LOGIC;-- write enable 
clk: in STD_LOGIC; 	   
		
RD: out STD_LOGIC_VECTOR(31 DOWNTO 0);--data read from a location specified by addr A

	
----------//Additional Test signals//------------------------------------------------------------
dmem_00h: out STD_LOGIC_VECTOR(31 DOWNTO 0);--Probing a few dmem locations directly to the FPGA board
dmem_01h: out STD_LOGIC_VECTOR(31 DOWNTO 0);--just for testing purposes
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
-------------------------------------------------------------------------------------------------------------
-----------------------------------------------
end datamemory;

architecture Behavioral of datamemory is
--------//signals//------------------------
--dmem is RAM 64x32. 64 locations each 32bit wide
TYPE ram IS ARRAY (0 TO 63) OF STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL dmem: 
ram:=ram'(
--storing some initial data needed for our test programs-rc5 encryption and decryption
---------skeys-----------------
"10110111111000010101000101100011", --Pw
"01010110000110001100101100011100", --Pw+ Qw
"11110100010100000100010011010101", --Pw+ 2Qw
"10010010100001111011111010001110", --Pw+ Qw
"00110000101111110011100001000111", --Pw+ 2Qw
"11001110111101101011001000000000", --Pw+ Qw
"01101101001011100010101110111001", --Pw+ 2Qw
"00001011011001011010010101110010", --Pw+ Qw
"10101001100111010001111100101011", --Pw+ 2Qw
"01000111110101001001100011100100", --Pw
"11100110000011000001001010011101", --Pw+ Qw
"10000100010000111000110001010110", --Pw+ 2Qw
"00100010011110110000011000001111", --Pw+ Qw
"11000000101100100111111111001000", --Pw+ 2Qw
"01011110111010011111100110000001", --Pw+ Qw
"11111101001000010111001100111010", --Pw+ 2Qw
"10011011010110001110110011110011", --Pw+ Qw
"00111001100100000110011010101100", --Pw+ 2Qw
"11010111110001111110000001100101", --Pw
"01110101111111110101101000011110", --Pw+ Qw
"00010100001101101101001111010111", --Pw+ 2Qw
"10110010011011100100110110010000", --Pw+ Qw
"01010000101001011100011101001001", --Pw+ 2Qw
"11101110110111010100000100000010", --Pw+ Qw
"10001101000101001011101010111011", --Pw+ 2Qw
"00101011010011000011010001110100", --Pw+ 25Qw?
-------------din--------------------
x"00000000",--using these dmem locations to store user's data to be 
x"00000000",--encrypted/decrypted in our test program
-----------------------------------
x"00000000", 
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000", 
x"00000000", 
x"00000000",
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000", 
x"00000000", 
x"00000000",
x"00000000", 
x"00000000", 
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000",
x"00000000", 
x"00000000", 
x"00000000", 
x"00000000",
x"00000000", 
x"00000000", 
x"00000000",
x"00000000"  
);
--------------------------------------
begin
---------//code//-------------------


process(clk)
begin
if (clk'EVENT AND clk='0') then
	RD<=dmem(CONV_INTEGER(unsigned(A(5 downto 0))));
	if(WE='1')then
	dmem(CONV_INTEGER(unsigned(A(4 downto 0))))<=WD;
	end if;	
dmem(34)<=ukey(103 downto 96) & ukey(111 downto 104) & ukey(119 downto 112) & ukey(127 downto 120);
dmem(35)<=ukey(71 downto 64) & ukey(79 downto 72) & ukey(87 downto 80) & ukey(95 downto 88);
dmem(36)<=ukey(39 downto 32) & ukey(47 downto 40) & ukey(55 downto 48) & ukey(63 downto 56);
dmem(37)<=ukey(7 downto 0) & ukey(15 downto 8) & ukey (23 downto 16) & ukey(31 downto 24);
dmem(32)<=din(63 downto 32);
dmem(33)<=din(31 downto 0);
end if;
end process;


----//Additional Test signals//-------
dmem_00h<=dmem(0);--Probing a few dmem locations directly to the FPGA board
dmem_01h<=dmem(1);--just for testing purpose
dmem_02h<=dmem(2);
dmem_03h<=dmem(3);
dmem_04h<=dmem(4);
dmem_05h<=dmem(5);
dmem_06h<=dmem(6);
dmem_07h<=dmem(7);
dmem_08h<=dmem(8);
dmem_09h<=dmem(9);
dmem_0Ah<=dmem(10);
dmem_0Bh<=dmem(11);
dmem_0Ch<=dmem(12);
dmem_0Dh<=dmem(13);
dmem_0Eh<=dmem(14);
dmem_0Fh<=dmem(15);

------------------
------------------------------------
end Behavioral;

