library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity extender_9bit is
	port ( a : in std_logic_vector (8 downto 0) ; output : out std_logic_vector (15 downto 0)  ) ;
end entity ;




architecture Nine of extender_9bit is



	begin
	
		output (15 downto 7) <= a ;
		output (6 downto 0) <= "0000000" ;







end Nine ;