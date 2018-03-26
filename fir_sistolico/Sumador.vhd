----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    22:56:55 12/22/2014 
-- Design Name: 
-- Module Name:    Sumador - Behavioral 
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

entity Sumador is
    Port ( clk_in : in  STD_LOGIC;
           a : in  STD_LOGIC_VECTOR (35 downto 0);
           b : in  STD_LOGIC_VECTOR (35 downto 0);
           s : out  STD_LOGIC_VECTOR (35 downto 0));
end Sumador;

architecture Behavioral of Sumador is

signal op1 : signed (35 downto 0):=x"000000000";
signal op2 : signed (35 downto 0):=x"000000000";

begin
process(clk_in)
begin

op1<= signed(a);
op2<= signed(b);
s <= std_logic_vector (op1 + op2);

end process;


end Behavioral;

