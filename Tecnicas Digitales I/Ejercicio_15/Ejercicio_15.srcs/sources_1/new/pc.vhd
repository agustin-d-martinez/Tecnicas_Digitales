library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library work;
--use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity pc is
Generic (DATA_BITS: integer:= 16);
Port(   clk:    in std_logic ;
        rst:    in std_logic ;
        ena:    in std_logic ;
        pl:     in std_logic ;
        plAddr: in std_logic_vector (DATA_BITS-1 downto 0) ;
        data:   out std_logic_vector(32-1 downto 0));
end pc;

architecture Behavioral of pc is
signal salida_cont: std_logic_vector (DATA_BITS-1 downto 0);
signal data_aux: std_logic_vector (32-1 downto 0);
signal Addr_aux: std_logic_vector (10-1 downto 0);
begin

blockRam: entity work.pcMem
Port map ( clka=>clk , addra=>Addr_aux , douta=>data_aux ); 
cont: entity work.myCntBinarioPl
Generic map (N => DATA_BITS)
Port map ( clk=>clk , rst=>rst , ena=>ena , dl=>pl , d =>plAddr , q=>salida_cont );

Addr_aux <=  salida_cont(10-1 downto 0);
data <= data_aux;
end Behavioral;
