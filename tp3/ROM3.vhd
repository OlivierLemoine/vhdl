library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all; -- types signed / unsigned (calcul)
 
entity rom3 is
  
  generic( taille_bit : integer :=9);
  
  port( adresse : in std_logic_vector(taille_bit-1 downto 0);
        donnee : out std_logic_vector(7 downto 0));
 end rom3;
  
architecture arch_rom3 of rom3 is
type memory is array(integer range 0 to 2**taille_bit-1) of std_logic_vector(7 downto 0);
    constant mem : memory :=(
    
    "01101110","01101101","01101100","01101100","01101011","01101010","01101001","01101000","01100111","01100110","01100101","01100100","01100011","01100011","01100010","01100001","01011111","01011110","01011101","01011100","01011011","01011010","01011001","01011000","01010111","01010110","01010101","01010011","01010010","01010001","01010000","01001111","01001101","01001100","01001011","01001010","01001000","01000111","01000110","01000100","01000011","01000010","01000000","00111111","00111110","00111100","00111011","00111010","00111000","00110111","00110101","00110100","00110011","00110001","00110000","00101110","00101101","00101011","00101010","00101000","00100111","00100101","00100100","00100010","00100001","00011111","00011110","00011100","00011011","00011001","00011000","00010110","00010101","00010011","00010010","00010000","00001111","00001101","00001011","00001010","00001000","00000111","00000101","00000100","00000010","00000001","11111111","11111101","11111100","11111010","11111001","11110111","11110110","11110100","11110011","11110001","11101111","11101110","11101100","11101011","11101001","11101000","11100110","11100101","11100011","11100010","11100000","11011111","11011101","11011100","11011010","11011001","11010111","11010110","11010100","11010011","11010001","11010000","11001110","11001101","11001100","11001010","11001001","11000111","11000110","11000101","11000011","11000010","11000000","10111111","10111110","10111100","10111011","10111010","10111001","10110111","10110110","10110101","10110100","10110010","10110001","10110000","10101111","10101101","10101100","10101011","10101010","10101001","10101000","10100111","10100101","10100100","10100011","10100010","10100001","10100000","10011111","10011110","10011101","10011100","10011011","10011010","10011001","10011000","10011000","10010111","10010110","10010101","10010100","10010011","10010011","10010010","10010001","10010000","10010000","10001111","10001110","10001101","10001101","10001100","10001011","10001011","10001010","10001010","10001001","10001001","10001000","10001000","10000111","10000111","10000110","10000110","10000101","10000101","10000101","10000100","10000100","10000100","10000011","10000011","10000011","10000010","10000010","10000010","10000010","10000010","10000010","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000001","10000010","10000010","10000010","10000010","10000010","10000011","10000011","10000011","10000011","10000100","10000100","10000100","10000101","10000101","10000101","10000110","10000110","10000111","10000111","10001000","10001000","10001001","10001001","10001010","10001010","10001011","10001100","10001100","10001101","10001110","10001110","10001111","10010000","10010000","10010001","10010010","10010011","10010100","10010100","10010101","10010110","10010111","10011000","10011001","10011010","10011011","10011100","10011101","10011101","10011110","10011111","10100001","10100010","10100011","10100100","10100101","10100110","10100111","10101000","10101001","10101010","10101011","10101101","10101110","10101111","10110000","10110001","10110011","10110100","10110101","10110110","10111000","10111001","10111010","10111100","10111101","10111110","11000000","11000001","11000010","11000100","11000101","11000110","11001000","11001001","11001011","11001100","11001101","11001111","11010000","11010010","11010011","11010101","11010110","11011000","11011001","11011011","11011100","11011110","11011111","11100001","11100010","11100100","11100101","11100111","11101000","11101010","11101011","11101101","11101110","11110000","11110001","11110011","11110101","11110110","11111000","11111001","11111011","11111100","11111110","11111111","00000001","00000011","00000100","00000110","00000111","00001001","00001010","00001100","00001101","00001111","00010001","00010010","00010100","00010101","00010111","00011000","00011010","00011011","00011101","00011110","00100000","00100001","00100011","00100100","00100110","00100111","00101001","00101010","00101100","00101101","00101111","00110000","00110010","00110011","00110100","00110110","00110111","00111001","00111010","00111011","00111101","00111110","01000000","01000001","01000010","01000100","01000101","01000110","01000111","01001001","01001010","01001011","01001100","01001110","01001111","01010000","01010001","01010011","01010100","01010101","01010110","01010111","01011000","01011001","01011011","01011100","01011101","01011110","01011111","01100000","01100001","01100010","01100011","01100100","01100101","01100110","01100111","01101000","01101000","01101001","01101010","01101011","01101100","01101101","01101101","01101110","01101111","01110000","01110000","01110001","01110010","01110011","01110011","01110100","01110101","01110101","01110110","01110110","01110111","01110111","01111000","01111000","01111001","01111001","01111010","01111010","01111011","01111011","01111011","01111100","01111100","01111100","01111101","01111101","01111101","01111110","01111110","01111110","01111110","01111110","01111110","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111111","01111110","01111110","01111110","01111110","01111110","01111101","01111101","01111101","01111101","01111100","01111100","01111100","01111011","01111011","01111011","01111010","01111010","01111001","01111001","01111000","01111000","01110111","01110111","01110110","01110110","01110101","01110100","01110100","01110011","01110010","01110010","01110001","01110000","01110000","01101111"
  
  );
  begin 
    donnee <= mem(to_integer(unsigned(adresse)));
end arch_rom3;
