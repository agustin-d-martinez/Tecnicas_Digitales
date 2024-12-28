library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity myDivMag8 is
Port (  entrada : in std_logic_vector (8-1 downto 0);
        div     : in  std_logic_vector (1 downto 0);
        salida  : out  std_logic_vector (8-1 downto 0));
end myDivMag8;
architecture Behavioral of myDivMag8 is  --En realidad es un desplazador a la derecha
begin

--Forma "correcta"
--with div select                                                                                  
--salida <=   entrada when ( "00" ),
--            '0' & entrada( 8-1 downto 1 ) when ( "01" ),
--            '0' & '0' & entrada( 8-1 downto 2 ) when ( "10" ),
--            '0' & '0' & '0' & entrada( 8-1 downto 3 ) when ( "11" ),
--            (others => '0') when others;


salida <= std_logic_vector ( unsigned(entrada) srl TO_INTEGER(unsigned(div)) );     
                                                                                          
end Behavioral;     --srl: Shift Right Logical. Tambi?n existe sla: Shift Left Aritmetical y todas sus combinaciones
--srl,sll,sra,sla => Left is signed/unsigned. Right is Integer. [bit_vector] <= [bit_vector] sra [integrer]
-- Operators for VHDL: https://www.eng.auburn.edu/~nelsovp/courses/elec4200/VHDL/VHDL_Operators.p-df