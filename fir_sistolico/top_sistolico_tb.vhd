--------------------------------------------------------------------------------
-- Diseño Electrónico - GITT - Curso 2014/15
-- Alfredo Gardel vicente y Miguel Ángel García Garrido
-- 
-- TestBench de simulación de filtrofir.vhd
--
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE std.textio.ALL;
 
ENTITY top_sistolico_tb IS
END top_sistolico_tb;
 
ARCHITECTURE behavior OF top_sistolico_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Top_sistolico
    PORT(
         clk : IN  std_logic;
         rst_n : IN  std_logic;
         datain : IN  std_logic_vector(17 downto 0);
         datain_valid : IN  std_logic;
         dataout : OUT  std_logic_vector(17 downto 0);
         dataout_valid : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst_n : std_logic := '0';
   signal datain : std_logic_vector(17 downto 0) := (others => '0');
   signal datain_valid : std_logic := '0';

 	--Outputs
   signal dataout : std_logic_vector(17 downto 0);
   signal dataout_valid : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN

 
	-- Instantiate the Unit Under Test (UUT)
   uut: Top_sistolico PORT MAP (
          clk => clk,
          rst_n => rst_n,
          datain_valid => datain_valid,
          datain => datain,
          dataout_valid => dataout_valid,
          dataout => dataout
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
		variable datain_line : line;
		variable aux : integer;
		file datain_file : text open read_mode is "C:\Xilinx\13.2\ISE_DS\Proyectos\fir_sistolico_nuevo\practica_final_2014\datain_33.txt";	
	
   begin		
      -- hold reset state for 100 ns.
		rst_n <= '0';
		wait for 100 ns;------****100ns	
		wait until clk'event and clk='1';
		rst_n <= '1';
		wait for clk_period*10;---------******10clk

			datain_valid <= '1';

      -- insert stimulus here 
		while not endfile(datain_file)
		loop        
			readline(datain_file,datain_line);
			read(datain_line,aux);
			datain <= std_logic_vector(to_signed(aux,datain'length));
			datain_valid <= '1';
			wait for clk_period;
			datain_valid <= '0';
			wait for clk_period;  -- al menos hasta que se haya obtenido el dato de salida								
		end loop;	

		file_close(datain_file);
	
		assert FALSE 
			report "Finalizacion controlada de la sinulacion"
			severity failure;   

   end process;     -- Stimulus process



   -- salidas process
   salidas_proc: process
		variable dataout_line : line;
		variable aux : integer;
		file dataout_file : text open write_mode is "C:\Xilinx\13.2\ISE_DS\Proyectos\fir_sistolico_nuevo\dataout_33.txt";
   begin		

		loop  -- bucle infinito de recogida de datos de salida      
			wait for clk_period;
			
			if dataout_valid = '1' then  -- en este caso se escribe un nuevo valor en el fichero de salida
				aux := to_integer(signed(dataout));
				write (dataout_line, aux);
				writeline(dataout_file, dataout_line);
			end if;
										
		end loop;	
		
   end process;   -- salidas process

	
END;