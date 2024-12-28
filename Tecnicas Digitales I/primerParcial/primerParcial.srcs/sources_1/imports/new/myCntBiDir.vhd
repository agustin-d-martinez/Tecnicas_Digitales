library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myCntBiDir is
Port (  clk:    in std_logic ;
		ena:	in std_logic ;
        rst:    in std_logic ;
        dir:    in std_logic ;								--Dir = 0 suma. Dir = 1 resta
        q:      out std_logic_vector (2-1 downto 0));
end myCntBiDir;

architecture Behavioral of myCntBiDir is
signal q_aux : unsigned (2-1 downto 0);
begin
q <= std_logic_vector ( q_aux );

process ( clk )
begin
    if ( rising_edge( clk ) ) then
        if ( rst = '1' ) then
            q_aux <= (others => '0');
        elsif ( ena = '1') then
            if ( dir = '0' and q_aux < "11") then		--Suma y no se pasa de 3 (No da vueltas)
                q_aux <= q_aux + 1;		
            elsif (dir = '1' and q_aux > 0) then	--Resta y no se pasa de 0 (No da vueltas)
                q_aux <= q_aux - 1;		-- Resto
            end if;
        end if;
        
    end if;
end process;
end Behavioral;
