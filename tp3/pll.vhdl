library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.all;

entity pll is
    generic (size_out : integer := 9);
    port (
        clock, reset: in std_logic;
        Top_0: in std_logic;
        phase: out std_logic_vector(size_out-1 downto 0)
    ) ;
end pll ; 

architecture arch_pll of pll is
    signal Av, Ar, Top_sync: std_logic;
    signal Delta_phi: std_logic_vector(size_out-1 downto 0);
begin
    comp_phase_comp : entity comp_phase port map(
        clock => clock,
        reset => reset,
        Top_0 => Top_0,
        Top_Synchro => Top_sync,
        Av => Av,
        Ar => Ar
    );

    filtre_comp : entity filtre
    generic map(size_reg => size_out)
    port map(
        clock => clock,
        reset => reset,
        inc => Av,
        dec => Ar,
        delta_phi => Delta_phi
    );

    OCN_comp : entity OCN 
    generic map(taille_ocn => size_out)
    port map(
        clk => clock,
        reset => reset,
        delta_phi => Delta_phi,
        phase => phase,
        top_synchro => Top_sync
    );
end architecture ;