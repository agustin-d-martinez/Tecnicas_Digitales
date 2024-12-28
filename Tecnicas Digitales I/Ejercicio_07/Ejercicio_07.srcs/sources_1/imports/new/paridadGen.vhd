
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity paridadGen is
Generic (N:integer := 4 );
Port (  a   : in std_logic_vector(N-1 downto 0);
        sel : in std_logic;
        p   : out std_logic );
end paridadGen;

architecture Behavioral of paridadGen is
-- Signals ---------------------------------------------------------------
signal paridad: std_logic; 
--------------------------------------------------------------------------
begin
paridad <= xor_reduce(a);
p  <= paridad xor sel;

end Behavioral;
