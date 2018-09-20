library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity serial is
port(
    clk, reset  : in std_logic;
	data        : inout std_logic_vector(7 downto 0);
	address     : in std_logic_vector(1 downto 0);
	tx          : out std_logic);
end serial;


architecture arch_serial of serial is
signal ld_ctl,  raz_ser, start, oe_etat, set_st, raz_st, ld_t, ld_ser, ser, par, ce, raz_count : std_logic;
signal comptage : std_logic_vector(3 downto 0);
signal etat : std_logic_vector(7 downto 0);
signal tamp_out : std_logic_vector(7 downto 0);
signal ser_in : std_logic_vector( 8 downto 0);

begin

data <= etat when oe_etat='1' else (others => 'Z');
ser_in <= par & tamp_out;

decod:		entity decoder port map(
			E   => address,
			S0  => ld_ctl,
			S1  => oe_etat,
			S2  => ld_t
			);

tampon:		entity temp_reg port map(
			clk		=> clk,
			reset   => reset,
			load    => ld_t,
			d_in    => data,
			d_out   => tamp_out
			);

ctl:		entity control_reg  port map(
			clk	    => clk,
			reset	=> reset,
			load	=> ld_ctl,
			d_in 	=> data,
			d_out 	=> start
			);


reg_etat:	entity state_reg  port map(
			clk		=> clk,
			raz		=> raz_st,
			set		=> set_st,
			d_out 	=> etat
			);

seq:		entity sequencer port map(
			clk		    => clk,
			reset		=> reset,
			start		=> start,
			ld_t		=> ld_t,
			comptage 	=> comptage,
			set_st		=> set_st,
			raz_st		=> raz_st,
			raz_ser		=> raz_ser,
			ld_ser		=> ld_ser,
			ser		    => ser,
			raz_count	=> raz_count,
			ce 		    => ce
			);

compt:		entity counter port map(
			clk		=> clk,
			raz		=> raz_count,
			ce		=> ce,
			count   => comptage
			);

detec_par:	entity parity port map(
			E 		=> tamp_out,
			par		=> par
			);

reg_ser:	entity serializer port map(
			raz		=> raz_ser,
			clk		=> clk,
			load	=> ld_ser,
			rotate	=> ser,
			d_in 	=> ser_in,
			TX		=> tx
			);






end arch_serial;