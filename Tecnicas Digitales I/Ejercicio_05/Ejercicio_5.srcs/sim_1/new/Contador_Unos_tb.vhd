library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador_Unos_tb is
--  Port ( );
end Contador_Unos_tb;

architecture Behavioral of Contador_Unos_tb is
	signal a:	std_logic_vector (5-1 downto 0);
    signal res : std_logic_vector (5-1 downto 0);
begin
uub:  entity work.Contador_Unos
Port map (a=>a, res =>res);

proc: process
begin
	a <= "11010";
	wait for 10ns;
	a <= "10011";
	wait for 10ns;
	a <= "11111";
	wait for 10ns;
end process;
end Behavioral;
