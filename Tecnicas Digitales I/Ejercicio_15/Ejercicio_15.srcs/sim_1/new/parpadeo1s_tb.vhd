library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity parpadeo1s_tb is
Generic (SYS_CLK:integer := 50);
--  Port ( );
end parpadeo1s_tb;

architecture Behavioral of parpadeo1s_tb is
----- SIGNALS ---------------------------------------------
signal clk : std_logic;
signal rst : std_logic;
signal salida : std_logic;
-----------------------------------------------------------
constant clk_period : time := 20 ms;

begin
------------- componentes ---------------------------------
uut: entity work.parpadeo1s 
    Generic map (SYS_CLK=>SYS_CLK)
    Port map ( clk => clk, rst => rst, salida => salida);
-----------------------------------------------------------

------------- procesos ------------------------------------
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 2 * clk_period;
    rst <= '0';     wait;
end process;
-----------------------------------------------------------

end Behavioral;
