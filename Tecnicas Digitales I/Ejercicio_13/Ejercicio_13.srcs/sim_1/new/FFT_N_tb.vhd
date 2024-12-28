library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFT_N_tb is
Generic (N:integer := 4);
--  Port ( );
end FFT_N_tb;

architecture Behavioral of FFT_N_tb is
COMPONENT FFT_N is
    Generic (N:integer := 4);
    Port(
    clk:    in std_logic ;
    rst:    in std_logic ;
    ena:    in std_logic ;
    t:      in std_logic_vector (N-1 downto 0) ;
    q:      out std_logic_vector (N-1 downto 0));
END COMPONENT;
--signals----------------------------------------------------
    signal rst : std_logic; 
    signal ena : std_logic; 
    signal t : STD_LOGIC_VECTOR (N-1 downto 0) := "0000"; 
    signal q : STD_LOGIC_VECTOR (N-1 downto 0);
    signal clk : std_logic := '0'; 
-------------------------------------------------------------   
constant clk_period : time := 10 ns;

begin
uut: FFT_N PORT MAP (
    clk => clk,          
    rst => rst,
    ena => ena,
    t=> t,
    q=> q );

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

-- Ena process --
enaProc :process
begin  
    ena <= '1';
    wait until falling_edge (rst);
    wait until rising_edge (clk);
    wait for 10 ns;  
    
    t <= "0011"; wait for 7*clk_period;     --DEJO 2 primeros FFT normales, 2 FFT negados. 7 ciclos de clock
    t <= "1100"; wait for 7*clk_period;     
    
    if (q(0) /= '1') then report "error en el primer FF" severity warning; end if;  --Verifico los 2 primeros
    if (q(1) /= '1') then report "error en el primer FF" severity warning; end if;  -- que deje en modo normal
    t <= "1010"; wait for 7*clk_period;
    t <= "0101"; wait for 7*clk_period;   
    t <= "0000"; 
    wait;
end process;



end Behavioral;
