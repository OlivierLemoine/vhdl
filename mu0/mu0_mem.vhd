-- TP1 mu0 - assemblage entités mu0 et mémoire - entité de plus haut rang à simuler pour faire fonctionner l'ensemble

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.all;

entity mu0_mem is
  port (clk : in std_logic;
  reset : in std_logic;
  data_bus : inout std_logic_vector(15 downto 0);
  addr_bus : inout std_logic_vector(11 downto 0)
);
   
  end mu0_mem;

architecture arch_mu0_mem of mu0_mem is
signal MEMRQ	: std_logic;						-- memory request
signal RNW		: std_logic;						 -- read/write op
begin

mu0_comp entity mu0 port map (
	clk => clk,
	reset => reset,
	addr_bus => addr_bus,
	data_bus => data_bus,
	mem_rq => MEMRQ,
	rnw => RNW
);


ram0_comp entity ram0 port map(
	clk => clk,
	addr_bus => addr_bus,
	data_bus => data_bus,
	MEMrq => MEMRQ,
	RnW => RNW
);

end arch_mu0_mem;