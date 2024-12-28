library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity grayBinario is
Generic (N:integer := 4);
Port (  gray : in std_logic_vector (N-1 downto 0);
        binario : out std_logic_vector (N-1 downto 0) );
end grayBinario;

architecture Behavioral of grayBinario is
-- Signals ---------------------------------------------------------------
signal binario_aux:  std_logic_vector (N-1 downto 0);
--------------------------------------------------------------------------

begin
binario <= binario_aux;             --El auxiliar es mi salida

binario_aux(N-1) <= gray(N-1);      --Primer valor distinto

conversion: for i in (N-1)-1 downto 0 generate
begin 
    binario_aux(i) <= binario_aux(i+1) xor gray(i);         --Para todos los demas, salida[I]=salida[I+1] XOR Entrada[I]
end generate;
--binario_aux(2) <= binario_aux(3) xor gray(2);
--binario_aux(1) <= binario_aux(2) xor gray(1);
--binario_aux(0) <= binario_aux(1) xor gray(0);
end Behavioral;
