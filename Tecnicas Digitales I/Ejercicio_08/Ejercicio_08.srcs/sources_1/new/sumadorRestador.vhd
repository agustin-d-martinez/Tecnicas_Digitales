library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sumadorRestador is
Generic(N:integer := 4);
Port (  a   : in std_logic_vector (N-1 downto 0);
        b   : in std_logic_vector (N-1 downto 0);
        s_r : in std_logic;
        ov  : out std_logic;
        resultado   : out std_logic_vector (N-1 downto 0));
end sumadorRestador;

architecture Behavioral of sumadorRestador is
signal suma: std_logic_vector (N-1 downto 0);
signal resta: std_logic_vector (N-1 downto 0);

signal ov_suma: std_logic ;
signal ov_resta: std_logic ;
begin
ov_suma <= ( not(suma(N-1)) and b(N-1) and a(N-1) ) or ( suma(N-1) and not(b(N-1)) and not(a(N-1)) );       --Overflow suma
ov_resta <=( a(N-1) and not (resta(N-1)) and not (b(N-1)) ) or ( not(a(N-1)) and b(N-1) and resta(N-1) );      --Overflow resta

ov <=   ov_suma when ( s_r = '1' ) else       
        ov_resta when ( s_r = '0' ) else
        '0';                             
        
suma  <= std_logic_vector (signed(a) + signed(b));
resta <= std_logic_vector (signed(a) - signed(b));

resultado <=    suma  when (s_r = '1') else
                resta when (s_r = '0') else
                (others =>'0');

end Behavioral;
