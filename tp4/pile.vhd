library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity pile is
    generic (
        taille_pile : integer := 4;
        taille_data : integer := 4
    );
    port (
        clock, raz : in std_logic;
        load, rotate : in std_logic;
        din : in std_logic_vector(taille_data-1 downto 0);
        dout : out std_logic_vector(taille_data-1 downto 0)
    ) ;
end pile ; 

architecture arch_pile of pile is
    type pile_regs is array (0 to taille_pile-1) of std_logic_vector(taille_data-1 downto 0);
    signal regs : pile_regs;    
begin
    sync : process( clock )
    begin
        if rising_edge(clock) then
            if raz='1' then
                regs <= (others => (others => '0'));
            elsif load='1' then
                regs(0) <= din;
                for i in 0 to taille_pile-2 loop
                    regs(i+1) <= regs(i);
                end loop ;
            elsif rotate='1' then
                regs(0) <= regs(taille_pile-1);
                for i in 0 to taille_pile-2 loop
                    regs(i+1) <= regs(i);
                end loop ;
            end if ;
        end if ;
    end process ; -- sync
    dout <= regs(taille_pile-1);
end architecture ;