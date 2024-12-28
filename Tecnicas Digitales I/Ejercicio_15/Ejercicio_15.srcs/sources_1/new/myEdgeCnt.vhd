library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;

entity myEdgeCnt is
Generic (N:integer:=8);
Port(   clk:    in std_logic ;
        rst:    in std_logic ;
        d:      in std_logic ;
        q:      out std_logic_vector (N-1 downto 0));
end myEdgeCnt;

architecture Behavioral of myEdgeCnt is
signal auxiliar: std_logic ;
signal salida_aux: std_logic_vector (N-1 downto 0);

begin
----- COMPONENTS ---------------------------------------------
CONTADOR: entity work.myCntBinarioSimple        
Generic map(N=>N)
Port map( clk=>clk , rst=>rst , ena=>auxiliar , q=>salida_aux );

DETECTOR_FLANCO: entity work.myEdgeDetector
Port map( clk=>clk , rst=>rst , d=>d , ascendente=>auxiliar , descendente=>open );
--------------------------------------------------------------

q <= salida_aux;
end Behavioral;
