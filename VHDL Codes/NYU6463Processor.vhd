--Top Module
--VHDL Code for implementing the MIPS Processor on Artix 7 FPGA --
--The ucf file is used for interfacing the board's switches, buttons and 7seg display to the fpga
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity NYU6463Processor is
PORT (	sw: in STD_LOGIC_VECTOR(15 DOWNTO 0);
clk,btnc,btnu,btnl: in STD_LOGIC;
SSEG_CA : out  STD_LOGIC_VECTOR (7 downto 0);
SSEG_AN : out  STD_LOGIC_VECTOR (7 downto 0)); 
end NYU6463Processor;

architecture Behavioral of NYU6463Processor is
--//components//---
component MIPSProcessor
PORT (
clk: in STD_LOGIC;
clr: in STD_LOGIC;
din: in STD_LOGIC_VECTOR(63 DOWNTO 0);
ukey: in STD_LOGIC_VECTOR(127 DOWNTO 0);
EorD: in STD_LOGIC;
Reg1: out STD_LOGIC_VECTOR(31 DOWNTO 0);
Reg2: out STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end component;
----//signals//----
signal clk50mhzSignal: STD_LOGIC :='0';
signal clkSignal: STD_LOGIC;
signal clrSignal: STD_LOGIC;
signal dinSignal: STD_LOGIC_VECTOR(63 DOWNTO 0);
signal ukeySignal: STD_LOGIC_VECTOR(127 DOWNTO 0);
signal EorDSignal: STD_LOGIC:='0';
signal Reg1Signal: STD_LOGIC_VECTOR(31 DOWNTO 0);--Gets displayed on 7seg
signal Reg2Signal: STD_LOGIC_VECTOR(31 DOWNTO 0);--Gets displayed on 7seg
-------------------
----7seg display signals-----
component Hex2LED --Converts a 4 bit hex value into the pattern to be displayed on the 7seg
port (CLK: in STD_LOGIC; X: in STD_LOGIC_VECTOR (3 downto 0); Y: out STD_LOGIC_VECTOR (7 downto 0)); 
end component; 

type arr is array(0 to 22) of std_logic_vector(7 downto 0);
signal NAME: arr;
signal Val : std_logic_vector(3 downto 0) := (others => '0');
signal HexVal: std_logic_vector(31 downto 0);
signal slowCLK: std_logic:='0';
signal i_cnt: std_logic_vector(19 downto 0):=x"00000";
----end of 7seg display signals---

begin
----//code//-------
with sw(0) select
clkSignal<=clk when '1',
				'0' when others;
with sw(1) select
EorDSignal<='0' when '0',
				'1' when others;
clrSignal<=not btnc;
process(clkSignal)
begin
if(rising_edge(clkSignal))then
clk50mhzSignal<=not clk50mhzSignal;
end if;
end process;
--dinSignal<=x"B278C165CC97D184";--Simple Test
--ukeySignal<=x"DC49DB1375A5584F6485B413B5F12BAF";
MIPS: MIPSProcessor PORT MAP(clk50mhzSignal,clrSignal,dinSignal,ukeySignal,EorDSignal,Reg1Signal,Reg2Signal);
-------end code------------

------7 seg display code-----
-----Creating a slowCLK of 500Hz using the board's 100MHz clock----
process(CLK)
begin
if (rising_edge(CLK)) then
if (i_cnt=x"186A0")then --Hex(186A0)=Dec(100,000)
slowCLK<=not slowCLK; --slowCLK toggles once after we see 100000 rising edges of CLK. 2 toggles is one period.
i_cnt<=x"00000";
else
i_cnt<=i_cnt+'1';
end if;
end if;
end process;

-----We use the 500Hz slowCLK to run our 7seg display at roughly 60Hz-----
timer_inc_process : process (slowCLK)
begin
	if (rising_edge(slowCLK)) then
				if(Val="1000") then
				Val<="0001";
				else
				Val <= Val + '1'; --Val runs from 1,2,3,...8 on every rising edge of slowCLK
			end if;
		end if;
	--end if;
end process;

--This select statement selects one of the 7-segment diplay anode(active low) at a time. 
with Val select
	SSEG_AN <= "01111111" when "0001",
				  "10111111" when "0010",
				  "11011111" when "0011",
				  "11101111" when "0100",
				  "11110111" when "0101",
				  "11111011" when "0110",
				  "11111101" when "0111",
				  "11111110" when "1000",
				  "11111111" when others;

process(sw,btnu,btnl)
begin
----Using buttons and switches to accept 128 bit ukey from user-------------------------------------------------
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0000") then
ukeySignal(127 downto 120) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0001") then
ukeySignal(119 downto 112) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0010") then
ukeySignal(111 downto 104) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0011") then
ukeySignal(103 downto 96) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0100") then
ukeySignal(95 downto 88) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0101") then
ukeySignal(87 downto 80) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0110") then
ukeySignal(79 downto 72) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="0111") then
ukeySignal(71 downto 64) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1000") then
ukeySignal(63 downto 56) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1001") then
ukeySignal(55 downto 48) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1010") then
ukeySignal(47 downto 40) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1011") then
ukeySignal(39 downto 32) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1100") then
ukeySignal(31 downto 24) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1101") then
ukeySignal(23 downto 16) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1110") then
ukeySignal(15 downto 8) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='1' and sw(6 downto 3)="1111") then
ukeySignal(7 downto 0) <= sw(15 downto 8); 
end if;
----Using buttons and switches to accept a 64bit data from user-----------------------------------------------
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0000") then
dinSignal(63 downto 56) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0001") then
dinSignal(55 downto 48) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0010") then
dinSignal(47 downto 40) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0011") then
dinSignal(39 downto 32) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0100") then
dinSignal(31 downto 24) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0101") then
dinSignal(23 downto 16) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0110") then
dinSignal(15 downto 8) <= sw(15 downto 8); 
end if;
if(btnu='1' and btnl='0' and sw(7)='0' and sw(6 downto 3)="0111") then
dinSignal(7 downto 0) <= sw(15 downto 8); 
end if;
------------------------------------------------------------------------
--Using sw(2) switch on the fpga board to select between displaying Reg1Signal or Reg2Signal
if(sw(2)='1') then
case Val is
	 when "0001"=>SSEG_CA <= NAME(0); 
	 when "0010"=> SSEG_CA <= NAME(1); 
	 when "0011"=> SSEG_CA <= NAME(2);
	 when "0100"=>SSEG_CA <= NAME(3);  
	 when "0101"=> SSEG_CA <= NAME(4); 
	 when "0110"=>SSEG_CA <= NAME(5); 
	 when "0111"=>SSEG_CA <= NAME(6); 
	 when "1000"=> SSEG_CA <= NAME(7);
	 when others=>SSEG_CA <= NAME(0);
    end case;	

else
case Val is
	 when "0001"=>SSEG_CA <= NAME(8); 
	 when "0010"=> SSEG_CA <= NAME(9); 
	 when "0011"=> SSEG_CA <= NAME(10);
	 when "0100"=>SSEG_CA <= NAME(11);  
	 when "0101"=> SSEG_CA <= NAME(12); 
	 when "0110"=>SSEG_CA <= NAME(13); 
	 when "0111"=>SSEG_CA <= NAME(14); 
	 when "1000"=> SSEG_CA <= NAME(15);
	 when others=>SSEG_CA <= NAME(8);
    end case;	

end if;
end process;

CONV1: Hex2LED port map (CLK => CLK, X => Reg1Signal(31 downto 28), Y => NAME(0));--Converting Reg1Signal's content into a 7seg display
CONV2: Hex2LED port map (CLK => CLK, X => Reg1Signal(27 downto 24), Y => NAME(1));--pattern so that we can visually display it on
CONV3: Hex2LED port map (CLK => CLK, X => Reg1Signal(23 downto 20), Y => NAME(2));--the 7segment display of the fpga board
CONV4: Hex2LED port map (CLK => CLK, X => Reg1Signal(19 downto 16), Y => NAME(3));		
CONV5: Hex2LED port map (CLK => CLK, X => Reg1Signal(15 downto 12), Y => NAME(4));
CONV6: Hex2LED port map (CLK => CLK, X => Reg1Signal(11 downto 8), Y => NAME(5));
CONV7: Hex2LED port map (CLK => CLK, X => Reg1Signal(7 downto 4), Y => NAME(6));
CONV8: Hex2LED port map (CLK => CLK, X => Reg1Signal(3 downto 0), Y => NAME(7));

CONV9: Hex2LED port map (CLK => CLK, X => Reg2Signal(31 downto 28), Y => NAME(8));
CONV10: Hex2LED port map (CLK => CLK, X => Reg2Signal(27 downto 24), Y => NAME(9));
CONV11: Hex2LED port map (CLK => CLK, X => Reg2Signal(23 downto 20), Y => NAME(10));
CONV12: Hex2LED port map (CLK => CLK, X => Reg2Signal(19 downto 16), Y => NAME(11));		
CONV13: Hex2LED port map (CLK => CLK, X => Reg2Signal(15 downto 12), Y => NAME(12));
CONV14: Hex2LED port map (CLK => CLK, X => Reg2Signal(11 downto 8), Y => NAME(13));
CONV15: Hex2LED port map (CLK => CLK, X => Reg2Signal(7 downto 4), Y => NAME(14));
CONV16: Hex2LED port map (CLK => CLK, X => Reg2Signal(3 downto 0), Y => NAME(15));
-------end of 7 seg display--------
end Behavioral;

