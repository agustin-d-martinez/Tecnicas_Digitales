----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04.05.2023 18:12:29
-- Design Name: 
-- Module Name: coder8a3eg - Behavioral
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

entity coder8a3eg is
    Port ( w : in STD_LOGIC_VECTOR (7 downto 0);
           e : in STD_LOGIC;
           gs: out STD_LOGIC;
           y : out STD_LOGIC_VECTOR (2 downto 0));
           
end coder8a3eg;

architecture Behavioral of coder8a3eg is
signal y_enabled: STD_LOGIC_VECTOR (2 downto 0);
begin

y <= y_enabled when (e = '1') else "000";
y_enabled <=    "111" when (w(7) = '1') else
                "110" when (w(6) = '1') else
                "101" when (w(5) = '1') else
                "100" when (w(4) = '1') else
                "011" when (w(3) = '1') else
                "010" when (w(2) = '1') else
                "001" when (w(1) = '1') else
                "000" when (w(0) = '1') else        --Separ? la condici?n de canal 0 de las "other"
                "000";
gs <= not(e) or w(7) or w(6) or w(5) or w(4) or w(3) or w(2) or w(1) or w(0);

--Supongo gs como: Siempre 1 salvo en caso E= 1 , w=00000000
--                  De esta forma se distingue el y generado por w=00000000 y w=00000001
end Behavioral;
