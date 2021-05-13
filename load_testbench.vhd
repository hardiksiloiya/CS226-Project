library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity load_testbench is 
end load_testbench; 




architecture load_tester of load_testbench is


	component cpu_load is
	port (clk : in std_logic; instr : in std_logic_vector (15 downto 0);
	output,t1_out,t2_out,t3_out,D1_out,D2_out,D3_out : out std_logic_vector (15 downto 0) ;
	A1_out,A2_out,A3_out :  out std_logic_vector ( 2 downto 0 )) ;
	end component ;


	signal clk : std_logic ;
	signal instr : std_logic_vector (15 downto 0) := "0101110111111111" ;
	
																	-- (opcode, source, dest, offset)			

	signal t1,t2,t3 : std_logic_vector (15 downto 0) ;	
	signal A1,A2,A3 : std_logic_vector (2 downto 0) ;
	signal D1,D2,D3,output : std_logic_vector (15 downto 0) ;

 
																-- next instr "0100,110,111,001011" ;
	begin
	
	
	dut_inst : cpu_load port map (clk => clk, instr => instr ,output => output ,
	t1_out => t1,t2_out => t2,t3_out => t3 , D1_out => D1, D2_out => D2 , D3_out => D3 ,
	A1_out =>A1, A2_out => A2, A3_out => A3 ) ;

	process 
	
	begin
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	instr <= "0100110101000001" ;
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
	clk <= '0';
	
	wait for 50 ns ;

	clk <= '1' ;
	
	wait for 50 ns ;
	
		
	
	
	
	
	end process ;




end load_tester ;