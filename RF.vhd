library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity RF is
	port ( A1,A2,A3 : in std_logic_vector( 2 downto 0) ;
			 D3 : in std_logic_vector( 15 downto 0 ) ;  
			 D1,D2 : out std_logic_vector(15 downto 0) ;
			 rf_write, clk : in std_logic ) ;
end entity ;


architecture handler of RF is

	type register_array is array(7 downto 0) of std_logic_vector(15 downto 0) ;
	
	signal Memory : register_array := ( "0000000000000111",
	  "0000000000000110",
	  "0000000000000101",
	  "0000000000000100" ,
	  "0000000000000011" ,
	  "0000000000000010" ,
	  "0000000000000001" ,
	  "0000000000000000" ) ;

	begin
	
	D1 <= Memory(conv_integer(A1));
	D2 <= Memory(conv_integer(A2));

--	Memory(2) <= "0001100110011010";

	process ( rf_write,A3,D3,clk )
	
	
	
		begin
		
		if(rf_write = '1') then
			if(rising_edge(clk)) then
				Memory(conv_integer(A3)) <= D3 ;
			end if;
		end if;
		
		
	end process ;




end handler ;