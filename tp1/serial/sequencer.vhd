library IEEE;
use IEEE.std_logic_1164.all;


entity sequencer is
port(
    clk, reset, start,  ld_t    : in std_logic;
	comptage                    : in std_logic_vector (3 downto 0);
	set_st, raz_st, raz_ser, ld_ser, ser, raz_count, ce : out std_logic);
end sequencer;

architecture arch_sequencer of sequencer is

    type inner_state is (idle, triggered, waiting);
    signal current_state, next_state : inner_state;

begin

    sync : process( clk, reset )
    begin
        if reset='1' then
            comptage <= "0000"
        else
            current_state <= next_state;
        end if ;
    end process ; -- sync

    combination : process(  )
    begin
        case( comtage, current_sate ) is
        
            when IDLE =>
                
        
            when others =>
        
        end case ;
    end process ; -- combination

end arch_sequencer;