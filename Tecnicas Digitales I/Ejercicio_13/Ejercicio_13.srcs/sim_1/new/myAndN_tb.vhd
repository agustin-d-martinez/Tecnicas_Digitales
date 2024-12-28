library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity myAndN_tb is
Generic (N:integer := 4);
--  Port ( );
end myAndN_tb;

architecture Behavioral of myAndN_tb is
COMPONENT myAndN is
    Generic (N:integer := 4);
    Port ( a : in STD_LOGIC_VECTOR (N-1 downto 0);
           y : out STD_LOGIC);
END COMPONENT; 

--signals----------------------------------------------------
   signal a : STD_LOGIC_VECTOR (N-1 downto 0) := "0000";
   signal y : std_logic; 
-------------------------------------------------------------   
begin
uut: myAndN PORT MAP (
    a => a,          
    y => y
    );

stim_proc: process
begin
	a <= "0000";	wait for 100 ns;  if (y /= '0') then report "ERROR 0" severity error; end if;
	a <= "0001";	wait for 100 ns;  if (y /= '0') then report "ERROR 1" severity error; end if;
	a <= "0010";	wait for 100 ns;  if (y /= '0') then report "ERROR 2" severity error; end if;
	a <= "0011";	wait for 100 ns;  if (y /= '0') then report "ERROR 3" severity error; end if;
	a <= "1100";	wait for 100 ns;  if (y /= '0') then report "ERROR 12" severity error; end if;
	a <= "1010";	wait for 100 ns;  if (y /= '0') then report "ERROR 10" severity error; end if;
	a <= "0101";	wait for 100 ns;  if (y /= '0') then report "ERROR 5" severity error; end if;
	a <= "1111";	wait for 100 ns;  if (y /= '1') then report "ERROR 16" severity error; end if;

    report "TODO OK" severity NOTE;
    wait;
end process;

end Behavioral;
