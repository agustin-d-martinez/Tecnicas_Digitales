library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lifo_tb is
end lifo_tb;

architecture Behavioral of lifo_tb is

component lifo is
   Port ( clk : in std_logic;
          rst : in std_logic;          
          wr : in std_logic;
          dataWr : in std_logic_vector (7 downto 0);
          rd : in std_logic;                    
          dataRd : out std_logic_vector (7 downto 0));    
end component;

    signal clk : std_logic;
    signal rst : std_logic;          
    signal wr : std_logic;
    signal rd : std_logic;          
    signal dataWr : std_logic_vector (7 downto 0);
    signal dataRd : std_logic_vector (7 downto 0);

    constant clk_period : time := 10 ns;

begin

uut: lifo 
    port map (clk => clk,
              rst => rst,         
              wr => wr,
              dataWr => dataWr,          
              rd => rd,
              dataRd => dataRd);

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
    wr <= '0';  rd <= '0';  dataWr <= X"00";
    wait until falling_edge (rst); wait for 51 ns; wait until rising_edge (clk);
                         
    -- Escribo --
    wait until rising_edge (clk);   dataWr <= X"F0";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;  
    wait until rising_edge (clk);   dataWr <= X"F1";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;  
    wait until rising_edge (clk);   dataWr <= X"F2";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   dataWr <= X"F3";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   dataWr <= X"F4";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    
    -- Leo --
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;

    -- Escribo y leo --
    wait until rising_edge (clk);   dataWr <= X"A0";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   dataWr <= X"A1";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   dataWr <= X"B0";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   dataWr <= X"B1";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   dataWr <= X"B2";    wr <= '1';  wait until rising_edge (clk);   wr <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait until rising_edge (clk);   rd <= '1';  wait until rising_edge (clk);   rd <= '0';  wait for 50 ns;
    wait;    
end process;




end Behavioral;
