library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
--library UNISIM;
--use UNISIM.VComponents.all;

entity RightLeft_Shifter is
Generic(N:integer := 4);
Port (  A:	in std_logic_vector (N-1 downto 0);
        mode:	in std_logic;	-- 1=right;		0=left
        D:	in std_logic_vector (4-1 downto 0);		
        R :	out std_logic_vector (N-1 downto 0));
end RightLeft_Shifter;

architecture Behavioral of RightLeft_Shifter is
	signal Right: std_logic_vector (N-1 downto 0);
	signal Left: std_logic_vector (N-1 downto 0);
begin
	Right <= std_logic_vector ( shift_right(signed(A),TO_INTEGER (unsigned(D))) );
	Left <= std_logic_vector ( shift_left(signed(A),TO_INTEGER (unsigned(D))) );
	
	R <= Right when (mode = '1') else Left;
	
end Behavioral;
