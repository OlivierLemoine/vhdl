library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity correcteur is
    generic (size_reg : integer := 9);
    port (
        clock, reset: std_logic;
        compt: in std_logic_vector(size_reg-1 downto 0);
        delta_phi: out std_logic_vector(size_reg-1 downto 0)
    ) ;
end correcteur ; 

architecture arch_correcteur of correcteur is
    signal prev_value: std_logic_vector(size_reg-1 downto 0);
    signal out_reg: std_logic_vector(size_reg-1 downto 0);
    signal too_long_logic_vector: std_logic_vector(size_reg*2-1 downto 0);
begin
    sync : process( clock, reset )
    begin
        if reset='1' then 
            prev_value <= (others=>'0');
            out_reg <= (others=>'0');
            too_long_logic_vector <= (others=>'0');
        elsif rising_edge(clock) then
            too_long_logic_vector <= std_logic_vector(unsigned(compt)*18 - (unsigned(prev_value)*17));
            -- out_reg <= too_long_logic_vector(size_reg*2-1 downto size_reg);
            out_reg <= too_long_logic_vector(size_reg+3 downto 4);
            prev_value <= compt;
        end if;
    end process ; -- sync
    delta_phi <= out_reg;
end architecture ;