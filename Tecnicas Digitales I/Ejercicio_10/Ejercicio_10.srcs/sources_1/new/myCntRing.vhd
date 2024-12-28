library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myCntRing is
generic (N: integer :=4 );
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    ena: in std_logic ;
    q: out std_logic_vector (N-1 downto 0));
end myCntRing;

architecture Behavioral of myCntRing is
signal q_aux: std_logic_vector (N-1 downto 0);
begin
q <= q_aux;

process ( clk )
begin
    if ( rising_edge(clk) ) then
        if ( rst = '1' ) then
            q_aux <= ('1',others => '0' );     --Reset sincronico
        elsif ( ena = '1' ) then   --Enable
            q_aux <= q_aux((N-1)-1 downto 0) & q_aux(N-1);
        end if;
    
    end if;
end process;
end Behavioral;
