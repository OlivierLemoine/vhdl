library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
 
entity comp is
port(       A,B     :   in std_logic_vector(3 downto 0);
            result  :   out std_logic);
end comp;
 
architecture arch_comp of comp is
begin
    result <= '1' when unsigned(A)>=unsigned(B) else
        '0';
end arch_comp;