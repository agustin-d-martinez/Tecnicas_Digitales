library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity binarioGray is
Generic (N:integer := 4);
Port (  binario : in std_logic_vector (N-1 downto 0);
        gray    : out std_logic_vector(N-1 downto 0));
end binarioGray;

architecture Behavioral of binarioGray is
begin
gray(N-1) <= binario(N-1);

conversion: for i in (N-1)-1 DOWNTO 0 generate
begin
gray(i) <= binario(i+1) xor binario(i); 
end generate;

end Behavioral;
