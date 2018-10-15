library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity registre is
    generic (
        taille_in : integer :=4;
        taille_out : integer :=4
    );
    port (
        clock, reset : in std_logic;
        load : in std_logic;
        din : in std_logic_vector(taille_in-1 downto 0);
        dout : out std_logic_vector(taille_out-1 downto 0)
    ) ;
end registre ; 

architecture arch_registre of registre is
    signal reg : std_logic_vector(taille_out-1 downto 0);
begin
    sync : process( clock )
    begin
        if rising_edge(clock) then
            if reset='1' then
                reg <= (others => '0');
            elsif load='1' then
                reg <= std_logic_vector(resize(signed(din), taille_out));
            end if ;
        end if ;
    end process ; -- sync
    dout <= reg;
end architecture ;