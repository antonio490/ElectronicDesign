----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    17:14:30 10/16/2014 
-- Design Name: 
-- Module Name:    contupdown - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: Counter with up and down functionality
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

entity contupdown is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           CE_in : in  STD_LOGIC;
           Load_in : in  STD_LOGIC;
           Data_in : in  STD_LOGIC_VECTOR (4 downto 0);
           Data_out : out  STD_LOGIC_VECTOR (4 downto 0);
           FC_out : out  STD_LOGIC;
           updown : in  STD_LOGIC);
end contupdown;

architecture Behavioral of contupdown is

signal cuenta : unsigned (4 downto 0);
constant unsigned_length: integer :=5;

begin
process (clk, reset) 
begin
   if reset='1' then 
      cuenta <= (others => '0');
   elsif clk='1' and clk'event then
      if CE_in='1' then
         if Load_in='1' then
            cuenta <= unsigned(Data_in);
         else 
            if updown='1' then 
					cuenta <= cuenta + 1;
					if (cuenta=28) then 
					FC_out<='1';
					cuenta<= to_unsigned(3,unsigned_length);
					 
					else FC_out<= '0';
					end if;
					
            elsif updown= '0' then
					cuenta <= cuenta - 1;
					if (cuenta=3) then 
					FC_out<='1';
					cuenta <= to_unsigned(28,unsigned_length);
					
					else FC_out<='0';
					end if;
						
            end if;
         end if;
      end if;
   end if;

end process;

Data_out <= std_logic_vector(cuenta);

end Behavioral;

