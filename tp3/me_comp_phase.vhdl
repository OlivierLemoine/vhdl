library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity me_comp_phase is
    port (
        clock, reset:   in std_logic;
        E, S:           in std_logic;
        Av, Ar:         out std_logic
    );
end me_comp_phase ; 

architecture arch_me_comp_phase of me_comp_phase is
type inner_state is (en_phase, avance, retard);
signal current_state, next_state : inner_state;
begin
    sync : process( clock, reset )
    begin
            if reset='1' then current_state <= en_phase;
            elsif rising_edge(clock) then current_state <= next_state;
            end if ;
    end process ; -- sync

    combinatoire : process( current_state, E, S )
    begin
        Av <= '0';
        Ar <= '0';
        next_state <= current_state;
        case( current_state ) is
            when en_phase =>
                if E='1' and S='0' then
                    next_state <= avance;
                    Av <= '1'; 
                end if;
                if E='0' and S='1' then
                    next_state <= retard;
                    Ar <= '1';
                end if ;
            when avance =>
                Av <='1';
                if S='1' then
                    next_state <= en_phase;
                    Av <='0';
                end if ;
            when retard =>
                Ar <= '1';
                if E='1' then
                    next_state <= en_phase;
                    Ar <= '0';
                end if ;
        end case ;
    end process ; -- combinatoire
end architecture;