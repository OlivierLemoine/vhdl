library IEEE;
use IEEE.std_logic_1164.all;


entity sequencer is
port( clk, reset, start,  ld_t: in std_logic;
	comptage : in std_logic_vector (3 downto 0);
	set_st, raz_st,  raz_ser, ld_ser, ser, raz_count, ce : out std_logic);
end sequencer;

architecture arch_sequencer of sequencer is

--************************************
--	A COMPLETER	
--************************************

begin

--************************************
--	A COMPLETER	
--************************************
end arch_sequencer;