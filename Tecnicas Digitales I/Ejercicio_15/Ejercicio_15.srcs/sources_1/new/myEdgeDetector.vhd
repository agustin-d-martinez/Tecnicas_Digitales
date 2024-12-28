library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity myEdgeDetector is
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    d: in std_logic ;
    ascendente: out std_logic ;
    descendente: out std_logic);
end myEdgeDetector;

architecture Behavioral of myEdgeDetector is
signal D_actual : std_logic ;
signal D_anterior : std_logic ;
begin

ascendente <= D_actual and not(D_Anterior);
descendente <= not(D_actual) and D_Anterior;


------FLIP-FLOP 1----------------------------------------
process ( clk , rst )
begin
    if ( rst = '1' ) then
        D_Actual <= '0';
    elsif ( rising_edge(clk) ) then
        D_actual <= d;
    end if;
end process;
---------------------------------------------------------

-----FLIP-FLOP 2-----------------------------------------
process ( clk , rst )
begin
    if ( rst = '1' ) then
        D_anterior <= '0';
    elsif ( rising_edge(clk) ) then
        D_anterior <= D_actual;
    end if;
end process;
---------------------------------------------------------

end Behavioral;

