library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;
    use work.all;

entity sequenceur is
    generic(
        taille_count : integer := 7
    );
    port (
        clock, reset : in std_logic;
        clke, ref : in std_logic;
        count : in std_logic_vector(taille_count-1 downto 0);
        calc, raz_pile_rec, ld_pile_rec, raz_pile_ref, ld_pile_ref, raz_reg_pdt, ld_reg_pdt, raz_reg_sum, ld_reg_sum, raz_count, en_count : out std_logic;
    ) ;
end sequenceur ; 

architecture arch_sequenceur of sequenceur is
    type inner_state is (reset, idle, load_ref, wait_ref, wait_ref_calc, load_rec, calc_mul, calc_add, wait_calc);
    signal current_state, next_state : inner_state;
begin
    sync : process( clock, reset )
    begin
        if reset='1' then
            current_state <= reset;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if ;     
    end process ; -- sync

    combinatoire : process( current_state, ref, clke, count )
    begin
        raz_pile_rec <= '0';
        raz_pile_ref <= '0';
        raz_reg_pdt <= '0';
        raz_reg_sum <= '0';
        raz_count <= '0';

        next_state <= current_state;
        ld_pile_ref <= '0';
        ld_pile_rec <= '0';
        en_count <= '0';
        ld_reg_pdt <= '0';
        ld_reg_sum <= '1';

        case( current_state ) is
            
            when reset =>
                next_state <= idle;
                raz_pile_rec <= '1';
                raz_pile_ref <= '1';
                raz_reg_pdt <= '1';
                raz_reg_sum <= '1';
                raz_count <= '1';
            when idle =>
                if ref='1' and clke='1' then
                    next_state <= load_ref;
                end if ;
            when load_ref =>
                next_state <= wait_ref;
                ld_pile_ref <= '1';
            when wait_ref =>
                if clke='0' then
                    next_state <= wait_ref_calc;
                end if ;
            when wait_ref_calc =>
                if clke='0' then
                    if ref='1' then
                        next_state <= load_ref;
                    else
                        next_state <= load_rec;
                    end if ;
                end if ;
            when load_rec =>
                next_state <= calc_mul;
                ld_pile_rec <= '1';
                en_count <= '1';
            when calc_mul =>
                ld_reg_pdt <= '1';
                if count="01011000" then
                    next_state <= wait_calc;
                else
                    next_state <= calc_add;
                end if ;
            when calc_add =>
                ld_reg_sum <= '1';
                next_state <= calc_mul;
            when wait_calc =>
                if clke='0' then
                    next_state <= wait_ref_calc;
                end if ;
        end case ;
    end process ; -- combinatoire
end architecture ;