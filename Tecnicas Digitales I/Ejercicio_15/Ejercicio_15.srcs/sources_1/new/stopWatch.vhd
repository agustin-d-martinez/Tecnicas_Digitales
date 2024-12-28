library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
library work;
--use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity stopWatch is
Generic (N: integer:=4);
Port(   clk:    in std_logic ;
        rst:    in std_logic ;
        start:  in std_logic ;
        stop:   in std_logic ;
        salida: out std_logic_vector (N-1 downto 0));
end stopWatch;

architecture Behavioral of stopWatch is
------- signals --------------------------------------
type state_type is (DET,INI,RESET);
signal state: state_type;
signal nextState: state_type;

signal salida_aux : std_logic_vector (N-1 downto 0) ;
signal ena: std_logic ;
signal rst_contador: std_logic ;
------------------------------------------------------
begin
salida <= salida_aux;

------- componentes ----------------------------------
contador: entity work.myCntBiDir
Generic map(N=>N)
Port map( clk=>clk , rst=>rst_contador , ena=>ena ,dir=>'0' , q=>salida_aux );
------------------------------------------------------

----- LOGICA ESTADOS -----------------
estadoProc: process(clk)
begin
    if ( rising_edge (clk) ) then
        if ( rst = '1' ) then
            state <= RESET;
            
        else     
            state <= nextState;
        end if;
    end if;
end process;
------ LOGICA SALIDA -----------------
salidaProcess: process(state)
begin
    case (state) is
        when DET =>
            ena <= '0';
            rst_contador <= '0';
        when INI =>
            ena <= '1';
            rst_contador <= '0';
        when RESET =>
            ena <= '0';
            rst_contador <= '1';
        when OTHERS =>      --Caso de seguridad
            ena <= '0';
            rst_contador <= '1';
     end case;
end process;
------ LOGICA TRANSICIONES ------------
transicionProcess: process(state , start, stop)
begin
    nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
    case (state) is
        when DET =>
            if ( stop = '1' ) then
                nextState <= RESET;
             elsif ( start = '1' ) then
                nextState <= INI;
            end if;
        when INI =>
            if ( stop = '1' ) then
                nextState <= DET;
            end if;        
        when RESET =>
            nextState <= DET;
        when OTHERS =>      --Caso de seguridad
            nextState <= DET;
        end case;
end process;
---------------------------------------

end Behavioral;
