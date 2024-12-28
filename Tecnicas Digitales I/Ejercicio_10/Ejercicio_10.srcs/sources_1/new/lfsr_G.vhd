library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library Work;
--use IEEE.NUMERIC_STD.ALL;

entity lfsr_G is
generic (N: integer :=4 );
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    inits: in std_logic_vector (N-1 downto 0);
    taps: in std_logic_vector (N-1 downto 0);
    salida: out std_logic_vector (N-1 downto 0));
end lfsr_G;

architecture Behavioral of lfsr_G is
signal q: std_logic_vector (N-1 downto 0);
signal valores : std_logic_vector (N-1 downto 0);

begin
--tab = 0010
salida <= q;

valores(0) <=  q(N-1);
genVal: for i in 1 to N-1 generate
begin
    valores(i) <=(q(N-1)and taps(i)) xor q(i-1);      --Genero la entrada a cada uno de los Flip flop
end generate;

genComponentes: for i in 0 to N-1 generate
begin           --Creo los N flip flops que se van a utilizar
--- Componentes -------------------------------------------------
shiftReg: entity work.myFFD
Port map ( clk => clk , rst => rst, ena => '1', d => valores(i),  q => q(i), init => inits(i) );
-----------------------------------------------------------------
end generate;

end Behavioral;
