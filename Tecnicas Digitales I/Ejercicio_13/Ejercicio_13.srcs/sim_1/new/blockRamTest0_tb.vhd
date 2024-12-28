library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity blockRamTest0_tb is
--  Port ( );
end blockRamTest0_tb;

architecture Behavioral of blockRamTest0_tb is
COMPONENT blockRamTest0 is
    Port(
    clka:   in std_logic ;
    wea:    in std_logic_vector (0 downto 0) ;
    addra:  in std_logic_vector (9 downto 0) ;
    dina:   in std_logic_vector (15 downto 0) ;
    douta:  out std_logic_vector (15 downto 0));
END COMPONENT;

--signals----------------------------------------------------
    signal wea :    std_logic_vector (0 downto 0) := "0"; 
    signal addra :  std_logic_vector (9 downto 0) := B"0000_0000_00"; 
    signal dina :   std_logic_vector (15 downto 0):= X"0000"; 
    signal douta :  std_logic_vector (15 downto 0) ;
    signal clka :   std_logic := '0'; 
-------------------------------------------------------------   
constant clk_period : time := 10 ns;

begin
uut: blockRamTest0 PORT MAP (
    clka => clka,          
    wea => wea,
    addra => addra,
    dina => dina,
    douta => douta );

-- Clock process --
clk_process :process
begin
    clka <= '0';     wait for clk_period/2;
    clka <= '1';     wait for clk_period/2;
end process;


-- Ena process --
enaProc :process
begin  
    wea <= "0";     --Modo lectura
    wait until rising_edge (clka);
    wait for clk_period;
      
    addra <= "00" & X"00"; wait for 2*clk_period; -- Leo la pos0
    if (douta /= X"bb00") then report "Error memoria pos0" severity failure; end if;
    
    addra <= "00" & X"01"; wait for 2*clk_period; -- Leo la pos1
    if (douta /= X"bb01") then report "Error memoria pos0" severity failure; end if;
    
    addra <= "00" & X"02"; wait for 2*clk_period; -- Leo la pos2
    if (douta /= X"bb02") then report "Error memoria pos0" severity failure; end if;
    
    addra <= "00" & X"03"; wait for 2*clk_period; -- Leo la pos3
    if (douta /= X"bb03") then report "Error memoria pos0" severity failure; end if;
    
    addra <= "00" & X"04"; wait for 2*clk_period; -- Leo la pos4
    if (douta /= X"bb04") then report "Error memoria pos0" severity failure; end if;
    
    
    
    wea <= "1"; wait for clk_period;        --Modo escritura por 1 ciclo (escribiendo pos4)
    wea <= "0"; wait for clk_period;        --Vuelvo al modo lectura con nuevo valor de pos4
    if (douta /= X"0000") then report "ERROR ESCRITURA POS4" severity failure; end if;
    
    addra <= "00" & X"05";
    dina <= X"5555";                    --Escribo 5555 en la pos5.
    wea <= "1"; wait for clk_period;
    
    wea <= "0";
    dina <= X"5555";
    addra <= "00" & X"04";        --Termino el programa leyendo pos4
    wait;
end process;

end Behavioral;
