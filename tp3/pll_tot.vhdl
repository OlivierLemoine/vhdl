library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.all; 

entity pll_tot is
  port (
    clock, reset: in std_logic;
    out_1, out_2, out_3: out std_logic_vector(7 downto 0);
    top_0: in std_logic
  ) ;
end pll_tot ; 

architecture arch_pll_tot of pll_tot is
    signal phase: std_logic_vector(8 downto 0);
begin
    pll_comp : entity pll port map(
        clock => clock,
        reset => reset,
        Top_0 => top_0,
        phase => phase
    );
    rom1_comp : entity rom1 port map(
        adresse => phase,
        donnee => out_1
    );
    rom2_comp : entity rom2 port map(
        adresse => phase,
        donnee => out_2
    );
    rom3_comp : entity rom3 port map(
        adresse => phase,
        donnee => out_3
    );
end architecture ;