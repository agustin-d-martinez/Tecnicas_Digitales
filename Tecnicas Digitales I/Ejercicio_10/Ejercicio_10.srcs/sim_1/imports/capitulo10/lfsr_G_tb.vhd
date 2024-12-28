library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity lfsr_G_tb is
    Generic (N : integer := 4);
end lfsr_G_tb;

architecture Behavioral of lfsr_G_tb is

component lfsr_G is
    Generic (N : integer := 8);
    Port ( clk     : in  std_logic;
           rst     : in  std_logic;
           inits    : in  std_logic_vector(N - 1 downto 0);
           taps    : in  std_logic_vector(N - 1 downto 0);
           salida  : out  std_logic_vector(N - 1 downto 0));
end component;

    signal salida  : std_logic_vector(N - 1 downto 0);

    -- Clk --
    signal rst : std_logic := '0';
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;
    
     -- Vector de resultado --
    type std_logic_vector_array is array (0 to 14) of std_logic_vector (N - 1 downto 0);
    constant resultVector : std_logic_vector_array := (X"F", X"D", X"9", X"1", X"2", X"4", X"8", X"3", X"6", X"C", X"B", X"5", X"A", X"7", X"E");
     
    
begin

uut: lfsr_G
    Generic map (N => N)
    Port map (clk => clk,
              rst => rst,
              inits => "1111",
              taps => "0010",
              salida => salida);

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

-- Test process --
testProc :process
begin  
    wait until falling_edge (rst);
     for i in resultVector'range loop
        wait until rising_edge(clk);
        if salida /= resultVector(i) then
            assert false report "Error" severity failure;            
        end if;
      end loop;
    report "Todo OK" severity note;
    wait;     
       
end process;

end Behavioral;
