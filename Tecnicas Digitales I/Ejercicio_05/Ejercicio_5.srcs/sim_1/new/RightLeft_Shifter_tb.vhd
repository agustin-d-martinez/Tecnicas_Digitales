library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity RightLeft_Shifter_tb is
Generic (N: integer:= 4);
--  Port ( );
end RightLeft_Shifter_tb;

architecture Behavioral of RightLeft_Shifter_tb is
	signal A:	std_logic_vector (N-1 downto 0);
 	signal mode:	std_logic;
	signal D:	std_logic_vector (4-1 downto 0);
	signal R:	std_logic_vector (N-1 downto 0);

begin
uub:  entity work.RightLeft_Shifter
Generic map (N=>N)
Port map (A=>A, mode=>mode, D=>D, R=>R);

proc: process
begin
	A <= "0010";
	mode <= '0';
	D <= "0100";
	wait for 10ns;

	A <= "0010";
	mode <= '0';
	D <= "0110";
	wait for 10ns;

	A <= "0010";
	mode <= '1';
	D <= "0101";
	wait for 10ns;
end process;
end Behavioral;
