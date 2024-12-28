library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

entity myEdgeCnt_tb is
Generic(N:integer:=4);
--  Port ( );
end myEdgeCnt_tb;

architecture Behavioral of myEdgeCnt_tb is
signal clk: std_logic ;
signal rst: std_logic ;
signal d: std_logic := '0';
signal q: std_logic_vector (N-1 downto 0) ;

constant clk_period : time := 100 ns;

begin
----- COMPONENTS ---------------------------------------------
uut: entity work.myEdgeCnt
Generic map(N=>N)
Port map( clk=>clk , rst=>rst , d=>d , q=>q );
--------------------------------------------------------------

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

funcionamiento :process
begin
    wait until falling_edge (rst);
    wait for clk_period/2;
    
    d <= '0';     wait for clk_period;
    d <= '1';     wait for clk_period;--1
    d <= '0';     wait for clk_period;
    d <= '1';     wait for clk_period;--2
    d <= '0';     wait for clk_period;
    d <= '1';     wait for clk_period;--3
    wait;
end process;
-----------------------------------------------------------
end Behavioral;
