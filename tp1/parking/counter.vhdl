library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
 
entity counter is
port(
    clk, reset  :  in  std_logic;
    up, down    :    in  std_logic;
    count       :   out std_logic_vector(3 downto 0));
end counter;
 
architecture arch_counter of counter is
signal count_int : unsigned (3 downto 0);
begin
    process(clk,reset)
        begin
            if reset='1' then count_int <= (others => '0');
            elsif rising_edge(clk) then 
                if up='1' then          
                    if count_int<"1111" then 
                        count_int <= count_int + 1; -- "+"(unsigned,int)
                    end if;
                elsif down='1' then          
                    if count_int>"0000" then 
                        count_int <= count_int - 1; -- "-"(unsigned,int)
                    end if;
                end if;
            end if;
    end process;
 
    count <= std_logic_vector(count_int); -- count copie de count_int
 
end arch_counter;