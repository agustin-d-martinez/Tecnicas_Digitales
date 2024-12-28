library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Promedio4 is
Generic (N: integer:= 4);
Port(	a: in std_logic_vector (N-1 downto 0); 
		b: in std_logic_vector (N-1 downto 0); 
		c: in std_logic_vector (N-1 downto 0); 
		d: in std_logic_vector (N-1 downto 0); 
		res: out std_logic_vector (N-1 downto 0));
end Promedio4;

architecture Behavioral of Promedio4 is
	signal a_aux:std_logic_vector ((N+2)-1 downto 0);
	signal b_aux:std_logic_vector ((N+2)-1 downto 0);
	signal c_aux:std_logic_vector ((N+2)-1 downto 0);
	signal d_aux:std_logic_vector ((N+2)-1 downto 0);
	signal aux1: std_logic_vector ((N+2)-1 downto 0);
	signal aux2: std_logic_vector ((N+2)-1 downto 0);
	signal aux3: std_logic_vector ((N+2)-1 downto 0);
begin
	a_aux <= "00" & a;
	b_aux <= "00" & b;
	c_aux <= "00" & c;
	d_aux <= "00" & d;
	
	suma1: entity work.sumadorRestador
	Generic map (N=>(N+2))
	Port map (a=>a_aux , b=>b_aux , s_r=>'1' , ov=>open , resultado=>aux1 );
	suma2: entity work.sumadorRestador
	Generic map (N=>(N+2))
	Port map (a=>c_aux , b=>d_aux , s_r=>'1' , ov=>open , resultado=>aux2 );
	suma3: entity work.sumadorRestador
	Generic map (N=>(N+2))
	Port map (a=>aux1 , b=>aux2 , s_r=>'1' , ov=>open , resultado=>aux3 );

	res <= aux3((N+2)-1 downto 2);
end Behavioral;
