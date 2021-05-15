library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity extender_9bit_signed is
	
	port (a : in std_logic_vector (8 downto 0) ; output : out std_logic_vector (15 downto 0)) ;
end entity ;



architecture ext of extender_9bit_signed is




	begin 



		output(8 downto 0) <= a ;
		
		
		process (a)
		
		begin
		
		
			if(a(8) = '1') then
				output(15 downto 9) <= "1111111" ;
			else
				output(15 downto 9) <= "0000000" ;
			
			end if;
			
		end process ;






end ext ;