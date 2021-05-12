library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;

entity main_memory is
	
	port (address, data_in : in std_logic_vector (15 downto 0) ;
	mem_write ,clk: in std_logic ;
	data_out : out std_logic_vector ( 15 downto 0) ) ;

end entity ;


architecture main of main_memory is


	type memory_array is array (65536 downto 0 ) of std_logic_vector (15 downto 0) ;
	
	signal Memory : memory_array := (others =>  "0000000000000000" ) ;
	
	
	begin 
	
	data_out <= Memory (conv_integer(address)) ;
	
	process (clk,mem_write,address,data_in)
	
	
	
	begin
	
		if(mem_write = '1') then
			if(rising_edge(clk)) then
				Memory(conv_integer (address)) <= data_in ;
			end if ;
		
		end if ;
		
	
	
	
	end process ;











end main ;