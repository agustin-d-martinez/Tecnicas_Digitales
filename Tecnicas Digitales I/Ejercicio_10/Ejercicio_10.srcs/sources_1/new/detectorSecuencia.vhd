library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library WORK;
--use IEEE.NUMERIC_STD.ALL;

entity detectorSecuencia is
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    d: in std_logic ;
    salida: out std_logic);
end detectorSecuencia;

architecture Behavioral of detectorSecuencia is
signal codigo: std_logic_vector (4-1 downto 0);
constant clave: std_logic_vector(4-1 downto 0) :="1010";
begin

salida <=   '1' when ( codigo = clave ) else '0';

--- Componentes -------------------------------------------------
shiftReg: entity work.myShiftReg
Generic map( N => 4 )
Port map (clk => clk , rst=> rst , ena=> '1' , si=> d , so=> open , po=> codigo , pi=> "0000" , pl=> '0');
-----------------------------------------------------------------


end Behavioral;
