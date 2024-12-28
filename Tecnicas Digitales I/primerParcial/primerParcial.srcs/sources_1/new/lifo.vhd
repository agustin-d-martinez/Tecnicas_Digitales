library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
--use work.BlockRam0;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity lifo is
Port ( 	clk : in std_logic;
		rst : in std_logic;
		wr : in std_logic;
		dataWr : in std_logic_vector (7 downto 0);
		rd : in std_logic;
		dataRd : out std_logic_vector (7 downto 0));
end lifo;
architecture Behavioral of lifo is

COMPONENT BlockRam0
	PORT (
    	clka : IN STD_LOGIC;
    	wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    	addra : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    	dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    	douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
END COMPONENT;

----- signals --------------------------------------------
signal s_wea: STD_LOGIC_VECTOR(0 DOWNTO 0);
signal salida_cont: STD_LOGIC_VECTOR(1 DOWNTO 0);
signal s_douta: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal s_ena: std_logic ;
signal s_dir: std_logic ;

----- estados ME ----------------------------------------
type state_type is (RESET, EXCP , DET , SUMO , WRITE , READ );
signal state: state_type;
signal nextState: state_type;

----------------------------------------------------------
begin
	------ componentes -----------------------------------
	memoria: BlockRam0
	port map (	clka => clk,
    		wea => s_wea,
   			addra => salida_cont,
    		dina => dataWr,
    		douta => s_douta);

	contador: entity work.myCntBiDir			--Este contador es "custom" para el ejercicio. Ya limita los valores MAX y MIN
	port map ( clk=>clk , ena=>s_ena , rst=>rst , dir=>s_dir , q=>salida_cont );
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
			when RESET =>
				s_ena <= '0';
				s_dir <= '0';
				s_wea <= "0";
			when EXCP =>
				s_ena <= '0';
				s_dir <= '0';
				s_wea <= "1";
			when DET =>
				s_ena <= '0';
				s_dir <= '0';
				s_wea <= "0";
			when SUMO =>
				s_ena <= '1';
				s_dir <= '0';
				s_wea <= "0";
			when WRITE =>
				s_ena <= '0';
				s_dir <= '0';
				s_wea <= "1";
			when READ =>
				s_ena <= '1';
				s_dir <= '1';
				s_wea <= "0";

			when OTHERS =>      --Caso de seguridad
				s_ena <= '0';
				s_dir <= '0';
				s_wea <= "0";
		 end case;
	end process;
	---- logica transiciones -----------
	transicionProcess: process(state , wr , rd , salida_cont)
	begin
		nextState <= state;         --Equivalente a todos los ELSE donde el estado no cambia
		case (state) is
			when RESET =>
				if ( wr = '1' ) then
					nextState <= EXCP;
				end if;
			when EXCP =>
				nextState <=DET;
			when DET =>
				if (wr='1' and salida_cont /= "11") then		--MEJORA. En la entrega original no consultaba el valor de salida_cont
					nextState <= SUMO;							-- 		  Esto generaba que sobreescriba el ?ltimo valor
				elsif (rd = '1') then
					nextState <= READ;
				end if;
			when SUMO =>
				nextState <= WRITE;
			when WRITE =>
				if (wr = '1') then
					nextState <= SUMO;
				else
					nextState <= DET;		--MEJORA. En la entrega original no existia el if, siempre volv?a a DET
				end if;						-- solo aumenta la velocidad de escrituras continuas.
			when READ =>
				if (salida_cont = "00") then 
					nextState <= RESET;
				elsif ( wr='0' and rd='1' )then
					nextState <= READ;
				else
					nextState <= DET;		--MEJORA. En la entrega original no existia el if, siempre volv?a a DET
				end if;
			when OTHERS =>      --Caso de seguridad
			end case;
	end process;
	-----------------------------------------------
	
	dataRd <= s_douta;
	
end Behavioral;
