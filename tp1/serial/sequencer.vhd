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
    signal is_tmp_used : std_logic;

begin
    sync : process( clk, reset )
    begin
        if reset='1' then
            raz_count <= '1';
            raz_ser <= '1';
            raz_st <= '1';
            current_state <= idle;
        elsif rising_edge(clk) then
            if comptage="1011" then
                raz_count <= '1';
            else
                raz_count <= '0';
            end if ;
            raz_ser <= '0';
            raz_st <= '0';
            current_state <= next_state;
        end if ;
    end process ; -- sync

    combination : process( current_state, start, comptage )
    begin
        ce <= '0';
        ser <= '0';
        ld_ser <= '0';
        next_state <= current_state;
        case current_state is
            when idle =>
                if start='1'
                then
                    next_state <= loading;
                    ld_ser <= '1';
                end if;
            when loading =>
                next_state <= counting;
                ce <= '1';
                ser <= '1';
                when counting =>
                ce <= '1';
                ser <= '1';
                if comptage="1011" then
                    next_state <= idle;
                end if ;
        end case;
    end process ; -- combination

    is_tmp_used <= ((ld_t or is_tmp_used) and not start) and not reset;
    set_st <= is_tmp_used;
    raz_st <= not is_tmp_used or reset;
end arch_sequencer;