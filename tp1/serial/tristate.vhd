
library IEEE;
use IEEE.std_logic_1164.all;
 
entity tristate is
port(   
    data_in     :   in std_logic_vector(7 downto 0);
    oe          :   in std_logic;
    data_out    :   out std_logic_vector(7 downto 0));
end tristate;
 
architecture arch_tristate of tristate is
begin
    data_out <= data_in when oe='1' else "ZZZZZZZZ";
end arch_tristate;