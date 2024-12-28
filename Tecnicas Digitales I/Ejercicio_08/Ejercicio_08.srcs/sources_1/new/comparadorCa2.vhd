library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparadorCa2 is
Generic(N:integer := 4);
Port (  a   : in std_logic_vector(N-1 downto 0);
        b   : in std_logic_vector(N-1 downto 0);
        aMayorQueB  : out std_logic ;
        aMenorQueB  : out std_logic ;
        aIgualB     : out std_logic);
end comparadorCa2;

architecture Behavioral of comparadorCa2 is
begin

aMayorQueB <=   '1' when (signed(a) > signed(b)) else        
                '0';                                               
                
aMenorQueB <=   '1' when (signed(a) < signed(b)) else
                '0';                

aIgualB <=      '1' when (signed(a) = signed(b)) else
                '0';

end Behavioral;