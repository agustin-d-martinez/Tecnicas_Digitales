----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08/19/2022 09:41:31 AM
-- Design Name: 
-- Module Name: genSec2_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity genSec2_tb is
--  Port ( );
end genSec2_tb;

architecture Behavioral of genSec2_tb is

    component genSec2 is
        Port ( clk     : in  std_logic;
               rst     : in  std_logic;
               entradas : in  std_logic_vector (1 downto 0);
               y: out std_logic_vector (2 downto 0));
    end component;
    
    signal rst      : std_logic;
    signal entradas  : std_logic_vector (1 downto 0);
    signal y        : std_logic_vector (2 downto 0);
    
    -- Clk --
    signal clk : std_logic := '0';
    constant clk_period : time := 10 ns;

begin
uut: genSec2    
    Port map ( clk => clk,
               rst => rst,
               entradas => entradas,
               y  => y);

-- Clock process --
clk_process :process
begin
    clk <= '0';     wait for clk_period/2;
    clk <= '1';     wait for clk_period/2;
end process;

-- Reset process --
resetProc :process
begin      
    rst <= '1';     wait for 50 ns;
    rst <= '0';     wait;
end process;

-- Stimulus process --
stimProc :process
begin      
    entradas <= "00";
    wait until falling_edge (rst); 
    wait until rising_edge (clk);
    entradas <= "01";
    wait for 50 ns;
    wait until rising_edge (clk);
    entradas <= "11";
    wait for 20 ns;
    wait until rising_edge (clk);
    entradas <= "00";    
    
    wait for 50 ns;
    wait until rising_edge (clk);
    entradas <= "11";
    wait for 20 ns;
    wait until rising_edge (clk);
    entradas <= "00";
    
    wait;    
end process;



end Behavioral;
