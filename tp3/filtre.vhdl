library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.all;

entity filtre is
    generic (size_reg : integer := 9);
    port (
        clock, reset: std_logic;
        inc, dec: in std_logic;
        delta_phi: out std_logic_vector(size_reg-1 downto 0)
    ) ;
end filtre ; 

architecture arch_filtre of filtre is
    signal compt: std_logic_vector(size_reg-1 downto 0);
begin
    compt_dec_comp : entity compt_dec 
    generic map(size_reg => size_reg)
    port map(
        clock => clock,
        reset => reset,
        inc => inc,
        dec => dec,
        compt => compt
    );

    correcteur_comp : entity correcteur
    generic map(size_reg => size_reg) 
    port map(
        clock => clock,
        reset => reset,
        compt => compt,
        delta_phi => delta_phi
    );
end architecture ;