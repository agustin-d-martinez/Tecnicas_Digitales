library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity myCntBinarioSimple_tb is
Generic (N: integer := 4);
end myCntBinarioSimple_tb;

architecture Behavioral of myCntBinarioSimple_tb is
----- signals --------------------------------------
signal rst : std_logic;
signal ena : std_logic := '0';
signal q   : std_logic_vector (N - 1 downto 0);
----------------------------------------------------
signal clk : std_logic := '0';
constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: entity work.myCntBinarioSimple
    Generic map (N => N)
    Port map ( clk => clk,
               rst => rst,
               ena => ena,
               q   => q);

-- Clock process --
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 2*clk_period;
    rst <= '0';     wait;
end process;

-- Stimulus process --
stimProc :process
begin      
    wait until falling_edge (rst);
    wait for clk_period/2; 
    ena <= '1';
    wait;
end process;


end Behavioral;

