library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity counter is
port(
    clk,raz,ce		:	in  std_logic;
	count 			: 	out std_logic_vector(3 downto 0));
end counter;

architecture arch_counter of counter is
signal count_int : unsigned (3 downto 0);
begin
process(clk,raz)
	begin
	if rising_edge(clk) then
		if raz='1' then count_int <= (others => '0');
		elsif ce='1' then
			if count_int="1111" then count_int <= (others => '0'); -- fin de comptage
			else count_int <= count_int + 1; -- "+"(unsigned,int)
			end if;
		end if;
	end if;
end process;

count <= std_logic_vector(count_int); -- count copie de count_int

end arch_counter;