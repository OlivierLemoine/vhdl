library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity correlateur is 

	generic (size_in : integer := 8;
			 size_out : integer := 2;
			 size_pile : integer :=8;
			 size_cnt : integer := 16;
			 size_mult : integer := 16;
			 size_add : integer := 21
			 );

	port(clk,reset : 	in std_logic;
		 d_in : 	in std_logic_vector(size_in-1 downto 0);
		 ref :		in std_logic;
		 correll : 	out std_logic_vector(size_out-1);
	);

end correlateur;

architecture arch_correl of correlateur is 

	signal s_calc, s_ld_pile_rec, s_ld_pile_ref, s_ld_reg_pdt,s_ld_reg_sum : std_logic;
	signal s_raz_pile_rec, s_raz_pile_ref, s_raz_reg_pdt,s_raz_reg_sum : std_logic;
	signal s_raz_cnt, s_en_cnt : std_logic;
	signal s_cnt : std_logic_vector(size_cnt-1 downto 0);

	signal s_ref : std_logic_vector(size_in-1 downto 0);
	signal s_mult : std_logic_vector(size_mult-1 downto 0);
	signal s_add : std_logic_vector(size_add-1 downto 0);

begin 

	comp_pile_ref : entity pile
	generic map ( taille_pile => size_pile;
        		  taille_data => size_in)
	port map ( 	din => d_in,
				rotate => s_calc,
				clock => clk,
				load => s_ld_pile_ref,
				raz => s_raz_pile_ref,
				dout => s_ref
	);
