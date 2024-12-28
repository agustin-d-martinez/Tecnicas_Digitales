library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library WORK;

entity FFT_N is
Generic (N:integer := 4);
Port(
    clk:    in std_logic ;
    rst:    in std_logic ;
    ena:    in std_logic ;
    t:      in std_logic_vector (N-1 downto 0);
    q:      out std_logic_vector (N-1 downto 0));
end FFT_N;

architecture Behavioral of FFT_N is
signal q_aux: std_logic_vector (N-1 downto 0);
begin
q <= q_aux;

Gen_FFT: for i in 0 to N-1 generate
begin
    FFT: entity work.FFT
    Port map ( clk => clk, rst => rst, t => t(i), q => q_aux(i) );
end generate;

end Behavioral;
