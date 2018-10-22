library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity correlateur is
    generic(
        taille_d_in : integer := 8
    );
    port (
        clock, clke, reset : in std_logic;
        ref : in std_logic;
    ) ;
end correlateur ; 

architecture arch_correlateur of correlateur is
    
begin
    
end architecture ;