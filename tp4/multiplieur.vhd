library ieee ;
    use ieee.std_logic_1164.all ;
    use ieee.numeric_std.all ;

entity multiplieur is
    generic (
        taille : integer := 4
    );
    port (
        A, B    : in std_logic_vector(taille-1 downto 0);
        result  : out std_logic_vector(taille*2-1 downto 0)
    ) ;
end multiplieur ; 

architecture arch_multiplieur of multiplieur is

begin
    result <= std_logic_vector(signed(A) * signed(B));
end architecture ;