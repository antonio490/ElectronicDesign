----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    10:13:19 11/04/2014 
-- Design Name: 
-- Module Name:    bin2bcd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: synchronous counter with 8 bits binary entry and conversion with bcd decoder
-- output count 0 - 60
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity bin2bcd is
    Port ( DecBin_in : in  STD_LOGIC_VECTOR (5 downto 0);
           clk_in : in  STD_LOGIC;
           DecLapso_in : in  STD_LOGIC;
           DecBcdDec_out : out  STD_LOGIC_VECTOR (3 downto 0);
           DecBcdUni_out : out  STD_LOGIC_VECTOR (3 downto 0));
end bin2bcd;

architecture Behavioral of bin2bcd is

signal salida : integer ; 
signal salida_uni : integer:= 0;
signal salida_dec : integer:= 0;

begin

process(clk_in, DecLapso_in, DecBin_in)
begin
 
if  DecLapso_in = '0' then
case DecBin_in is

when "000000" => salida <= 0;
when "000001" => salida <= 1;
when "000010" => salida <= 2;
when "000011" => salida <= 3;
when "000100" => salida <= 4;
when "000101" => salida <= 5;
when "000110" => salida <= 6;
when "000111" => salida <= 7;
when "001000" => salida <= 8;
when "001001" => salida <= 9;
when "001010" => salida <= 10;
when "001011" => salida <= 11;
when "001100" => salida <= 12;
when "001101" => salida <= 13;
when "001110" => salida <= 14;
when "001111" => salida <= 15;
when "010000" => salida <= 16;
when "010001" => salida <= 17;
when "010010" => salida <= 18;
when "010011" => salida <= 19;
when "010100" => salida <= 20;
when "010101" => salida <= 21;
when "010110" => salida <= 22;
when "010111" => salida <= 23;
when "011000" => salida <= 24;
when "011001" => salida <= 25;
when "011010" => salida <= 26;
when "011011" => salida <= 27;
when "011100" => salida <= 28;
when "011101" => salida <= 29;
when "011110" => salida <= 30;
when "011111" => salida <= 31;
when "100000" => salida <= 32;
when "100001" => salida <= 33;
when "100010" => salida <= 34;
when "100011" => salida <= 35;
when "100100" => salida <= 36;
when "100101" => salida <= 37;
when "100110" => salida <= 38;
when "100111" => salida <= 39;
when "101000" => salida <= 40;
when "101001" => salida <= 41;
when "101010" => salida <= 42;
when "101011" => salida <= 43;
when "101100" => salida <= 44;
when "101101" => salida <= 45;
when "101110" => salida <= 46;
when "101111" => salida <= 47;
when "110000" => salida <= 48;
when "110001" => salida <= 49;
when "110010" => salida <= 50;
when "110011" => salida <= 51;
when "110100" => salida <= 52;
when "110101" => salida <= 53;
when "110110" => salida <= 54;
when "110111" => salida <= 55;
when "111000" => salida <= 56;
when "111001" => salida <= 57;
when "111010" => salida <= 58;
when "111011" => salida <= 59;

when others => salida <= 0;

end case;
end if;
end process;

salida_uni <= salida rem 10;
salida_dec <= salida / 10;

DecBcdUni_out <= std_logic_vector (to_unsigned (salida_uni, DecBcdUni_out'length));
DecBcdDec_out <= std_logic_vector (to_unsigned (salida_dec, DecBcdDec_out'length));

end Behavioral;

