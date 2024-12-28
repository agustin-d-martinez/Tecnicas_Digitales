library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myCnt4b_tb is
--  Port ( );
end myCnt4b_tb;

architecture Behavioral of myCnt4b_tb is
    component myCnt4b is
        Port ( clk     : in  std_logic;
               rst     : in  std_logic;
               dir     : in  std_logic;
               y       : out std_logic_vector (3 downto 0));  
    end component;

    signal rst  : std_logic;
    signal dir  : std_logic;
    signal y    : std_logic_vector (3 downto 0);

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin
uut: myCnt4b    
    Port map ( clk => clk,
               rst => rst,
               dir => dir,
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
    dir <= '0';
    wait until falling_edge (rst);
    wait for 50 ns; 
    wait until rising_edge (clk);
    dir <= '1';
    wait until rising_edge (clk);
    wait for 50 ns;
    dir <= '0';
    wait;    
end process;

end Behavioral;
