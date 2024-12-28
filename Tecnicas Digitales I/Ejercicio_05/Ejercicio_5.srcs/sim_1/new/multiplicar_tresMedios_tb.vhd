library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplicar_tresMedios_tb is
Generic (N: integer:= 8);
--  Port ( );
end multiplicar_tresMedios_tb;

architecture Behavioral of multiplicar_tresMedios_tb is
	signal a:	std_logic_vector (N-1 downto 0);
    signal decimal:	std_logic;
    signal res : std_logic_vector (N-1 downto 0);
begin
uub:  entity work.multiplicar_tresMedios
Generic map (N=>N)
Port map (a=>a,  decimal=>decimal, res =>res);

proc: process
begin
	a <= "00011010";
	wait for 10ns;
	a <= "00000110";
	wait for 10ns;
	a <= "01101100";
	wait for 10ns;
	a <= "10101101";
	wait for 10ns;
end process;
end Behavioral;
