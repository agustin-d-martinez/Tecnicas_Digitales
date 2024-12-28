----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2023 15:49:35
-- Design Name: 
-- Module Name: myMux4 - Behavioral
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

entity myMux4 is
    Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
           c : in STD_LOGIC_VECTOR (1 downto 0);
           y : out STD_LOGIC);
end myMux4;

architecture Behavioral of myMux4 is

begin
with c select
y <=    a(0) when "00",
        a(1) when "01",
        a(2) when "10",
        a(3) when "11",
        a(3) when others;
end Behavioral;
