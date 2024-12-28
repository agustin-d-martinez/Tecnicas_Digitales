library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myFFD is
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    ena: in std_logic ;
    d: in std_logic ;
    q: out std_logic;
    init: in std_logic);
end myFFD;
architecture Behavioral of myFFD is
begin

process (clk)
begin
    if ( rst = '1' ) then
        q <= init; 
    elsif ( rising_edge (clk) ) then
        if ( ena = '1') then
            q <= d;
        end if;
    end if;

end process;
end Behavioral;
