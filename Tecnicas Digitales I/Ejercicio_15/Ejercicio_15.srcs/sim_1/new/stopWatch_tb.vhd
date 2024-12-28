library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity stopWatch_tb is
Generic (N: integer:= 4);
--  Port ( );
end stopWatch_tb;

architecture Behavioral of stopWatch_tb is
component stopWatch is
    Generic (N:integer := 4);
    Port(   clk:    in std_logic ;
            rst:    in std_logic ;
            start:  in std_logic ;
            stop:   in std_logic ;
            salida: out std_logic_vector (N-1 downto 0));    
    end component;

----- SIGNALS ---------------------------------------------
signal clk :    std_logic;
signal rst :    std_logic;
signal start :  std_logic := '0';
signal stop :   std_logic := '0';
signal salida : std_logic_vector (N-1 downto 0) ;
-----------------------------------------------------------
constant clk_period : time := 100 ns;

begin
------------- componentes ---------------------------------
uut: stopWatch 
    Generic map (N=>N)
    Port map ( clk=>clk, rst=>rst, start=>start , stop=>stop ,salida=>salida);
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
    stop <= '1'; wait for clk_period;       --Reseteo inicial del contador
    stop <= '0'; wait for clk_period; 
    
    start <= '1'; wait for 5* clk_period;   --Hago que cuente 5 (5 + 1 que tarda en transicionar)
    start <= '0';
    
    stop <= '1'; wait for clk_period;       --Lo detengo
    stop <= '0'; wait for clk_period;
    
    start <= '1'; wait for 2* clk_period;   --Hago que cuente 2
    start <= '0';
    
    stop <= '1'; wait for clk_period;       --Lo detengo
    stop <= '0'; wait for clk_period;
    if(salida = "0111") then report "todo ok";end if;
    wait;
end process;
-----------------------------------------------------------

end Behavioral;
