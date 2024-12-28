library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myFFDREnaClr is
Port (  clk: in std_logic ;
        rst: in std_logic ;
        ena: in std_logic ;
        clr: in std_logic ;
        d: in std_logic ;
        q: out std_logic);
end myFFDREnaClr;

architecture Behavioral of myFFDREnaClr is

begin
-----PROCESS FLIP FLOP---------------------------------------
process (clk , clr)
begin
    if ( clr = '1' ) then
        q <= '0';
    elsif ( rising_edge(clk) ) then
        if (rst = '1') then
            q <= '0';
        elsif ( ena = '1' ) then
            q <= d;
        end if;
    end if;
end process;
-------------------------------------------------------------

end Behavioral;
