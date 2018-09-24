library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;


entity sequencer is
port(
    clk, reset, start,  ld_t    : in std_logic;
	comptage                    : in std_logic_vector (3 downto 0);
	set_st, raz_st, raz_ser, ld_ser, ser, raz_count, ce : out std_logic);
end sequencer;

architecture arch_sequencer of sequencer is

    type inner_state is (resetting, idle, loading, counting);
    signal current_state, next_state : inner_state;

begin
    sync : process( clk, reset )
    begin
        if reset='1' then
            current_state <= resetting;
        elsif rising_edge(clk) then
            current_state <= next_state;
        end if ;
    end process ; -- sync

    combination : process( current_state, start, comptage, ld_t )
    begin
        ce <= '0';
        ser <= '0';
        ld_ser <= '0';
        raz_st <= '0';
        raz_ser <= '0';
        raz_count <= '0';
        next_state <= current_state;
        case current_state is
            when resetting =>
                raz_st <= '1';
                raz_ser <= '1';
                raz_count <= '1';
                if ld_t='1' then
                    next_state <= idle;
                end if ;
            when idle =>
                if start='1' then
                    next_state <= loading;
                    ld_ser <= '1';
                end if;
            when loading =>
                next_state <= counting;
                ce <= '1';
                ser <= '1';
                set_st <= '1';
            when counting =>
                ce <= '1';
                ser <= '1';
                if comptage="1001" then
                    next_state <= resetting;
                end if ;
        end case;
    end process ; -- combination
end arch_sequencer;
