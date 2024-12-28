library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity saturador is
Port(   entrada :in std_logic_vector (16-1 downto 0);
        salida  : out std_logic_vector (8-1 downto 0));
end saturador;

architecture Behavioral of saturador is
constant max: std_logic_vector (8-1 downto 0) := "01111111";
constant min: std_logic_vector (8-1 downto 0) := "10000000";
begin

salida <=   max when (signed(entrada) > signed(max)) else
            min when (signed(entrada) < signed(min)) else
            entrada(8-1 downto 0);

end Behavioral;
