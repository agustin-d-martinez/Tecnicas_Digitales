library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_misc.all;

entity myAndN is
Generic (N:integer := 4);
Port(
    a:  in std_logic_vector (N-1 downto 0) ;
    y:  out std_logic);
end myAndN;

architecture Behavioral of myAndN is
begin
y <= and_reduce (a);

end Behavioral;
