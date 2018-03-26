----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Antonio Sanz
-- 
-- Create Date:    01:16:52 12/23/2014 
-- Design Name: 	
-- Module Name:    Top_sistolico - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: El objetivo de esta practica consiste en dise�ar un filtro fir de 33 coeficientes con estructura sistolica.
-- Para crear la estructura del filtro utilizares la sentencia generate. De Esta forma hemos creado distintos niveles.
-- El primer nivel consiste en 33 multiplicadores donde se multiplica un coeficiente de la rom por un valor de entrada que
-- es almacenado y desplazado por un registro ram. En los siguientes niveles se realiza la suma de los distintos resultados
-- obtenidos por los multiplicadores. El primer nivel de sumadores esta formado por 16 sumadores, el segundos nivel por 8 
-- sumadores, el tercero por 4, el cuarto nivel por 2 sumadores y en quinto nivel se obtiene la suma de ambos resultados
-- obtenidos en el nivel 5. Hasta aqu� tendriamos el dato de salida en caso de que el filtro fuese de 32 coeficientes. 
-- Al realizar el nivel de los multiplicadores, existe una rama correspondiente al coeficiente 33 que no ha sido emparejada
-- con ning�n sumador. Este resultado lo sumaremos al final en un �ltimo sumador con el el resultado del sumador del nivel 5. 



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

entity Top_sistolico is
    Port ( clk : in  STD_LOGIC;
           rst_n : in  STD_LOGIC;
           datain : in  STD_LOGIC_VECTOR (17 downto 0);
           datain_valid : in  STD_LOGIC;
           dataout : out  STD_LOGIC_VECTOR (17 downto 0);
           dataout_valid : out  STD_LOGIC);
end Top_sistolico;

architecture Behavioral of Top_sistolico is


type rom_type is array (32 downto 0) of std_logic_vector (17 downto 0);   --registro rom con 33 coeficientes              
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


signal N: integer:=33;
type mul_aux is array (32 downto 0) of signed (35 downto 0);
signal mul : mul_aux:=(others=>x"000000000"); --vector de se�ales para los multiplicadores
type sum1_aux is array (15 downto 0) of signed (35 downto 0);
signal sum1 : sum1_aux:=(others=>x"000000000"); --vector de se�ales para los sumadores del primer nivel
type sum2_aux is array (7 downto 0) of signed (35 downto 0);
signal sum2 : sum2_aux:=(others=>x"000000000"); --vector de se�ales para los sumadores del segundo nivel
type sum3_aux is array (3 downto 0) of signed (35 downto 0);
signal sum3 : sum3_aux:=(others=>x"000000000"); --vector de se�ales para los sumadores del tercer nivel
type sum4_aux is array (1 downto 0) of signed (35 downto 0);
signal sum4 : sum4_aux:=(others=>x"000000000"); --vector de se�ales para los sumadores del cuarto nivel

signal sum5 : signed (35 downto 0):= x"000000000"; --salida del penultimo sumador
signal reset : std_logic;
signal i: integer:=0;
signal suma_delay : signed (35 downto 0):=x"000000000";
signal salida :signed (35 downto 0):=x"000000000";
type ram is array (N-1 downto 0) of std_logic_vector (17 downto 0);
signal auxout: ram :=(others=>x"0000"&"00");


begin

---------------------------------------------
process(clk, reset)
begin

	if reset='1' then

		auxout(N-1 downto 0)<=(others=>x"0000"&"00");
	
	elsif clk='1' and clk'event then
		
		dataout_valid<='0';
		i<=i+1;
		
		if i=1 then --introducimos un retardo para solucionar problema con el retardo fijo de los valores de entrada (datain).
			auxout(0)<=datain; --valor de entrada almacenado en la primera posicion de la ram
			auxout(N-1 downto 1)<= auxout(N-2 downto 0);--desplazamos ram
			i<=0;
		end if;
		
		
		sum5<= sum4(0)+sum4(1); --penultima suma
		suma_delay<=mul(32); --el ultimo coeficiente debe ser sumado al final
		salida<=sum5 + suma_delay; --ultima suma junto con el resultado del ultimo multiplicador
		dataout<= std_logic_vector(salida(35 downto 18));-- la salida final se acota para un tama�o de 18 bits, cogiendo los bits m�s significativos
	
	if salida/=0 then
		dataout_valid<='1';-- el dataout_valid se mantiene fijo a nivel alto desde el primer momento en que haya un dato valido a la salida.
	end if;
		
	end if;
		
end process;
-----------------------------------------------

reset<= not rst_n; --reset negado

multiplicadores: --conjunto de 33 multiplicadores
   for i in 0 to 32 generate
     begin
         mul(i)<= signed(auxout(i))*signed(ROM(i)); --se realiza la multiplicaci�n de todos los coeficientes por sus respectivos datos de entrada
	
end generate multiplicadores;
	
	
	
nivel1_sum:for i in 0 to 15 generate begin -- primer nivel con 16 sumadores
		process(mul)
      begin
          sum1(i)<= mul(2*i) + mul((2*i)+1);
			
		end process;
end generate nivel1_sum;
	
nivel2_sum: for i in 0 to 7 generate begin -- segundo nivel con 8 sumadores
    
		sum2(i)<=sum1(2*i)+sum1((2*i)+1);
			
end generate nivel2_sum;
	
nivel3_sum: for i in 0 to 3 generate begin -- tercer nivel con 4 sumadores
     
	  sum3(i)<= sum2(2*i)+sum2((2*i)+1);
				
end generate nivel3_sum;
	
nivel4_sum: for i in 0 to 1 generate begin -- cuarto nivel de 2 sumadores
      
		sum4(i)<=sum3(2*i)+sum3((2*i)+1);
				
end generate nivel4_sum;

	

end Behavioral;

