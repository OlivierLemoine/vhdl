
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity count is 

	generic (size_cnt : integer := 16);

	port (clk  :   in std_logic;
		  raz  :   in std_logic;
		  en   :   in std_logic;
		  cnt  :   out std_logic_vector(size_cnt-1 downto 0)
	);


end count;



architecture arch_cnt of count is

signal  s_cnt : std_logic_vector(size_cnt-1 downto 0);

begin


	process(clk)
		begin
		if raz = '1' then cnt <= (others => '0');
		elsif rising_edge(clk) then
			s_cnt <= std_logic_vector(unsigned(s_cnt) + 1); 
		end if;
	end process;

cnt <= s_cnt;

end arch_cnt;