library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top is
    Generic (N : integer := 1024);
    Port ( clk     : in STD_LOGIC;
           rst     : in STD_LOGIC;           
           salida  : out STD_LOGIC);
end top;

architecture Behavioral of top is
component lfsr_F is
    Generic (N : integer := 4);
    Port ( clk     : in  std_logic;
           rst     : in  std_logic;
           inits    : in  std_logic_vector(N - 1 downto 0);
           taps    : in  std_logic_vector(N - 1 downto 0);
           salida  : out  std_logic_vector(N - 1 downto 0));
end component;
    signal salida_s  : std_logic_vector(N - 1 downto 0);    
    constant MAX: std_logic_vector(N - 1 downto 0) := (others => '1');
begin

LFSR: lfsr_F 
      Generic map(N => N)
      Port map ( clk => clk,
                rst => rst,
                inits => MAX,
                taps => MAX,
                salida => salida_s);

salida <= salida_s(N-1);

end Behavioral;
