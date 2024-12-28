library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity genSec2 is
Port ( clk     : in  std_logic;
       rst     : in  std_logic;
       entradas : in  std_logic_vector (1 downto 0);
       y: out std_logic_vector (2 downto 0));end genSec2;
    
architecture Behavioral of genSec2 is

type state_type is (A,B,C,D);
signal state: state_type;
signal nextState: state_type;

signal y_aux : std_logic_vector (2 downto 0) ;

begin

y <= y_aux;

----- LOGICA ESTADOS -----------------
estadoProc: process(clk)
begin
    if ( rising_edge (clk) ) then
        if ( rst = '1' ) then
            state <= A;
        else     
            state <= nextState;
        end if;
    end if;
end process;
------ LOGICA SALIDA -----------------
salidaProcess: process(state)
begin
    case (state) is
        when A =>
            y_aux <= "000";
        when B =>
            y_aux <= "000";
        when C =>
            y_aux <= "101";
        when D =>
            y_aux <= "111";
        when OTHERS =>      --Caso de seguridad
            y_aux <= "000";
     end case;
end process;
------ LOGICA TRANSICIONES ------------
transicionProcess: process(state , entradas)
begin
    nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
    case (state) is
        when A =>
            if ( entradas = "01" ) then
                nextState <= B;
            elsif ( entradas = "11" ) then 
                nextState <= C;
            end if;
        when B =>
            if ( entradas = "11" ) then
                nextState <= C;
            elsif ( entradas = "00" ) then 
                nextState <= A;
            end if;        
        when C =>
            nextState <= D;
        when D =>
            nextState <= A;
        when OTHERS =>      --Caso de seguridad
            nextState <= A;
        end case;
end process;
---------------------------------------
end Behavioral;
