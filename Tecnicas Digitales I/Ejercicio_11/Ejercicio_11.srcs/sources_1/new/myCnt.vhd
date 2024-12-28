library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.all;
library work;
--library UNISIM;
--use UNISIM.VComponents.all;

entity myCnt is
Generic (M:integer := 100 );
Port (  clk:    in std_logic ;
        rst:    in std_logic ;
        ena:    in std_logic ;
        salidaM_2:  out std_logic;
        salidaM:    out std_logic);
end myCnt;

architecture Behavioral of myCnt is
constant N: integer:= integer( ceil(log2(real(M))) );
constant M_2: unsigned (N-1 downto 0) := TO_UNSIGNED(M, N)/2; 

----- SIGNALS -----------------------------------------------
signal cont_aux: std_logic_vector (N-1 downto 0);
signal rst_aux: std_logic ;
signal salidaM_aux: std_logic ;
--------------------------------------------------------------

begin

rst_aux <= rst or salidaM_aux;  --Reset normal + reset de cont = M
----- COMPONENTS ---------------------------------------------
contador: entity work.myCntBinarioSimple        -- Creo un cont que resetea al llegar al valor pedido
Generic map(N=>N)           
Port map(clk => clk, rst => rst_aux, ena=>ena, q=>cont_aux);
--------------------------------------------------------------

salidaM <= salidaM_aux;

salidaM_aux <=  '1' when (unsigned(cont_aux) = M) else 
                '0';

salidaM_2 <=    '1' when (unsigned(cont_aux) = M_2) else 
                '1' when (unsigned(cont_aux) = M ) else
                '0';
end Behavioral;
