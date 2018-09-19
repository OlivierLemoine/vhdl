library IEEE;
use IEEE.std_logic_1164.all;

entity decoder is
port(
    E       :   in 	std_logic_vector(1 downto 0);
	S0,S1,S2:   out 	std_logic);
end decoder;

architecture arch_decoder of decoder is
begin
	S0<='1' when E="00" else '0';
	S1<='1' when E="01" else '0';
	S2<='1' when E="10" else '0';
end arch_decoder;