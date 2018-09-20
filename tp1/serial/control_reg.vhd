library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity control_reg is
port(
    clk,reset,load	:	in std_logic;
	d_in 		    : 	in std_logic_vector(7 downto 0);
	d_out 		    : 	out std_logic);
end control_reg;

architecture arch_control_reg of control_reg is
begin
	process(clk,reset)
		begin
		if reset='1' then 
            d_out <= '0';
		elsif rising_edge(clk) then
			if load='1' then 
                d_out <= std_logic(d_in(0));
			end if;
		end if;
	end process;
end arch_control_reg;