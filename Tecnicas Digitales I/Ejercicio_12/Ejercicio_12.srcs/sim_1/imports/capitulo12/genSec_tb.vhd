library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity genSec_tb is
--  Port ( );
end genSec_tb;

architecture Behavioral of genSec_tb is

    component genSec is
        Port ( clk     : in  std_logic;
               rst     : in  std_logic;
               ena : in  std_logic;
               y: out std_logic_vector (3 downto 0));
    end component;
    
    signal rst  : std_logic;
    signal ena  : std_logic;
    signal y    : std_logic_vector (3 downto 0);
    
    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin
uut: genSec    
    Port map ( clk => clk,
               rst => rst,
               ena => ena,
               y  => y);

-- Clock process --
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 50 ns;
    rst <= '0';     wait;
end process;

-- Stimulus process --
stimProc :process
begin      
    ena <= '0';
    wait until falling_edge (rst); 
    wait until rising_edge (clk);
    ena <= '1';
    wait for 50 ns;
    wait until rising_edge (clk);
    ena <= '0';
    wait for 50 ns;
    wait until rising_edge (clk);    
    ena <= '1';
    wait for 100 ns;
    wait until rising_edge (clk);
    ena <= '0';
    wait;    
end process;


end Behavioral;
