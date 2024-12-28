library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myCntBinarioSimple is
Generic (N:integer :=4);
Port (  clk:    in std_logic ;
        rst:    in std_logic ;
        ena:    in std_logic ;
        q:      out std_logic_vector (N-1 downto 0));
end myCntBinarioSimple;

architecture Behavioral of myCntBinarioSimple is
signal q_aux : unsigned (N-1 downto 0);
begin

q <= std_logic_vector ( q_aux );

process ( clk , rst )
begin
    if ( rising_edge( clk ) ) then
        if ( rst = '1' ) then
            q_aux <= to_unsigned(0,N);
        elsif ( ena = '1' ) then
            q_aux <= q_aux + 1;
        end if;
        
    end if;
end process;
end Behavioral;