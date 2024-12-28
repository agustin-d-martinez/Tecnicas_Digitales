library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity myMod_tb is
    Generic (N: integer := 8);
end myMod_tb;

architecture Behavioral of myMod_tb is
component myMod is
    Generic (N: integer := 8);
    Port ( entrada : in STD_LOGIC_VECTOR (N - 1 downto 0);
           salida : out STD_LOGIC_VECTOR (((2 * N) - 1) downto 0));
end component;

    signal entrada : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal salida : STD_LOGIC_VECTOR (((2 * N) - 1) downto 0);

begin


uut: myMod
    Generic map (N => N)
    Port map ( entrada => entrada,
               salida => salida);

resetProc :process
begin          
    entrada <= X"80";     wait for 20 ns;
    entrada <= X"CC";     wait for 20 ns;
    entrada <= X"FF";     wait for 20 ns;
    entrada <= X"00";     wait for 20 ns;
    entrada <= X"01";     wait for 20 ns;
    entrada <= X"55";     wait for 20 ns;
    entrada <= X"7F";     wait for 20 ns;    
    wait;
end process;


end Behavioral;
