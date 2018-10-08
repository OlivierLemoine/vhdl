library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
 
entity add is
  
  generic (taille : integer :=4);
  
port(       A,B     :   in std_logic_vector(taille-1 downto 0);
            result  :   out std_logic_vector(taille-1 downto 0);
            overflow:   out std_logic );
            
end add;
 
architecture arch_add of add is
  
signal tmp : std_logic_vector (taille downto 0); 
  
begin
    tmp <= std_logic_vector(unsigned('0' & A) + unsigned('0' & B));
    
    overflow <= tmp(taille);
    
    result <=  tmp(taille-1 downto 0); 
    
end arch_add;
