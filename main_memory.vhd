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


	type memory_array is array (300 downto 0 ) of std_logic_vector (15 downto 0) ;
	
	signal Memory : memory_array :=  (
	0 => "0001101110010101", 1 =>  "0101110111000001" , 2 =>  "0111001000000000" ,
	others => x"0000" 
	);
	
	
-- initialize the instruction set over here





																	-- ADI : "0001,101,110,010101" ;
																	-- SW  : "0101,110,111,000001" ;
																	-- ADD : "0000,010,111,000,000" ;
																	-- (opcode, source, dest, offset) ;
																	
																	-- NDU : "0010,110,101,111,000" ;
																	-- LW  : "0100,001,111,000001" ; should run after store is performed
																	-- LA  : "0110,001,000,000000" ; should run after enough SW, or SA are performed 
																	-- SA  : "0111,001,000,000000" ; should run only after registers having some valid value
																	-- BEQ : "1100,001,010,000010" ;
																	-- JAL : "1000,001,000,000010" ; 
																	-- JLR : "1001,001,010,000000" ;

	
	
	begin 
	
	data_out <= Memory (conv_integer(address)) ;

	
	process (clk,mem_write,address,data_in)
	
	

	begin
	
		if(mem_write = '1') then
			if(rising_edge(clk) ) then
				Memory(conv_integer(address)) <= data_in  ;
			end if ;
		
		end if ;
		
	
	
	
	end process ;











end main ;