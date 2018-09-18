library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registre is
port(   clk,reset,load  :   in std_logic;
    d_in        :   in std_logic_vector(3 downto 0);
    d_out       :   out std_logic_vector(3 downto 0));
end registre;

architecture arch_registre of registre is
begin
    process(clk,reset)
        begin
        if reset='1' then d_out <= (others => '0');
        elsif rising_edge(clk) then
            if load='1' then d_out <= d_in;
            end if;
        end if;
    end process;
end arch_registre;