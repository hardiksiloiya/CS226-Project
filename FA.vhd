library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;



entity FA is
	port ( a,b,cin : in std_logic ; cout, sum : out std_logic) ;
end entity ;



architecture adding of FA is


	begin
	
	
	sum <= (a xor b xor cin) ;
	cout <= (a and b) or (a and cin ) or (b and cin ) ;
	


end adding ;
