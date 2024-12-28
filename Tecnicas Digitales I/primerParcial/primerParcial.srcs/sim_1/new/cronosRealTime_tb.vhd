library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

----- TESTBENCH CREADO FUERA DEL PARCIAL -------------------------
----- PARA LA PRUEBA DEL CRON?METRO A VALORES REALES -------------

entity cronosRealTime_tb is
Generic (SYS_FREC: integer := 1000;
		N: integer := 7;
		SEGxMIN: integer := 60);
end cronosRealTime_tb;

architecture Behavioral of cronosRealTime_tb is
	signal clk:  std_logic;
	signal rst:  std_logic;
	signal start:  std_logic := '0';
	signal stop:  std_logic := '0' ;
	signal minutos:  std_logic_vector (N-1 downto 0);
	signal segundos:  std_logic_vector (N-1 downto 0);
	constant clk_period : time := 1 ms;
	constant clk_segundo: time:= SYS_FREC * clk_period;

begin
------------- componentes ---------------------------------
uut: entity work.cronos
    Generic map (N=>N , SYS_FREC=>SYS_FREC , SEGxMIN=>SEGxMIN)
    Port map ( clk=>clk, rst=>rst, start=>start , stop=>stop ,segundos=>segundos , minutos=> minutos);
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
    rst <= '1';     wait for clk_period;
    rst <= '0';     wait;
end process;

funcionamiento: process
begin
    wait until falling_edge (rst);
    wait for clk_period/2;
    ---
    ---
    ---
    start <= '0';
    stop <= '1'; wait for clk_period;       --Reseteo inicial del contador
    stop <= '0'; wait for clk_period; 
    
    start <= '1'; 							--Hago que cuente infinitamente
    wait;
end process;
-----------------------------------------------------------

end Behavioral;
