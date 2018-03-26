----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    23:48:04 12/26/2014 
-- Design Name: 
-- Module Name:    Registro_rom - Behavioral 
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Registro_rom is
    Port ( clk_in : in  STD_LOGIC;
           addra : in  STD_LOGIC_VECTOR (5 downto 0);
           dout : out  STD_LOGIC_VECTOR (17 downto 0));
end Registro_rom;

architecture Behavioral of Registro_rom is


type rom_type is array (32 downto 0) of std_logic_vector (17 downto 0);                 
    signal ROM : rom_type:= (
		"00"&x"0000",
		"11"&x"fd0f",
		"11"&x"f875",
		"11"&x"f176",
		"11"&x"e8c3",
		"11"&x"e0fa",
		"11"&x"de94",
		"11"&x"e723",
		"00"&x"0000",
		"00"&x"2cb5",
		"00"&x"6d95",
		"00"&x"bee4",
		"01"&x"18e8",
		"01"&x"70e9",
		"01"&x"bb0b",
		"01"&x"ec8e",
		"01"&x"fdf4",
		"01"&x"ec8e",
		"01"&x"bb0b",
		"01"&x"70e9",
		"01"&x"18e8",
		"00"&x"bee4",
		"00"&x"6d95",
		"00"&x"2cb5",
		"00"&x"0000",
		"11"&x"e723",
		"11"&x"de94",
		"11"&x"e0fa",
		"11"&x"e8c3",
		"11"&x"f176",
		"11"&x"f875",
		"11"&x"fd0f",
		"00"&x"0000"
);                        

    --signal rdata : std_logic_vector(17 downto 0);
	 signal i: integer :=0;
	 begin
	
    --rdata <= ROM(conv_integer(addra));
		
    process (clk_in)
    begin
        if (clk_in'event and clk_in = '1') then
                
				i<=i+1;
				if i=1 then --mantenemos fijo el coeficiente durante dos ciclos de reloj
				dout <= ROM(conv_integer(addra));
				--dout <= rdata(17 downto 0);
				i<=0;
				end if;
            
        end if;
    end process;


end Behavioral;

