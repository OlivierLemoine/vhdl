library IEEE;
use IEEE.std_logic_1164.all;



entity registre is
  
  generic (taille : integer :=4);
  
port(   clk,reset  :   in std_logic;
    E        :   in std_logic_vector(taille-1 downto 0);
    S       :   out std_logic_vector(taille-1 downto 0));
end registre;
 
architecture arch_registre of registre is
begin
    process(clk,reset)
        begin
        if reset='1' then S <= (others => '0');
        elsif rising_edge(clk) then
            S <= E;
        end if;
    end process;
end arch_registre;
