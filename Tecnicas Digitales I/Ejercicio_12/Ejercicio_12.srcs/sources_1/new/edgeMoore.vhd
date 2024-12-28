library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity edgeMoore is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           d : in STD_LOGIC;
           y : out STD_LOGIC);
end edgeMoore;

architecture Behavioral of edgeMoore is

type state_type is (A,B,C);
signal state: state_type;
signal nextState: state_type;

signal y_aux : std_logic ;

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
            y_aux <= '0';
        when B =>
            y_aux <= '1';
        when C =>
            y_aux <= '0';
        when OTHERS =>      --Caso de seguridad
            y_aux <= '0';
     end case;
end process;
------ LOGICA TRANSICIONES ------------
transicionProcess: process(state , d)
begin
    nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
    case (state) is
        when A =>
            if ( d = '1' ) then
                nextState <= B;
            end if;
        when B =>
            if ( d = '1' ) then
                nextState <= C;
            else
                nextState <= A; 
            end if;        
        when C =>
            if ( d = '0' ) then
                nextState <= A;
            end if;
        when OTHERS =>      --Caso de seguridad
            nextState <= A;
        end case;
end process;
---------------------------------------
end Behavioral;