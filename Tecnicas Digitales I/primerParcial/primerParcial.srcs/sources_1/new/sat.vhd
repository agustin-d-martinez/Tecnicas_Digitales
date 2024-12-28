library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_misc.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity sat is
Generic (	N_IN: integer := 16;
			N_OUT: integer := 8);
Port ( 	entrada : in	std_logic_vector (N_IN - 1 downto 0);
		salida : out 	std_logic_vector (N_OUT - 1 downto 0));
end sat;


architecture Behavioral of sat is
	------ SIGNALS ----------------------------------------
	signal max: std_logic_vector (N_OUT-1 downto 0);
	signal min: std_logic_vector (N_OUT-1 downto 0);
	-------------------------------------------------------
begin
	max(N_OUT-1) <= '0';							
	max((N_OUT-1)-1 downto 0) <= (others=>'1');		--Defino valor maximo
	min <= not(max);								--Defino valor minimo
	
	salida <= 	max when (signed(entrada) > signed(max)) else		--Si se pasa por arriba
				min when (signed(entrada) < signed(min)) else		--Si se pasa por abajo
				entrada(N_OUT - 1 downto 0);						--Caso medio
	
end Behavioral;


----- MEJOR FORMA -----------------------------------------------
--	signal unos: std_logic ;
--	signal ceros: std_logic ;

--	ceros <= or_reduce(entrada(N_IN-1 downto N_OUT-1));
--	unos <= and_reduce(entrada(N_IN-1 downto N_OUT-1));
	
--	salida <= 	entrada(N_OUT - 1 downto 0) when (ceros = '0' or unos = '1') else
--				max when (entrada(N_IN-1) = '0') else
--				min;
----- MEJOR FORMA -----------------------------------------------