library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
 
entity substract is
port(       A,B     :   in std_logic_vector(3 downto 0);
            result  :   out std_logic_vector(3 downto 0));
end substract;
 
architecture arch_substract of substract is
begin
    result <= std_logic_vector(unsigned(B)-unsigned(A));
end arch_substract;