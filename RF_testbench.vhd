library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity RF_testbench is
end entity;



architecture testing of RF_testbench is


	component RF is
		port ( A1,A2,A3 : in std_logic_vector( 2 downto 0) ;
			 D3 : in std_logic_vector( 15 downto 0 ) ;  
			 D1,D2 : out std_logic_vector(15 downto 0) ;
			 rf_write, clk : in std_logic ) ;
	end component ;
	
	
	signal D1,D2,D3 : std_logic_vector (15 downto 0) := "0000000000000000" ;
	signal rf_write, clk : std_logic := '0' ;
	signal A1,A2,A3 : std_logic_vector (2 downto 0) := "000";
	
	
	
	begin 
		dut_inst : RF port map (A1 => A1,A2 => A2, A3 => A3, D1 => D1, D2 => D2 , D3 => D3, rf_write => rf_write, clk => clk ) ;
		
		process 
		
			begin 
			
			clk <= '0' ;
			A2  <= "001" ;
			
			wait for 50 ns;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			rf_write <= '1' ;
			A3 <= "000" ;
			D3 <= "0000000000000001" ;	
			
			wait for 50 ns;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			A3 <= "010" ;
			D3 <= "0000000000000011" ;	
			
			wait for 50 ns;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			
			wait for 50 ns;
			A1 <= "010" ;
			rf_write <= '0' ;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			D3 <= "0000001110000011" ;
			wait for 50 ns;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			
			wait for 50 ns;
			rf_write <= '1' ;
			A3 <= "011";
			A1 <= "011" ;
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			
			wait for 50 ns;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			clk <= '0' ;
			
			wait for 50 ns;
			
			clk <= '1' ;
			
			wait for 50 ns ;
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		end process ;
	
	














end testing ;