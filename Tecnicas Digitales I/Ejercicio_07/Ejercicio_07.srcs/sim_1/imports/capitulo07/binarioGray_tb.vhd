library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity binarioGray_tb is
    generic (N: integer := 4);
--  Port ( );
end binarioGray_tb;

architecture Behavioral of binarioGray_tb is

component binarioGray is
   generic (N: integer := 4);
   Port ( binario : in STD_LOGIC_VECTOR (N - 1 downto 0);
          gray : out STD_LOGIC_VECTOR (N - 1 downto 0));
end component;

    signal gray : STD_LOGIC_VECTOR (N - 1 downto 0);   
    signal binario : STD_LOGIC_VECTOR (N - 1 downto 0);

begin

uut: binarioGray 
generic map (N => N)
PORT MAP (              
    binario => binario,
    gray => gray    
);

stim_proc: process
begin
		
	binario <= "0000";	wait for 100 ns; if (gray /= "0000") then report "Error 0" severity error; end if;
	binario <= "0001";	wait for 100 ns; if (gray /= "0001") then report "Error 1" severity error; end if;
	binario <= "0010";	wait for 100 ns; if (gray /= "0011") then report "Error 2" severity error; end if;
	binario <= "0011";	wait for 100 ns; if (gray /= "0010") then report "Error 3" severity error; end if;
		
	binario <= "0100";	wait for 100 ns; if (gray /= "0110") then report "Error 4" severity error; end if;
	binario <= "0101";	wait for 100 ns; if (gray /= "0111") then report "Error 5" severity error; end if;
	binario <= "0110";	wait for 100 ns; if (gray /= "0101") then report "Error 6" severity error; end if;
	binario <= "0111";	wait for 100 ns; if (gray /= "0100") then report "Error 7" severity error; end if;

	binario <= "1000";	wait for 100 ns; if (gray /= "1100") then report "Error 8" severity error; end if;
	binario <= "1001";	wait for 100 ns; if (gray /= "1101") then report "Error 9" severity error; end if;
	binario <= "1010";	wait for 100 ns; if (gray /= "1111") then report "Error 10" severity error; end if;
	binario <= "1011";	wait for 100 ns; if (gray /= "1110") then report "Error 11" severity error; end if;
		
    binario <= "1100";	wait for 100 ns; if (gray /= "1010") then report "Error 12" severity error; end if;
	binario <= "1101";	wait for 100 ns; if (gray /= "1011") then report "Error 13" severity error; end if;
	binario <= "1110";	wait for 100 ns; if (gray /= "1001") then report "Error 14" severity error; end if;
	binario <= "1111";	wait for 100 ns; if (gray /= "1000") then report "Error 15" severity error; end if;
    
    report "Llegue al final" severity note;
    
    wait;
end process;


end Behavioral;
