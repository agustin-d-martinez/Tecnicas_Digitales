library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Operacion_Cuadrado_tb is
Generic (N: integer:= 4);
--  Port ( );
end Operacion_Cuadrado_tb;

architecture Behavioral of Operacion_Cuadrado_tb is
signal a: std_logic_vector (N-1 downto 0);
signal res: std_logic_vector ((2*N)-1 downto 0);
begin
uub: entity work.Operacion_Cuadrado
	Generic map (N=>N)
	Port map(a=>a , res=>res );

proc: process
begin
	a <= X"F"; wait for 10 ns;
	a <= X"4"; wait for 10 ns;
	a <= X"1"; wait for 10 ns;
	a <= X"5"; wait for 10 ns;
	a <= X"9"; wait for 10 ns;
	wait;
end process;
end Behavioral;
