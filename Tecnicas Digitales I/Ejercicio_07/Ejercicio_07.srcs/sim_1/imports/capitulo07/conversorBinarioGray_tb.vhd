library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conversorBinarioGray_tb is
    generic (N: integer := 4);
--  Port ( );
end conversorBinarioGray_tb;

architecture Behavioral of conversorBinarioGray_tb is

component conversorBinarioGray is
    generic (N: integer := 4);
    Port ( entrada : in STD_LOGIC_VECTOR (N - 1 downto 0);
           salida : out STD_LOGIC_VECTOR (N - 1 downto 0);
           sel : in STD_LOGIC);
end component;

    signal entrada : STD_LOGIC_VECTOR (N - 1 downto 0);   
    signal salida : STD_LOGIC_VECTOR (N - 1 downto 0);
    signal sel : STD_LOGIC := '0';
begin

uut: conversorBinarioGray 
generic map (N => N)
PORT MAP (              
    entrada => entrada,
    salida => salida,
    sel => sel
);

stim_proc: process
begin
		
	sel <= '0';
	report "sel es 0" severity note;
		
	entrada <= "0000";	wait for 100 ns; if (salida /= "0000") then report "Error 0" severity error; end if;
	entrada <= "0001";	wait for 100 ns; if (salida /= "0001") then report "Error 1" severity error; end if;
	entrada <= "0010";	wait for 100 ns; if (salida /= "0011") then report "Error 2" severity error; end if;
	entrada <= "0011";	wait for 100 ns; if (salida /= "0010") then report "Error 3" severity error; end if;
		
	entrada <= "0100";	wait for 100 ns; if (salida /= "0111") then report "Error 4" severity error; end if;
	entrada <= "0101";	wait for 100 ns; if (salida /= "0110") then report "Error 5" severity error; end if;
	entrada <= "0110";	wait for 100 ns; if (salida /= "0100") then report "Error 6" severity error; end if;
	entrada <= "0111";	wait for 100 ns; if (salida /= "0101") then report "Error 7" severity error; end if;

	entrada <= "1000";	wait for 100 ns; if (salida /= "1111") then report "Error 8" severity error; end if;
	entrada <= "1001";	wait for 100 ns; if (salida /= "1110") then report "Error 9" severity error; end if;
	entrada <= "1010";	wait for 100 ns; if (salida /= "1100") then report "Error 10" severity error; end if;
	entrada <= "1011";	wait for 100 ns; if (salida /= "1101") then report "Error 11" severity error; end if;
		
    entrada <= "1100";	wait for 100 ns; if (salida /= "1000") then report "Error 12" severity error; end if;
	entrada <= "1101";	wait for 100 ns; if (salida /= "1001") then report "Error 13" severity error; end if;
	entrada <= "1110";	wait for 100 ns; if (salida /= "1011") then report "Error 14" severity error; end if;
	entrada <= "1111";	wait for 100 ns; if (salida /= "1010") then report "Error 15" severity error; end if;
    
    
    sel <= '1';
    report "sel es 1" severity note;
    
    entrada <= "0000";	wait for 100 ns; if (salida /= "0000") then report "Error 0" severity error; end if;
	entrada <= "0001";	wait for 100 ns; if (salida /= "0001") then report "Error 1" severity error; end if;
	entrada <= "0010";	wait for 100 ns; if (salida /= "0011") then report "Error 2" severity error; end if;
	entrada <= "0011";	wait for 100 ns; if (salida /= "0010") then report "Error 3" severity error; end if;
		
	entrada <= "0100";	wait for 100 ns; if (salida /= "0110") then report "Error 4" severity error; end if;
	entrada <= "0101";	wait for 100 ns; if (salida /= "0111") then report "Error 5" severity error; end if;
	entrada <= "0110";	wait for 100 ns; if (salida /= "0101") then report "Error 6" severity error; end if;
	entrada <= "0111";	wait for 100 ns; if (salida /= "0100") then report "Error 7" severity error; end if;

	entrada <= "1000";	wait for 100 ns; if (salida /= "1100") then report "Error 8" severity error; end if;
	entrada <= "1001";	wait for 100 ns; if (salida /= "1101") then report "Error 9" severity error; end if;
	entrada <= "1010";	wait for 100 ns; if (salida /= "1111") then report "Error 10" severity error; end if;
	entrada <= "1011";	wait for 100 ns; if (salida /= "1110") then report "Error 11" severity error; end if;
		
    entrada <= "1100";	wait for 100 ns; if (salida /= "1010") then report "Error 12" severity error; end if;
	entrada <= "1101";	wait for 100 ns; if (salida /= "1011") then report "Error 13" severity error; end if;
	entrada <= "1110";	wait for 100 ns; if (salida /= "1001") then report "Error 14" severity error; end if;
	entrada <= "1111";	wait for 100 ns; if (salida /= "1000") then report "Error 15" severity error; end if;
    
    report "Llegue al final" severity note;
    
    wait;
end process;


end Behavioral;
