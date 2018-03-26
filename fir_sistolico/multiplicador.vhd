----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    11:32:03 12/22/2014 
-- Design Name: 
-- Module Name:    multiplicador - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
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

entity multiplicador is
    Port ( clk_in : in STD_LOGIC;
			  coeficiente : in  STD_LOGIC_VECTOR (17 downto 0);
           dato_in : in  STD_LOGIC_VECTOR (17 downto 0);
           sal : out  STD_LOGIC_VECTOR (35 downto 0));
end multiplicador;

architecture Behavioral of multiplicador is

signal op1 : signed (17 downto 0);
signal op2 : signed (17 downto 0);
--signal m: signed (35 downto 0);
signal resul: signed (35 downto 0);


begin
process(clk_in)
begin

	if clk_in ='1' and clk_in'event then

		op1<= signed (coeficiente);
		op2<= signed (dato_in);
		sal<= std_logic_vector(op1 * op2); --36 bits 
		--resul<= m (35 downto 18); --acotamos la salida a 18 bits

end if;


--sal<= std_logic_vector(resul); 

end process;


end Behavioral;

