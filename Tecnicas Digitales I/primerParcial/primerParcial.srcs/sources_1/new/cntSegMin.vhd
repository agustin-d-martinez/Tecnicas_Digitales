library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.math_real.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity cntSegMin is
Generic (SYS_FREC: integer := 200000000;
		N: integer := 4;
		SEGxMIN: integer := 60);
Port (  clk:    in std_logic ;
        rst:    in std_logic ;
        ena:    in std_logic ;
        seg:    out std_logic_vector (N-1 downto 0);
        min:    out std_logic_vector (N-1 downto 0));

end cntSegMin;

architecture Behavioral of cntSegMin is

constant M: integer:= integer( ceil(log2(real(SYS_FREC))) ) + 1;
signal q_count : unsigned (M-1 downto 0);		
signal q_seg : unsigned (N-1 downto 0);
signal q_min : unsigned (N-1 downto 0);

begin

seg <= std_logic_vector ( q_seg(N-1 downto 0) );
min <= std_logic_vector ( q_min(N-1 downto 0) );

process ( clk )
begin
    if ( rising_edge( clk ) ) then
        if ( rst = '1' ) then			--Reset
        	q_count <= (others=> '0'); 
            q_seg <= to_unsigned(0,N);
            q_min <= to_unsigned(0,N);
            
        elsif ( ena = '1' ) then
        	if (q_count = SYS_FREC -1) then		--Solo cuando paso 1 segundo
        		q_count <= (others=>'0');
				if ( q_seg = SEGxMIN-1 ) then			--Solo cuando pasaron 60 seg (1min)
					q_seg <= to_unsigned(0,N);
					q_min <= q_min + 1;
				else
					q_seg <= q_seg + 1;		--Cuento segundos
				end if;
			else
				q_count <= q_count + 1;				--Cuento
			end if;
        end if;
        
    end if;
end process;


end Behavioral;
