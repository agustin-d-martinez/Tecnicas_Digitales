library Work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_misc.ALL;
--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity lfsr_F is
generic (N: integer :=4 );
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    inits: in std_logic_vector (N-1 downto 0);
    taps: in std_logic_vector (N-1 downto 0);
    salida: out std_logic_vector (N-1 downto 0));
end lfsr_F;

architecture Behavioral of lfsr_F is
signal so_inutil: std_logic ;
signal salida_aux: std_logic_vector (N-1 downto 0);
signal res_xor: std_logic;
begin
salida <= salida_aux;

res_xor <= xor_reduce ( taps and salida_aux );

--- Componentes -------------------------------------------------
shiftReg: entity work.myShiftReg
Generic map( N => 4 )
Port map (clk => clk , rst=> '0' , ena=> '1' , si=> res_xor , so => so_inutil , po => salida_aux , pi => inits , pl => rst);
-----------------------------------------------------------------


end Behavioral;
