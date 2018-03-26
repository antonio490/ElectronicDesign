----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:25:25 12/22/2014 
-- Design Name: 
-- Module Name:    Filtro - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Filtro is
    Port ( clk_in : in  STD_LOGIC;
           rst_in : in  STD_LOGIC;
           din : in  STD_LOGIC_VECTOR (17 downto 0);
           dout : out  STD_LOGIC_VECTOR (17 downto 0);
           coeff : in  STD_LOGIC_VECTOR (17 downto 0);
           dir : out  STD_LOGIC_VECTOR (5 downto 0);
           dataout_valid : out  STD_LOGIC);
end Filtro;

COMPONENT Rom
  PORT (
    clka : IN STD_LOGIC;
    addra : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(17 DOWNTO 0)
  );
END COMPONENT;

COMPONENT multiplicador
	PORT(
		clk_in : IN std_logic;
		coeficiente : IN std_logic_vector(17 downto 0);
		dato_in : IN std_logic_vector(17 downto 0);          
		sal : OUT std_logic_vector(35 downto 0)
		);
END COMPONENT;

COMPONENT Ram
	PORT(
		x_in : IN std_logic_vector(17 downto 0);
		clk_in : IN std_logic;
		reset_in : IN std_logic;          
		x_out : OUT std_logic_vector(17 downto 0)
		);
END COMPONENT;

signal N: integer:=33;
type aux is array (N-1 downto 0) of std_logic (17 downto 0);
type z_aux is array (N-1 downto 0) of std_logic (35 downto 0);
signal d : std_logic_vector (17 downto 0);
signal coef: aux;
signal x: aux;
signal z: z_aux;

architecture Behavioral of Filtro is

begin

	Inst_Ram: Ram PORT MAP(
		x_in => din,--datos de entrada 
		x_out => d,--salida de la ram conectada con multiplicador
		clk_in => clk_in,
		reset_in =>rst_in 
	);
	
	registro_rom: Rom
	PORT MAP (
    clka => clk_in,
    addra => open,--aumentar direccion en bloque de control
    douta => coef(i)
  );


	multiplicadores:
   for i in 0 to 32 generate
      begin
      Inst_multiplicador: multiplicador PORT MAP(
		clk_in => clk_in,
		coeficiente => coef(i),--array de señales
		dato_in => x(i),--salida de la ram
		sal => z(i) -- salida del multiplicador
	);
   end generate;
		





end Behavioral;

