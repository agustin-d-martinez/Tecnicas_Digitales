library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity myCntJohnson is
generic (N: integer :=4 );
Port(
    clk: in std_logic ;
    rst: in std_logic ;
    ena: in std_logic ;
    q: out std_logic_vector (N-1 downto 0));
end myCntJohnson;

architecture Behavioral of myCntJohnson is
signal q_aux: std_logic_vector (N-1 downto 0);
begin
q <= q_aux;

process ( clk , rst )
begin
    if ( rst = '1' ) then
        q_aux <= (others => '0' );     --Reset sincronico
    elsif ( rising_edge(clk) ) then
        if ( ena = '1' ) then   --Enable
            q_aux <= q_aux((N-1)-1 downto 0) & not(q_aux(N-1));
        end if;
    
    end if;
end process;
end Behavioral;
