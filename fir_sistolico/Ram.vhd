----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    11:06:52 12/22/2014 
-- Design Name: 
-- Module Name:    Ram - Behavioral 
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

entity Ram is
    Port ( x_in : in  STD_LOGIC_VECTOR (17 downto 0);
           x_out : out  STD_LOGIC_VECTOR (17 downto 0);
           clk_in : in  STD_LOGIC;
           reset_in : in  STD_LOGIC);
end Ram;

architecture Behavioral of Ram is

signal N: integer:=33;
type ram is array (N-1 downto 0) of std_logic_vector (17 downto 0);
signal auxout:ram;


begin

process(clk_in,reset_in)
begin

	if reset_in='1' then

		auxout(N-1 downto 0)<=(others=>x"0000"&"00");
		x_out<=x"0000"&"00";

	else if clk_in'event and clk_in='1' then
	
		auxout(0)<=x_in;
		auxout(N-1 downto 1)<= auxout(N-2 downto 0);
		x_out<=auxout(N-1);--momento adecuado???

	end if;
	end if;
end process; 


end Behavioral;

