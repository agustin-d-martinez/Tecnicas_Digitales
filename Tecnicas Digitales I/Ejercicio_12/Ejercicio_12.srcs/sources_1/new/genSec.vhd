library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity genSec is
Port ( clk     : in  std_logic;
        rst     : in  std_logic;
        ena : in  std_logic;
        y: out std_logic_vector (3 downto 0));
end genSec;

architecture Behavioral of genSec is

type state_type is (A,B,C,D);
signal state: state_type;
signal nextState: state_type;

signal y_aux : std_logic_vector (3 downto 0) ;

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
            y_aux <= "0000";
        when B =>
            y_aux <= "0001";
        when C =>
            y_aux <= "1100";
        when D =>
            y_aux <= "0111";
        when others =>
            y_aux <= "0000";
     end case;
end process;
------ LOGICA TRANSICIONES ------------
transicionProcess: process(state , ena)
begin
    nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
    case (state) is
        when A =>
            if ( ena = '1' ) then
                nextState <= B;
            end if;
        when B =>
            if ( ena = '1' ) then
                nextState <= C;
            end if;        
        when C =>
            if ( ena = '1' ) then
                nextState <= D;
            end if;
        when D =>
            if ( ena = '1' ) then
                nextState <= A;
            end if;
        when others =>
            nextState <= A;
        end case;
end process;
---------------------------------------
end Behavioral;
