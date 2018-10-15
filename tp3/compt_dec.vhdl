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
    signal ma_x: std_logic_vector(size_reg-1 downto 0);
    signal mi_n: std_logic_vector(size_reg-1 downto 0);
begin
    sync : process( clock, reset )
    begin
        if reset='1' then 
            in_reg <= (others=>'0');
            ma_x <= (others=>'1');
            mi_n <= (others=>'0');
        elsif rising_edge(clock) then
            if inc='1' and in_reg /= ma_x then
                in_reg <= std_logic_vector(unsigned(in_reg) + 1);
            end if ;
            if dec='1' and in_reg /= mi_n then
                in_reg <= std_logic_vector(unsigned(in_reg) - 1);
            end if ;
        end if;
    end process ; -- sync

    compt <= in_reg;
end architecture ;