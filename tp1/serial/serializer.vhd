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
    signal reg : std_logic_vector(10 downto 0);
begin
    process(clk, raz)
    begin
        if raz='1' then
            reg <= "00000000000";
        elsif load='1' then
            reg <= d_in & "01";
        elsif rotate='1' then
            reg <= d_in(0) & d_in(10 downto 1);
        end if ;
    end process ; -- identifier

    TX <=reg(0);

end arch_serializer;