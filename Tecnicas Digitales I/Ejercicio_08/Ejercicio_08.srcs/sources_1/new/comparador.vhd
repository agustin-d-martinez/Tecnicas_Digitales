library work;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity comparador is
Generic(N:integer := 4);
Port (  a       : in std_logic_vector(N-1 downto 0);
        b       : in std_logic_vector(N-1 downto 0);
        magCa2  : in std_logic ;
        aMayorQueB  : out std_logic ;
        aMenorQueB  : out std_logic ;
        aIgualB     : out std_logic);
end comparador;

architecture Behavioral of comparador is
--- Signals -----------------------------------------------------
signal salidaSignada: std_logic_vector (2 downto 0);
signal salidaNoSignada: std_logic_vector (2 downto 0);
signal salidaAux: std_logic_vector (2 downto 0);
-----------------------------------------------------------------

begin
salidaAux <= salidaSignada when (magCa2 = '1') else salidaNoSignada;
aMayorQueB <= salidaAux(0);
aMenorQueB <= salidaAux(1);
aIgualB <= salidaAux(2);

--- Componentes -------------------------------------------------
compSignado     :entity work.comparadorCa2
generic map (N => N)
PORT MAP ( a =>a,  b=>b, aMayorQueB =>salidaSignada(0), aMenorQueB =>salidaSignada(1), aIgualB =>salidaSignada(2));

compNoSignado     :entity work.comparadorMag
generic map (N => N)
PORT MAP ( a =>a,  b=>b, aMayorQueB =>salidaNoSignada(0), aMenorQueB =>salidaNoSignada(1), aIgualB =>salidaNoSignada(2));-----------------------------------------------------------------
-----------------------------------------------------------------

end Behavioral;
