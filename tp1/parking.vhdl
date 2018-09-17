library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.all;

entity parking is
    port (
        sensor_in : in std_logic;
        sensor_out : in std_logic;
        clk : in std_logic;
        reset : in std_logic;
        ld_reg : in std_logic;
        nb_max : in std_logic_vector(3 downto 0);

        full : out std_logic;
        nb_slots : out std_logic_vector(3 downto 0)
        ) ;
end parking;

architecture arch_parking of parking is

    signal s_up, s_down : std_logic;
    signal s_count, s_val_max : std_logic_vector(3 downto 0);

begin

    edge_detect_1 : entity edge_detector port map (
        clk => clk,
        reset => reset,
        input_signal => sensor_in,
        output_signal => s_up
    );


    edge_detect_2 : entity edge_detector port map (
        clk => clk,
        reset => reset,
        input_signal => sensor_out,
        output_signal => s_down
    );


    counter_1 : entity counter port map (
        clk => clk,
        reset => reset,
        up => s_up,
        down => s_down,
        count => s_count
    );

    registre_1 : entity registre port map(
        clk => clk,
        reset => reset,
        load => ld_reg,
        d_in => nb_max,
        d_out => s_val_max
    );

    comp_1 : entity comp port map(
        A => s_count,
        B => s_val_max,
        result => full
    );

    sub_1 : entity substract port map (
        A => s_count,
        B => s_val_max,
        result => nb_slots
    );




end arch_parking ; -- arch_parking