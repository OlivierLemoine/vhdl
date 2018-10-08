library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.all;

entity comp_phase is
  port (
    clock, reset: in std_logic;
    Top_0, Top_Synchro: in std_logic;
    Av, Ar: out std_logic
  ) ;
end comp_phase ; 

architecture arch_comp_phase of comp_phase is
signal Ft_Top_0, Ft_Top_Synchro: std_logic;
begin
    edge_detector_Top_0 : entity edge_detector port map(
        clock => clock,
        reset => reset,
        input_signal => Top_0,
        output_signal => Ft_Top_0
    );

    edge_detector_Top_Sync : entity edge_detector port map(
        clock => clock,
        reset => reset,
        input_signal => Top_Synchro,
        output_signal => Ft_Top_Synchro
    );

    me_comp_phase_comp : entity me_comp_phase port map(
        clock => clock,
        reset => reset,
        E => Ft_Top_0,
        S => Ft_Top_Synchro,
        Av => Av,
        Ar => Ar
    );
end architecture ;