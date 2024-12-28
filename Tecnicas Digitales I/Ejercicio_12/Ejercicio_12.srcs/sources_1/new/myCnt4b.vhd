library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity myCnt4b is
Port ( clk     : in  std_logic;
       rst     : in  std_logic;
       dir     : in  std_logic;
       y       : out std_logic_vector (3 downto 0));
end myCnt4b;

architecture Behavioral of myCnt4b is
---- signals estados ------------------
type state_type is (A,B,C,D);
signal state: state_type;
signal nextState: state_type;
---------------------------------------
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
salidaProcess: process(state, dir )
begin
    case (state) is
        when A =>
            if ( dir = '1' ) then
                y_aux <= "0010";
            else
                y_aux <= "1000";
            end if;
        when B =>
            if ( dir = '1' ) then
                y_aux <= "0100";
            else
                y_aux <= "0001";
            end if;
        when C =>
            if ( dir = '1' ) then
                y_aux <= "1000";
            else
                y_aux <= "0010";
            end if;
        when D =>
            if ( dir = '1' ) then
                y_aux <= "0001";
            else
                y_aux <= "0100";
            end if;
        when OTHERS =>      --Caso de seguridad
            y_aux <= "0000";
        end case;
end process;
------ LOGICA TRANSICIONES ------------
transicionProcess: process(state , dir)
begin
    nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
    case (state) is
        when A =>
            if ( dir = '1' ) then
                nextState <= B;
            else 
                nextState <= D;
            end if;
        when B =>
            if ( dir = '1' ) then
                nextState <= C;
            else 
                nextState <= A;
            end if;
        when C =>
            if ( dir = '1' ) then
                nextState <= D;
            else 
                nextState <= B;
            end if;
        when D =>
            if ( dir = '1' ) then
                nextState <= A;
            else 
                nextState <= C;
            end if;
        when OTHERS =>      --Caso de seguridad
            nextState <= A;        
        end case;
end process;
---------------------------------------
end Behavioral;
