library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity registre is
    generic (
        taille_in : integer := 4;
        taille_out : integer := 8
    );
    port (
        clock, reset : in std_logic;
        load : in std_logic;
        din : in std_logic_vector(taille_in-1 downto 0);
        dout : out std_logic_vector(taille_out-1 downto 0)
    ) ;
end registre ; 

architecture arch_registre of registre is
begin
    sync : process( clock )
    begin
        if rising_edge(clock) then
            if reset='1' then
                dout <= (others => '0');
            elsif load='1' then
                dout(taille_out-1 downto taille_in) <= (others => din(taille_in-1));
                dout(taille_in-1 downto 0) <= din;
            end if ;
        end if ;
    end process ; -- sync
end architecture ;