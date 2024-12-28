library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity medirPeriodo is
    Generic (N: integer := 4);
    Port ( clk : in std_logic;
           rst : in std_logic;
           entrada : in std_logic;
           periodo : out std_logic_vector (N-1 downto 0));
end medirPeriodo;

architecture Behavioral of medirPeriodo is
signal cuenta: std_logic_vector (N-1 downto 0) ;
signal rst_cont: std_logic;

signal entrada_flanco: std_logic;
signal periodo_d:std_logic_vector (N-1 downto 0);
signal periodo_q:std_logic_vector (N-1 downto 0);

begin
	contador: entity work.myCntBinarioSimple		--Cuento
	Generic map (N=>N)
	Port map (clk=>clk , rst=>rst_cont , ena=>'1' , q=>cuenta );
	
	flanco: entity work.myEdgeDetector		--Detecto flanco de entrada
	Port map (clk=>clk , rst=>rst , d=>entrada , ascendente=>entrada_flanco , descendente => open);

	periodo_d <= std_logic_vector(signed(cuenta)+1) when (entrada_flanco = '1') else periodo_q;		--Sumo 1 para tener en cuenta el 0
	rst_cont <= entrada_flanco or rst;

	process (clk)		--Flip flop para la salida
	begin
		if ( rising_edge(clk) ) then
			if ( rst = '1' ) then
				periodo_q <= (others=>'0');
			else
				periodo_q <= periodo_d;
			end if;
			
		end if;
	end process;

--rst_cont <= rst_aux or rst;
periodo <= periodo_d;

end Behavioral;
