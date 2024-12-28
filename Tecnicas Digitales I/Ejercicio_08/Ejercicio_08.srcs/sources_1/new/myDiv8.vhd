library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myDiv8 is
Port (  entrada : in std_logic_vector (8-1 downto 0);
        div     : in  std_logic_vector (1 downto 0);
        salida  : out  std_logic_vector (8-1 downto 0));
end myDiv8;

architecture Behavioral of myDiv8 is
signal signo: std_logic;
begin
signo <= entrada( 8-1 );
with div select                                                                                  
salida <=   entrada when ( "00" ),
            signo & entrada( 8-1 downto 1 ) when ( "01" ),
            signo & signo & entrada( 8-1 downto 2 ) when ( "10" ),
            signo & signo & signo & entrada( 8-1 downto 3 ) when ( "11" ),
            (others => '0') when others;
end Behavioral;    
--sla,sll,sra,srl ===>      [bit_vector] <= [bit_vector] sra [integrer]
--                          salida <= to_stdlogicvector( to_bitvector( A ) sra TO_INTEGER(unsigned( B )) );