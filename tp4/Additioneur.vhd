
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity add is
  
  generic (size_add : integer :=4);
  
port(       A,B     :   in std_logic_vector(size_add-1 downto 0);
            result  :   out std_logic_vector(size_add-1 downto 0)
			);
            
end add;
 
architecture arch_add of add is
  
signal tmp : std_logic_vector (size_add downto 0); 
  
begin
    result <= std_logic_vector(unsigned(A) + unsigned(B));
    
end arch_add;


