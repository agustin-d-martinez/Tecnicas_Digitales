library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity sat_N_IN_8_tb is

Generic (N_IN: integer := 8;
         N_OUT: integer := 4); 
         
end sat_N_IN_8_tb;

architecture Behavioral of sat_N_IN_8_tb is
    component sat is
        Generic (N_IN: integer := N_IN;
                 N_OUT: integer :=N_OUT); 
        Port ( entrada : in std_logic_vector (N_IN - 1 downto 0);
               salida : out std_logic_vector (N_OUT - 1 downto 0));
    end component;

    signal entrada : std_logic_vector (N_IN - 1 downto 0);
    signal salida : std_logic_vector (N_OUT - 1 downto 0);
    
begin

uut: sat Generic map (N_IN => N_IN,
                      N_OUT => N_OUT) 
        Port map ( entrada => entrada,
                   salida => salida);

process
begin    
    -- Satura --
    entrada <= std_logic_vector(to_signed(-128, entrada'length)); wait for 100 ns; 		
    entrada <= std_logic_vector(to_signed(-127, entrada'length)); wait for 100 ns;       
    entrada <= std_logic_vector(to_signed(-87, entrada'length)); wait for 100 ns;
    entrada <= std_logic_vector(to_signed(-9, entrada'length)); wait for 100 ns;
    
    -- No satura --
    entrada <= std_logic_vector(to_signed(-8, entrada'length)); wait for 100 ns;
    entrada <= std_logic_vector(to_signed(-7, entrada'length)); wait for 100 ns;
    entrada <= std_logic_vector(to_signed(-1, entrada'length)); wait for 100 ns;   
    entrada <= std_logic_vector(to_signed(0, entrada'length)); wait for 100 ns;    
    entrada <= std_logic_vector(to_signed(1, entrada'length)); wait for 100 ns;    
    entrada <= std_logic_vector(to_signed(2, entrada'length)); wait for 100 ns;    
    entrada <= std_logic_vector(to_signed(6, entrada'length)); wait for 100 ns;
    entrada <= std_logic_vector(to_signed(7, entrada'length)); wait for 100 ns;
    
    -- Satura --
    entrada <= std_logic_vector(to_signed(8, entrada'length)); wait for 100 ns;
    entrada <= std_logic_vector(to_signed(55, entrada'length)); wait for 100 ns;    
    entrada <= std_logic_vector(to_signed(126, entrada'length)); wait for 100 ns;
    entrada <= std_logic_vector(to_signed(127, entrada'length)); wait for 100 ns;
    wait;
end process;

end Behavioral;
