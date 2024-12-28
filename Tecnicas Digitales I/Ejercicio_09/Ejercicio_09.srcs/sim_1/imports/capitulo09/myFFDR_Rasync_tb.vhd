library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myFFDR_Rasync_tb is

end myFFDR_Rasync_tb;

architecture Behavioral of myFFDR_Rasync_tb is

component myFFDR_Rasync is
Port ( clk : in std_logic;
        rst : in std_logic;
        rstAsync : in std_logic;
        d : in std_logic;
        q : out std_logic);
end component;

    signal rst : std_logic;
    signal rstAsync : std_logic;
    signal d : std_logic;
    signal q : std_logic;

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
begin

-- Instantiate the Unit Under Test (UUT) --
uut: myFFDR_Rasync 
    Port map ( clk => clk,
               rst => rst,
               rstAsync => rstAsync,
               d => d,
               q => q);


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
    rst <= '0';     wait for 200 ns;
    rst <= '1';     wait for 200 ns;
    rst <= '0';     wait;
end process;

-- Stimulus process --
stimProc :process
begin      
    d <= '0';
    rstAsync <= '0';
    wait until falling_edge (rst); 
    wait for 50 ns;
    d <= '1';
    wait for 50 ns;
    rstAsync <= '1';
    wait for 45 ns;
    rstAsync <= '0';
    wait;    
end process;


end Behavioral;
