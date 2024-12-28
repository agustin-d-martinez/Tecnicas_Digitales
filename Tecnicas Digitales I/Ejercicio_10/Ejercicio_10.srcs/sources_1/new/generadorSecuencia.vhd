library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library WORK;

--use IEEE.NUMERIC_STD.ALL;

entity generadorSecuencia is
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    gen: in std_logic ;
    salida: out std_logic);
end generadorSecuencia;

architecture Behavioral of generadorSecuencia is
signal InutilA: std_logic;
signal InutilB: std_logic_vector(3 downto 0);

signal encendido: std_logic;
signal gen_aux: std_logic_vector (1 downto 0);

constant secuencia: std_logic_vector (3 downto 0) := "1010";        
begin                                                 -- La secuencia tarda 1 clock en ararncar porque la meti en un shift register                 

detector_ON: entity work.myShiftReg
Generic map( N => 2 )
Port map (clk => clk , rst=> rst , ena=> '1' , si=> gen , so=> InutilA , po=> gen_aux , pi=> "00" , pl=> '0');

encendido <= '1' when (gen_aux = "10") else '0';    --1 pulso de 1 clock de duraci?n es igual a 010 en un shift register

generador_sec: entity work.myShiftReg
Generic map( N => 4 )
Port map (clk => clk , rst=> rst , ena=> '1' , si=> '0' , so=> salida , po=> InutilB , pi=> secuencia , pl=> encendido);

end Behavioral;
