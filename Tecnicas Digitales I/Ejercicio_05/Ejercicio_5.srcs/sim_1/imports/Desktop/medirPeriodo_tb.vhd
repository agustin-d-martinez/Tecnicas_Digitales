library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity medirPeriodo_tb is
    Generic (N: integer := 16);
end medirPeriodo_tb;

architecture Behavioral of medirPeriodo_tb is

component medirPeriodo is
    Generic (N: integer := 4);
    Port ( clk : in std_logic;
           rst : in std_logic;
           entrada : in std_logic;
           periodo : out std_logic_vector (N-1 downto 0));
end component;

    signal rst : std_logic;
    signal entrada : std_logic;
    signal periodo : std_logic_vector (N-1 downto 0);

    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin

uut: medirPeriodo     
    Generic map (N => N)
    Port map ( clk => clk,
               rst => rst,
               entrada => entrada,
               periodo => periodo);

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

stimProc :process
begin  
    entrada <= '0';
    wait until falling_edge (rst);
    wait for 50 ns;
    wait until rising_edge (clk);  entrada <= '1'; wait for 100 ns;         
    wait until rising_edge (clk);  entrada <= '0'; wait for 100 ns;
    wait until rising_edge (clk);  entrada <= '1'; wait for 200 ns;
    wait until rising_edge (clk);  entrada <= '0'; wait for 200 ns;
    wait until rising_edge (clk);  entrada <= '1'; wait for 200 ns;
    wait until rising_edge (clk);  entrada <= '0'; wait for 600 ns;
    wait until rising_edge (clk);  entrada <= '1'; wait for 600 ns;
    wait until rising_edge (clk);  entrada <= '0'; wait for 600 ns;
    wait until rising_edge (clk);  entrada <= '1'; wait for 600 ns;
    wait;
end process;


end Behavioral;
