----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2023 18:32:56
-- Design Name: 
-- Module Name: myDeco7Seg - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myDeco7Seg is
    Port ( entrada : in STD_LOGIC_VECTOR (3 downto 0);
           a,b,c,d,e,f,g : out STD_LOGIC);
end myDeco7Seg;

architecture Behavioral of myDeco7Seg is
signal y: STD_LOGIC_VECTOR (6 downto 0) ;
begin
a <= y(6);
b <= y(5);
c <= y(4);
d <= y(3);
e <= y(2);
f <= y(1);
g <= y(0);

with entrada select
y <=    "1111110" when "0000",
        "0110000" when "0001",
        "1101101" when "0010",
        "1111001" when "0011",
        "0110011" when "0100",
        "1011011" when "0101",
        "1011111" when "0110",
        "1110000" when "0111",
        "1111111" when "1000",
        "1111011" when "1001",
        "1110111" when "1010",
        "0011111" when "1011",
        "1001111" when "1100",
        "0111101" when "1101",
        "1001111" when "1110",
        "1000111" when "1111",
        "0000000" when others;


--a <= '0' when (entrada = "0001" or entrada = "0100" or entrada = "1011" or entrada = "1101") else '1';
--a <= (not entrada(2) and not entrada(0)) or (not entrada(3) and entrada(1)) or (not entrada(3) and entrada(2) and entrada(0)) or (entrada(3) and not entrada(2) and not entrada(1)) or (entrada(3) and not entrada(0)) or (entrada(2) and entrada(1));
--b <= '0' when (entrada = "0101" or entrada = "0110" or entrada = "1011" or entrada = "1100" or entrada = "1110" or entrada = "1111") else '1';
--c <= '0' when (entrada = "0010" or entrada = "1100" or entrada = "1110" or entrada = "1111") else '1';
--d <= '0' when (entrada = "0001" or entrada = "0100" or entrada = "0111" or entrada = "1010" or entrada = "1111") else '1';
--e <= (entrada(3) or not entrada(0)) and (entrada(3) or not entrada(2) or entrada(1)) and (entrada(2) or entrada(1) or not entrada(0));
--f <= '0' when (entrada = "0001" or entrada = "0010" or entrada = "0011" or entrada = "0111" or entrada = "1101") else '1';
--g <= '0' when (entrada = "0000" or entrada = "0001" or entrada = "0111") else '1';
end Behavioral;
