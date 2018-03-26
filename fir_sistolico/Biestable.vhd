----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    12:16:03 12/25/2014 
-- Design Name: 
-- Module Name:    Biestable - Behavioral 
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

entity Biestable is
    Port ( clk_in : in  STD_LOGIC;
           D : in  STD_LOGIC_VECTOR (35 downto 0);
           Q : out  STD_LOGIC_VECTOR (35 downto 0));
end Biestable;


architecture Behavioral of Biestable is

signal aux1 : std_logic_vector (35 downto 0):=x"000000000";
signal aux2 : std_logic_vector (35 downto 0):=x"000000000";
signal aux3 : std_logic_vector (35 downto 0):=x"000000000";
signal aux4 : std_logic_vector (35 downto 0):=x"000000000";

begin
process(clk_in)
begin

	if clk_in'event and clk_in='1' then
		aux1<= D;--la salida es la entrada
		aux2<= aux1;
		aux3<= aux2;
		aux4<= aux3;
		Q<= aux4;

	end if;		
end process;
end Behavioral;

