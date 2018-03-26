--------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
--
-- Create Date:   17:53:59 10/16/2014
-- Design Name:   
-- Module Name:   C:/Xilinx/13.2/ISE_DS/Proyectos/contupdown/contupdown_tb.vhd
-- Project Name:  contupdown
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: contupdown
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
USE ieee.numeric_std.ALL;
 
ENTITY contupdown_tb IS
END contupdown_tb;
 
ARCHITECTURE behavior OF contupdown_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT contupdown
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         CE_in : IN  std_logic;
         Load_in : IN  std_logic;
         Data_in : IN  std_logic_vector(4 downto 0);
         Data_out : OUT  std_logic_vector(4 downto 0);
         FC_out : OUT  std_logic;
         updown : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '1';
   signal CE_in : std_logic := '0';
   signal Load_in : std_logic := '0';
   signal Data_in : std_logic_vector(4 downto 0) := (others => '0');
   signal updown : std_logic := '0';

 	--Outputs
   signal Data_out : std_logic_vector(4 downto 0);
   signal FC_out : std_logic:= '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: contupdown PORT MAP (
          clk => clk,
          reset => reset,
          CE_in => CE_in,
          Load_in => Load_in,
          Data_in => Data_in,
          Data_out => Data_out,
          FC_out => FC_out,
          updown => updown
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		
		reset <= '0';
	
		CE_in <= '1';
		
		--Load_in <= '1';
		
		--Data_in <= "00101";
		
		updown <= '1';
		
		
      -- hold reset state for 100 ns.
      wait for 1000 ns;	
		
		
		reset <= '1';
		--habilita reset

		wait for clk_period*10;
		
		reset <= '0';
		
		Load_in<='1';
		
		Data_in<="00101";
		
		wait for clk_period*10;

		Load_in<='0';
		
		reset <= '0';
		
		CE_in <= '1';
      
		updown <= '0';
		--cuenta descendente
		
		
		wait for clk_period*10;
		

      wait;
   end process;

END;
