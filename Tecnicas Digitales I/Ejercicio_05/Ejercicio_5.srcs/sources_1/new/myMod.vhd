library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity myMod is
	Generic (N: integer := 8);
	Port (	entrada : in STD_LOGIC_VECTOR (N - 1 downto 0);
    		salida : out STD_LOGIC_VECTOR (((2 * N) - 1) downto 0));end myMod;

architecture Behavioral of myMod is
signal negado_aux : STD_LOGIC_VECTOR (N - 1 downto 0);
begin
	negado_aux <= std_logic_vector (signed(not(entrada)) + 1 );
	
	salida(N-1 downto 0) <= 	entrada when ( entrada(N-1) = '0' ) ELSE
								negado_aux;
								
	salida (((2*N) - 1) downto N ) <= (others => '0');		--LOS EXTRA	
	
end Behavioral;
