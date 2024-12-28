library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
library work;

--library UNISIM;
--use UNISIM.VComponents.all;

entity parpadeo1s is
Generic (SYS_CLK:integer:=100000000);
Port(	clk:	in std_logic ;
		rst:	in std_logic ;
		salida:	out std_logic);
end parpadeo1s;

architecture Behavioral of parpadeo1s is
--------------------------------------------------------------
constant N: integer := integer( ceil(log2(real(SYS_CLK))));
constant NUM_CUENTAS: unsigned (N-1 downto 0):= TO_UNSIGNED (SYS_CLK,N);
signal salida_cont : std_logic ;
signal salida_fft: std_logic ;
signal cont_aux: std_logic_vector (N-1 downto 0) ;
--------------------------------------------------------------
begin
----- COMPONENTS ---------------------------------------------
CONTADOR: entity work.myCnt2
Generic map(N=>N)
Port map( clk=>clk , rst=>rst , ena=>'1' , p=>std_logic_vector(NUM_CUENTAS-1) , salida=>salida_cont );
FF: entity work.FFT
Port map( clk=>clk , rst=>rst , t=>salida_cont , q=>salida_fft );
--------------------------------------------------------------

salida <= salida_fft;

end Behavioral;
