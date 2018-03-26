----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    13:06:20 10/16/2014 
-- Design Name: 
-- Module Name:    contador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description:  4 bits up counter
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

entity contador is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           CE_in : in  STD_LOGIC;
           Load_in : in  STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (3 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (3 downto 0));
end contador;

architecture Behavioral of contador is
signal cuenta : unsigned (3 downto 0);

begin
--proceso secuencial 
process (clk, reset) 
begin
   if reset='1' then 
      cuenta <= (others => '0');
   elsif clk='1' and clk'event then
      if CE_in='1' then
			if Load_in = '1' then
				cuenta <= unsigned(Data_in) ;
			else
				cuenta <= cuenta + 1;
			end if;
		end if;
   end if;

end process;

Data_out <= std_logic_vector(cuenta);
end Behavioral;

