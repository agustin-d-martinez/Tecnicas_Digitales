library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity Contador_Unos is
Port (  a:	in std_logic_vector (5-1 downto 0);	--Se puede resolver metiendo FULLADDERS en cascada entre cada pin
        res :		out std_logic_vector (3-1 downto 0));
end Contador_Unos;

architecture Behavioral of Contador_Unos is
begin
	
end Behavioral;
