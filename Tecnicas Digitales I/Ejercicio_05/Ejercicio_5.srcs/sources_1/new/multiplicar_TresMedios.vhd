library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
--library UNISIM;
--use UNISIM.VComponents.all;

entity multiplicar_tresMedios is
Generic(N:integer := 4);
Port (  a:	in std_logic_vector (N-1 downto 0);
        decimal:	out std_logic;
        res :		out std_logic_vector (N-1 downto 0));
end multiplicar_tresMedios;

architecture Behavioral of multiplicar_tresMedios is
	signal a_2: 	std_logic_vector (N-1 downto 0);
	signal suma:	std_logic_vector (N-1 downto 0);

begin
	sumador: entity work.sumadorRestador
	Generic map (N=>N)
	Port map (a=>a , b=>a_2 , s_r=>'1' , ov=>open , resultado=>suma );
	
	a_2 <= a(N-1) & a((N-1) downto 1); 
	res <= suma;
	decimal <= a(0);
	
end Behavioral;