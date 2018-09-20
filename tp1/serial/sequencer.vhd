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

    type inner_state is (idle, loading, counting);
    signal current_state, next_state : inner_state;
    signal sync_start : std_logic;

begin

    sync : process( clk, reset )
    begin
        sync_start <= start;
        raz_count <= '0';
        if reset='1' then
            raz_count <= '1';
        else
            current_state <= next_state;
        end if ;
    end process ; -- sync

    combination : process( current_state, sync_start, comptage )
    begin
        ser <= '0';
        ld_ser <= '0';
        raz_ser <= '0';
        raz_count <= '0';
        next_state <= current_state;
        case current_state is
            when idle =>
                if sync_start='1'
                then
                    next_state <= loading;
                    ld_ser <= '1';
                    raz_count <= '1';
                end if;
            when loading =>
                next_state <= counting;
                ser <= '1';
                raz_count <= '0';
            when counting =>
                ser <= '1';
                if comptage="1011" then
                    next_state <= idle;
                    ser <= '0';
                end if ;
        end case;
    end process ; -- combination

end arch_sequencer;