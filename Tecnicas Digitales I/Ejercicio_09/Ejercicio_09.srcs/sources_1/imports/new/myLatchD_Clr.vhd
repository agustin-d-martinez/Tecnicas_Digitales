library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myLatchD_Clr is
Port (  ena:    in std_logic ;
        clr:    in std_logic ;
        d :     in std_logic ;
        q:      out std_logic);
end myLatchD_Clr;

architecture Behavioral of myLatchD_Clr is
begin

-----PROCESS LATCH-------------------------------------------
process (ena, d, clr)
begin
    if ( clr = '1' ) then
        q <= '0';
    elsif ( ena = '1' ) then
        q <= d;
    end if;
end process;
-------------------------------------------------------------


end Behavioral;
