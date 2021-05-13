library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;



entity extender_6bit is
	port ( inp : in std_logic_vector ( 5 downto 0) ; output : out std_logic_vector (15 downto 0)) ;

end entity;


architecture extend of extender_6bit is

	begin
		
		output(5 downto 0) <= inp ;
		
		process(inp)
		
		begin
			if(inp(5) = '1') then
				output(15 downto 6) <= "1111111111" ;
			else 
			
				output(15 downto 6) <= "0000000000" ;
			end if ;
		
		end process ;
			

		





end extend ;