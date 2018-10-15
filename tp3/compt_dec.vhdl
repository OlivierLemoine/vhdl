library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity compt_dec is
    generic (size_reg : integer := 9);
    port (
        clock, reset: in std_logic;
        inc, dec: in std_logic;
        compt: out std_logic_vector(size_reg-1 downto 0)
    ) ;
end compt_dec ; 

architecture arch_compt_dec of compt_dec is
    signal in_reg: std_logic_vector(size_reg-1 downto 0);
begin
    sync : process( clock, reset )
    begin
        if reset='1' then in_reg <=  (others=>'0');
        elsif rising_edge(clock) then
            if inc='1' then
                in_reg <= std_logic_vector(unsigned(in_reg) + 1);
            end if ;
            if dec='1' then
                in_reg <= std_logic_vector(unsigned(in_reg) - 1);
            end if ;
        end if;
    end process ; -- sync

    compt <= in_reg;
end architecture ;