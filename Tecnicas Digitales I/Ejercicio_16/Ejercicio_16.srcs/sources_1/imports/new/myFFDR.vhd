library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myFFDR is
Port (  clk: in std_logic ;
        rst: in std_logic ;
        ena: in std_logic ;
        d: in std_logic ;
        q: out std_logic);
end myFFDR;

architecture Behavioral of myFFDR is
begin

-----PROCESS FLIP FLOP---------------------------------------
process (clk)
begin
    if ( rising_edge(clk) ) then
        if (rst = '1') then
            q <= '0';
        elsif (ena = '1') then
            q <= d;
        end if;
    end if;

end process;
-------------------------------------------------------------

end Behavioral;
