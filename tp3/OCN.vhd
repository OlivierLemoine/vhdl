library IEEE;
use IEEE.std_logic_1164.all;
use work.all;
 
 
entity OCN is
  
  generic (taille_ocn : integer :=4);
  
  port( clk,reset  :   in std_logic;
        delta_phi :    in std_logic_vector(taille_ocn-1 downto 0);
        phase  :       out std_logic_vector(taille_ocn-1 downto 0);
        top_synchro :  out std_logic
      );
  
end OCN;

architecture arch_OCN of OCN is 

    signal out_add : std_logic_vector(taille_ocn-1 downto 0);
    signal out_reg : std_logic_vector(taille_ocn-1 downto 0);
    
begin
  
  add_comp : entity add 
  generic map(taille => taille_ocn)
  port map(
    A => out_reg,
    B => delta_phi,
    result => out_add,
    overflow => top_synchro
  );
    
  reg_comp : entity registre 
  generic map(taille => taille_ocn)
  port map(
    clk => clk,
    reset => reset,
    E => out_add,
    S => out_reg
  );
    
    phase <= out_reg;
    
end arch_OCN;