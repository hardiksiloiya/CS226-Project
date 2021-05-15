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
	output,t1_out,t2_out,t3_out,D1_out,D2_out,D3_out,PC_out,address_out,data_in_out,data_out_out : out std_logic_vector (15 downto 0) ;
	A1_out,A2_out,A3_out :  out std_logic_vector ( 2 downto 0 );
	rf_write_out,mem_write_out : out std_logic) ;
	end component ;


	signal clk : std_logic ;
	signal instr : std_logic_vector (15 downto 0) := "0110001000000000"  ;
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
															
																	
																	

		
	signal A1,A2,A3 : std_logic_vector (2 downto 0) ;
	signal D1,D2,D3: std_logic_vector (15 downto 0) ;
	signal rf_write : std_logic ;
	signal t1,t2,t3 : std_logic_vector (15 downto 0) ;
	signal mem_write : std_logic ;
	signal address, data_in,data_out : std_logic_vector (15 downto 0) ;
	signal output,PC : std_logic_vector (15 downto 0) ;
 
																-- next instr "0100,110,111,001011" ;
	begin
	
	
	dut_inst : cpu_load port map (clk => clk, instr => instr ,output => output ,
	t1_out => t1,t2_out => t2,t3_out => t3 , D1_out => D1, D2_out => D2 , D3_out => D3 ,PC_out => PC,address_out => address, data_in_out => data_in , data_out_out => data_out,
	A1_out =>A1, A2_out => A2, A3_out => A3 ,rf_write_out => rf_write ,mem_write_out => mem_write) ;

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
--	instr <= "0100110101000001" ;
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