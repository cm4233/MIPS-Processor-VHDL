--VHDL Code for converting hexadecimal values(x0 to xF) into 7 segment display format--
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Hex2LED is
    Port ( CLK: in STD_LOGIC; X : in  STD_LOGIC_VECTOR (3 downto 0);
           Y : out  STD_LOGIC_VECTOR (7 downto 0));
end Hex2LED;

architecture Behavioral of Hex2LED is
begin
--'1' to switch off segment, '0' to turn on segment--
process (CLK)
begin
case X is
when "0000" => Y <= "11000000";--Led segment Pattern for 7 seg display to visually show 0
when "0001" => Y <= "11111001";--Led segment Pattern for 7 seg display to visually show 1 
when "0010" => Y <= "10100100";--Led segment Pattern for 7 seg display to visually show 2 
when "0011" => Y <= "10110000";--Led segment Pattern for 7 seg display to visually show 3 
when "0100" => Y <= "10011001";--Led segment Pattern for 7 seg display to visually show 4
when "0101" => Y <= "10010010";--Led segment Pattern for 7 seg display to visually show 5
when "0110" => Y <= "10000010";--Led segment Pattern for 7 seg display to visually show 6
when "0111" => Y <= "11111000";--Led segment Pattern for 7 seg display to visually show 7
when "1000" => Y <= "10000000";--Led segment Pattern for 7 seg display to visually show 8
when "1001" => Y <= "10010000";--Led segment Pattern for 7 seg display to visually show 9
when "1010" => Y <= "10001000";--Led segment Pattern for 7 seg display to visually show A
when "1011" => Y <= "10000011";--Led segment Pattern for 7 seg display to visually show B 
when "1100" => Y <= "11000110";--Led segment Pattern for 7 seg display to visually show C 
when "1101" => Y <= "10100001";--Led segment Pattern for 7 seg display to visually show D
when "1110" => Y <= "10000110";--Led segment Pattern for 7 seg display to visually show E 
when others => Y <= "10001110";--Led segment Pattern for 7 seg display to visually show F
end case;
end process;
end Behavioral;

