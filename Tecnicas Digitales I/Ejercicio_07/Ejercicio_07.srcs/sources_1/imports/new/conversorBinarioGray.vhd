library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity conversorBinarioGray is
Generic(N:integer := 8);
Port (  entrada : in std_logic_vector (N-1 downto 0);
        salida  : out std_logic_vector (N-1 downto 0);
        sel     : in std_logic );
end conversorBinarioGray;

architecture Behavioral of conversorBinarioGray is
-- Signals ---------------------------------------------------------------
signal binario: std_logic_vector (N-1 downto 0);
signal gray: std_logic_vector (N-1 downto 0);
--------------------------------------------------------------------------

begin

with sel select
salida <=   binario         when '0',
            gray            when '1',
            (others=>'0')   when others;
            
-- Componentes a usar ---------------------------------------------------------------
conversor_gray: entity work.binarioGray
generic map (N => N)
port map (binario => entrada , gray => gray);

conversor_binario: entity work.grayBinario
generic map (N => N)
port map (gray => entrada , binario => binario);
-------------------------------------------------------------------------------------

end Behavioral;
