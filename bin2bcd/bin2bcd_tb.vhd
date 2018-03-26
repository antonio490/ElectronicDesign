--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
--
-- Create Date:   12:40:23 11/04/2014
-- Design Name:   
-- Module Name:   C:/Xilinx/13.2/ISE_DS/Proyectos/Practica1/bin2bcd_tb.vhd
-- Project Name:  updowncount
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: bin2bcd
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY bin2bcd_tb IS
END bin2bcd_tb;
 
ARCHITECTURE behavior OF bin2bcd_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT bin2bcd
    PORT(
         DecBin_in : IN  std_logic_vector(5 downto 0);
         clk_in : IN  std_logic;
         DecLapso_in : IN  std_logic;
         DecBcdDec_out : OUT  std_logic_vector(3 downto 0);
         DecBcdUni_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal DecBin_in : std_logic_vector(5 downto 0) := (others => '0');
   signal clk_in : std_logic := '0';
   signal DecLapso_in : std_logic := '0';

 	--Outputs
   signal DecBcdDec_out : std_logic_vector(3 downto 0);
   signal DecBcdUni_out : std_logic_vector(3 downto 0);

   -- Clock period definitions
   constant clk_in_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: bin2bcd PORT MAP (
          DecBin_in => DecBin_in,
          clk_in => clk_in,
          DecLapso_in => DecLapso_in,
          DecBcdDec_out => DecBcdDec_out,
          DecBcdUni_out => DecBcdUni_out
        );

   -- Clock process definitions
   clk_in_process :process
   begin
		clk_in <= '0';
		wait for clk_in_period/2;
		clk_in <= '1';
		wait for clk_in_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin	

		
      -- hold reset state for 100 ns.
      --wait for 100 ns;
		DecLapso_in <='0';	
		DecBin_in <= "001010";	
		wait for clk_in_period*10;
		
		DecLapso_in <='0';	
		DecBin_in <= "001110";	
		wait for clk_in_period*10;
		
		DecLapso_in <='0';	
		DecBin_in <= "110101";	
		wait for clk_in_period*10;
		
		

      -- insert stimulus here 

      wait;
   end process;

END;
