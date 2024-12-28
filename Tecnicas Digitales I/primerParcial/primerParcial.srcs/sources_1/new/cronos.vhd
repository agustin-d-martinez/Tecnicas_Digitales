library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity cronos is
Generic (	SYS_FREC: integer := 200000000;
 			N: integer := 6;
			SEGxMIN: integer := 60);		--Variable creada para probar mas facil. Indica los segundos en 1 minuto.
Port ( clk: in std_logic;
	rst: in std_logic;
	start: in std_logic:= '0';
	stop: in std_logic:= '0';
	minutos: out std_logic_vector (N-1 downto 0);
	segundos: out std_logic_vector (N-1 downto 0));
end cronos;

architecture Behavioral of cronos is
------ SIGNALS ----------------------------------------
signal s_minutos: std_logic_vector (N-1 downto 0);
signal s_segundos: std_logic_vector (N-1 downto 0);
signal start_f: std_logic;
signal stop_f: std_logic;

------- MAQUINA DE ESTADOS ----------------------------
type state_type is (DET,INI,RESET);
signal state: state_type;
signal nextState: state_type;

signal salida_aux : std_logic_vector (N-1 downto 0) ;
signal ena: std_logic ;
signal rst_contador: std_logic ;
-------------------------------------------------------
begin
	---------- COMPONENTES --------------------------------
	flanco_start: entity work.myEdgeDetector
	port map ( clk=>clk ,rst=>rst , d=>start , ascendente=>start_f , descendente=>open );
	flanco_stop: entity work.myEdgeDetector
	port map ( clk=>clk ,rst=>rst , d=>stop , ascendente=>stop_f , descendente=>open );
	contador: entity work.cntSegMin
	generic map (SYS_FREC=>SYS_FREC , N=>N , SEGxMIN=>SEGxMIN)			--Este contador es "custom" para el ejercicio
	port map ( clk=>clk , rst=>rst_contador , ena=>ena , seg=>s_segundos , min=>s_minutos );
	-------------------------------------------------------
	
	----- logica estados ---------------
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
	---- logica salida -----------------
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
	---- logica transiciones -----------
	transicionProcess: process(state , start_f, stop_f)
	begin
		nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
		case (state) is
			when DET =>
				if ( stop_f = '1' ) then
					nextState <= RESET;
				 elsif ( start_f = '1' ) then
					nextState <= INI;
				end if;
			when INI =>
				if ( stop_f = '1' ) then
					nextState <= DET;
				end if;        
			when RESET =>
				nextState <= DET;
			when OTHERS =>      --Caso de seguridad
				nextState <= DET;
			end case;
	end process;
	------------------------------------

	minutos <= s_minutos;
	segundos <= s_segundos;
end Behavioral;