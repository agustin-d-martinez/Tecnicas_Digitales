library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edgeMealy_tb is
--  Port ( );
end edgeMealy_tb;

architecture Behavioral of edgeMealy_tb is

component edgeMealy is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           y : out STD_LOGIC);
end component;

    signal rst  : std_logic;
    signal d    : std_logic;
    signal y    : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin
uut: edgeMealy    
    Port map ( clk => clk,
               rst => rst,
               d => d,
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
    d <= '0';
    wait until falling_edge (rst); 
    wait until rising_edge (clk);
    d <= '1';
    wait until rising_edge (clk);
    d <= '0';
    wait;    
end process;


end Behavioral;
