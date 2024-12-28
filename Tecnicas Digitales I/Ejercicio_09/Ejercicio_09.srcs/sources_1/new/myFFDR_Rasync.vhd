library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myFFDR_Rasync is
Port (  clk: in std_logic ;
        rst: in std_logic ;
        rstAsync: in std_logic ;
        d: in std_logic ;
        q: out std_logic);
end myFFDR_Rasync;

architecture Behavioral of myFFDR_Rasync is
begin

-----PROCESS FLIP FLOP---------------------------------------
process (clk , rstAsync)
begin
    if ( rstAsync = '1' ) then
        q <= '0';
    elsif ( rising_edge(clk) ) then
        if (rst = '1') then
            q <= '0';
        else
            q <= d;
        end if;
    end if;
end process;
-------------------------------------------------------------

end Behavioral;
