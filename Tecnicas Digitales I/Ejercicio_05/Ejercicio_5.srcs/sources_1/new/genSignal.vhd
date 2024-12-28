library IEEE;
library work;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.math_real.all;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity genSignal is
    Generic (ALTO: integer := 16;
             BAJO: integer := 8); 
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;           
           salida : out STD_LOGIC);
end genSignal;

architecture Behavioral of genSignal is
constant N_periodo: integer:= integer(ceil( log2(real(ALTO+BAJO)) ));
constant PERIODO: integer:= ALTO + BAJO;

signal q_suma: unsigned (N_periodo-1 downto 0) ;
signal salida_aux: std_logic ;

begin
	process ( clk )
	begin
		if ( rising_edge( clk ) ) then
			if ( rst = '1' ) then
				q_suma <= to_unsigned(0 , N_periodo);	--Reset forzado
				salida_aux <= '0';
			else 
				q_suma <= q_suma + 1;		--Implementaci?n del contador normal
				if ( q_suma = BAJO-1 ) then
					salida_aux <= '1';		--Termina Toff
				elsif ( q_suma = PERIODO-1 ) then
					salida_aux <= '0';		--Termina Ton
					q_suma <= to_unsigned(0 , N_periodo);	--Reseteo cuenta
				end if;
			end if;
			
		end if;
	end process;
	
	salida <= salida_aux;
	
end Behavioral;
