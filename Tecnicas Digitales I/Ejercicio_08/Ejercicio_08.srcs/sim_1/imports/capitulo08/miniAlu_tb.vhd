library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity miniAlu_tb is
Generic (N: integer := 4);
end miniAlu_tb;

architecture Behavioral of miniAlu_tb is
component miniAlu is
Generic (DATA_BITS: integer := 4);
port ( a: in std_logic_vector (DATA_BITS-1 downto 0);
       b: in std_logic_vector (DATA_BITS-1 downto 0); 
       carryIn : in std_logic;
       carryOut : out std_logic;
       res: out std_logic_vector (DATA_BITS-1 downto 0); 
       sat: in std_logic;        
       code: in std_logic_vector (3 downto 0);        
       zero : out std_logic;
       overflow : out std_logic;
       negative : out std_logic
);
end component;

    signal a :std_logic_vector (N-1 downto 0);
    signal b : std_logic_vector (N-1 downto 0);
    signal carryIn : std_logic;
    signal carryOut : std_logic;
    signal res: std_logic_vector (N-1 downto 0); 
    signal sat: std_logic;        
    signal code: std_logic_vector (3 downto 0);        
    signal zero : std_logic;
    signal overflow : std_logic;
    signal negative : std_logic;
    
begin

uut: miniAlu 
    Generic map (DATA_BITS => N)
    PORT MAP (a => a,
              b => b,
              carryIn => carryIn,
              carryOut => carryOut,
              res => res, 
              sat => sat,        
              code => code,        
              zero => zero,
              overflow => overflow,
              negative => negative);

stim_proc: process
begin
	sat <= '0';
	carryIn <= '0';
	code <= "0000";
	-- AND --
	code <= "0000";
	b <= X"F"; a <= X"A";  wait for 100 ns; -- 
	b <= X"5"; a <= X"A";  wait for 100 ns; -- 
	b <= X"5"; a <= X"3"; wait for 100 ns; -- 
    
    -- or --
	code <= "0001";
	b <= X"F"; a <= X"A";  wait for 100 ns; -- 
	b <= X"5"; a <= X"A";  wait for 100 ns; -- 
	b <= X"0"; a <= X"A"; wait for 100 ns; --
    
    -- xor --
	code <= "0010";
	b <= X"F"; a <= X"A";  wait for 100 ns; -- 
	b <= X"5"; a <= X"A";  wait for 100 ns; -- 
	b <= X"0"; a <= X"A"; wait for 100 ns; --
    
    -- Suma --
    code <= "0011"; sat <= '0'; 
 	carryIn <= '0'; b <= X"1"; a <= X"1";  wait for 100 ns; -- 1 + 1
	carryIn <= '0'; b <= X"F"; a <= X"F";  wait for 100 ns; -- -1 + -1 (Carry)
    carryIn <= '1'; b <= X"0"; a <= X"0";   wait for 100 ns; -- 0 + 0
	carryIn <= '0'; b <= X"7"; a <= X"1";  wait for 100 ns; --  7 + 1 (overflow)
    sat <= '1'; carryIn <= '0'; b <= X"7"; a <= X"1";  wait for 100 ns; --  7 + 1 (overflow, sat )
    
    -- Resta --
    code <= "0100"; sat <= '0'; 
	carryIn <= '0'; b <= X"0"; a <= X"1";  wait for 100 ns; -- 0 - 1 = F (borrow)
	carryIn <= '1'; b <= X"1"; a <= X"0";  wait for 100 ns; -- -1 - -1 = -2 (Carry)
	carryIn <= '0'; b <= X"8"; a <= X"1";  wait for 100 ns; --  -8 - 1 (overflow)
	carryIn <= '0'; b <= X"7"; a <= X"F";  wait for 100 ns; --  -8 - -1 (overflow)
    sat <= '1'; carryIn <= '0'; b <= X"7"; a <= X"F";  wait for 100 ns; --  -8 - -1 (overflow, sat)
    a <= X"E";    
    wait;
    
end process;

end Behavioral;
