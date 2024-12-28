library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Operacion_Cuadrado is
Generic(N:integer := 4);
Port (  a:	in std_logic_vector (N-1 downto 0);
        res :		out std_logic_vector ((2*N)-1 downto 0));
end Operacion_Cuadrado;

architecture Behavioral of Operacion_Cuadrado is
constant MAX_AUX: std_logic_vector (N-1 downto 0):= (others=>'1');
constant MAX_SUMAS: integer:=  to_integer(unsigned(MAX_AUX));

type type_aux_sumas is array (0 to MAX_SUMAS-1) of std_logic_vector((2*N)-1 downto 0); 
signal suma_parcial:	 type_aux_sumas;
signal INDEX: integer;


signal a_aux: std_logic_vector ((2*N)-1 downto 0);

begin	
	INDEX <= TO_INTEGER(unsigned(a)-1);
	a_aux(N-1 downto 0) <= a;
	a_aux((2*N)-1 downto N) <= (others=>'0');
	
	suma_parcial(0) <= a_aux;
	
	multiplicar: for i in 1 to (MAX_SUMAS-1) generate
		sumador: entity work.sumadorRestador
			Generic map (N=>2*N)
			Port map (a=>a_aux , b=>suma_parcial(i-1) , s_r=>'1' , ov=>open , resultado=>suma_parcial(i) );
	end generate;
	
	res <= 	(others=>'0') when (TO_INTEGER (unsigned(a)) = 0) else
			suma_parcial(INDEX);
end Behavioral;
