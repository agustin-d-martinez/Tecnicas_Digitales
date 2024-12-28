library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myShiftReg is
generic (N: integer :=4 );
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    ena: in std_logic ;
    si: in std_logic ;
    so: out std_logic ;
    po: out std_logic_vector (N-1 downto 0);
    pi: in std_logic_vector (N-1 downto 0);
    pl: in std_logic);
end myShiftReg;

architecture Behavioral of myShiftReg is
signal po_aux: std_logic_vector (N-1 downto 0);

begin
so <= po_aux(N-1);    --Salida serie
po <= po_aux;       --Salida paralelo

process ( clk )
begin
    if ( rising_edge(clk) ) then
        if ( rst = '1' ) then       --Reset sincronico
            po_aux <= (others => '0' );     
        elsif ( ena = '1' ) then   --Enable
            if ( pl = '0' ) then
                po_aux <= po_aux(N-2 downto 0) & si;        --Shift normal
            else
                po_aux <= pi;       --Carga paralelo
            end if;
        end if;
    
    end if;
end process;
end Behavioral;
