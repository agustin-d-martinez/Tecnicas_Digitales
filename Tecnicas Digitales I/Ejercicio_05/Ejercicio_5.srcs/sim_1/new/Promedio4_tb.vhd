library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity promedio4_tb is
Generic (N: integer:= 4);
--  Port ( );
end promedio4_tb;

architecture Behavioral of promedio4_tb is
	signal a:	std_logic_vector (N-1 downto 0);
 	signal b:	std_logic_vector (N-1 downto 0);
	signal c:	std_logic_vector (N-1 downto 0);
	signal d:	std_logic_vector (N-1 downto 0);

    signal res : std_logic_vector (N-1 downto 0);
begin
uub:  entity work.promedio4
Generic map (N=>N)
Port map (a=>a, b=>b, c=>c, d=>d, res =>res);

proc: process
begin
	a <= "0010";
	b <= "0100";
	c <= "0100";
	d <= "0001";
	wait for 10ns;
	a <= "0110";
	b <= "1100";
	c <= "0100";
	d <= "1101";

	wait for 10ns;
	a <= "1100";
	b <= "1100";
	c <= "1100";
	d <= "1100";
	wait for 10ns;
	wait;
end process;
end Behavioral;
