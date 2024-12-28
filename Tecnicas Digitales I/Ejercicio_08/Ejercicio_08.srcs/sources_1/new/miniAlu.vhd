library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_misc.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
-------FALTA CORREGIR CARRY IN DE RESTA!!!!!!-------------------------------------------------
----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
entity miniAlu is
Generic(DATA_BITS:integer :=16);
Port (  a   : in std_logic_vector (DATA_BITS-1 downto 0) ;
        b   : in std_logic_vector (DATA_BITS-1 downto 0) ;
        carryIn     : in std_logic ;
        carryOut    : out std_logic ;
        res : out std_logic_vector (DATA_BITS-1 downto 0) ;
        sat : in std_logic ;
        code    : in std_logic_vector (3 downto 0) ;
        zero    : out std_logic ;
        overflow    : out std_logic ;
        negative    : out std_logic);
end miniAlu;

architecture Behavioral of miniAlu is
signal suma: std_logic_vector ((DATA_BITS-1)+2 downto 0) ;
signal sumaSaturada: std_logic_vector ((DATA_BITS-1) downto 0) ;
signal resta:std_logic_vector ((DATA_BITS-1)+2 downto 0) ;
signal restaSaturada: std_logic_vector ((DATA_BITS-1) downto 0) ;
 
signal ov_suma: std_logic ;
signal ov_resta: std_logic ; 
 
signal resAux: std_logic_vector (DATA_BITS-1 downto 0) ;

signal MAX: std_logic_vector (DATA_BITS-1 downto 0);
signal MIN: std_logic_vector (DATA_BITS-1 downto 0);
begin
------SALIDA DE ALU-------------------------------------------------------------------------
res <= resAux;                                  --Control de la salida
with code select
resAux <=   a and b when ("0000"),
            a or b when ("0001"),
            a xor b when ("0010"),
            sumaSaturada when ("0011"),
            restaSaturada when ("0100"),
            (others =>'0') when others;
--------------------------------------------------------------------------------------------

carryOut <=  suma((DATA_BITS-1)+2) when (code = "0011") else        --Carry Out
            resta((DATA_BITS-1)+2) when (code = "0100") else
            '0';--Condicion innecesaria
            
zero <= not( or_reduce(resAux) );       --Salida = 0
negative <= resAux(DATA_BITS-1);        --Signo del resultado.

------CALCULO DE OVERFLOW------------------------------------------------------------------
ov_suma <= ( not(suma(DATA_BITS)) and b(DATA_BITS-1) and a(DATA_BITS-1) ) or ( suma(DATA_BITS) and not(b(DATA_BITS-1)) and not(a(DATA_BITS-1)) );       --Overflow suma
ov_resta <=( a(DATA_BITS-1) and not (resta(DATA_BITS)) and not (b(DATA_BITS-1)) ) or ( not(a(DATA_BITS-1)) and b(DATA_BITS-1) and resta(DATA_BITS) );      --Overflow resta
overflow <= ov_suma when (code = "0011") else
            ov_resta when (code = "0100") else
            '0';   
--------------------------------------------------------------------------------------------


-----CALCULO DE LA SUMA Y LA RESTA----------------------------------------------------------
suma <= std_logic_vector( signed('0'& a & carryIn) + signed('0'& b & carryIn) );
resta <= std_logic_vector( signed('0'& a & not(carryIn) ) - signed('0'& b & carryIn) );

sumaSaturada <= MAX when ((suma(DATA_BITS) = '1') and ov_suma= '1' and sat= '1') else      --Saturo la suma en caso de ser necesario
                MIN when ((suma(DATA_BITS) = '0') and ov_suma= '1' and sat= '1') else
                suma((DATA_BITS-1)+1 downto 1);
restaSaturada <=MAX when ((suma(DATA_BITS) = '1') and ov_resta= '1' and sat= '1') else    --Saturo la suma en caso de ser necesario
                MIN when ((suma(DATA_BITS) = '0') and ov_resta= '1' and sat= '1') else
                resta((DATA_BITS-1)+1 downto 1);
--------------------------------------------------------------------------------------------


---GENERACION DE MAX/MIN----------------------------------
MAX(DATA_BITS-1)<= '0';
MAX(DATA_BITS-2 downto 0) <= (others=>'1');            
MIN <= not(MAX);
----------------------------------------------------------                                
end Behavioral;
