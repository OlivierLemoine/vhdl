library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity edge_detector is
port(
        clk,reset       :   in std_logic;
        input_signal    :   in std_logic;
        output_signal   :   out std_logic
    );
end edge_detector;

architecture arch_edge_detector of edge_detector is
type inner_state is (idle, triggered, waiting);
signal current_state, next_state : inner_state;
begin
----------------------------------------------------------------------------------
    process(clk,reset)
    begin
            if reset='1' then current_state <= idle;
            elsif rising_edge(clk) then current_state <= next_state;
            end if;
    end process;

    process(input_signal, current_state)
    begin

        output_signal <= '0';
        next_state <= current_state;
        case current_state is
            when idle =>
                if input_signal='1'
                then
                    next_state <= triggered;
                    output_signal <= '1';
                end if;
            when triggered =>
                next_state <= waiting;
                output_signal <= '0';
            when waiting =>
                if input_signal='0'
                then
                    next_state <= idle;
                end if;
                output_signal <= '0';
        end case;
    end process;
end arch_edge_detector;