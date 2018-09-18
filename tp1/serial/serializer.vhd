library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity serializer is
port( 
    raz, clk, load, rotate  : in std_logic;
	d_in                    : in std_logic_vector(8 downto 0);
    TX                      : out std_logic
);
end serializer;


architecture arch_serializer of serializer is
--************************************
--	A COMPLETER	
--************************************
begin

--************************************
--	A COMPLETER	
--************************************

end arch_serializer;