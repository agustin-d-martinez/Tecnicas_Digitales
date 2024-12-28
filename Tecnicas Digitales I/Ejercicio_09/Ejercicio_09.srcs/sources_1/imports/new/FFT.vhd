library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FFT is
Port (  clk: in std_logic ;
        rst: in std_logic ;
        t: in std_logic ;
        q: out std_logic);
end FFT;

architecture Behavioral of FFT is
signal q_aux: std_logic;
begin
q <= q_aux;

-----PROCESS FLIP FLOP---------------------------------------
process (clk)
begin
    if ( rising_edge(clk) ) then
        if (rst = '1') then
            q_aux <= '0';
        else
            if ( t = '1' ) then
                q_aux <= not q_aux;
            end if;
        end if;
    end if;

end process;
-------------------------------------------------------------

end Behavioral;
