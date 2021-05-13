library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity cpu_load is 
	port (clk : in std_logic; instr : in std_logic_vector (15 downto 0);
	output,t1_out,t2_out,t3_out,D1_out,D2_out,D3_out : out std_logic_vector (15 downto 0) ;
	A1_out,A2_out,A3_out :  out std_logic_vector ( 2 downto 0 )) ;
end entity ;

--output is for debugging

architecture load of cpu_load is



	component adder_16bit is
	port( a,b : in std_logic_vector (15 downto 0) ; cin : in std_logic ; sum : out std_logic_vector (15 downto 0) );	
	end component ;

	component RF is 
	port ( A1,A2,A3 : in std_logic_vector( 2 downto 0) ;
			 D3 : in std_logic_vector( 15 downto 0 ) ;  
			 D1,D2 : out std_logic_vector(15 downto 0) ;
			 rf_write, clk : in std_logic ) ;
	end component ;
	
	component main_memory is
	port (address, data_in : in std_logic_vector (15 downto 0) := "0000000000000000" ;
	mem_write ,clk: in std_logic ;
	data_out : out std_logic_vector ( 15 downto 0) ) ;	
	end component ;
	
	

	component extender_6bit is
	port ( inp : in std_logic_vector ( 5 downto 0) ; output : out std_logic_vector (15 downto 0)) ;	
	end component ;
	
	
	
	signal address, data_in, data_out,D1,D2,D3 : std_logic_vector (15 downto 0) ;
	signal rf_write,mem_write : std_logic := '0' ;
	signal A1,A2,A3 : std_logic_vector (2 downto 0) ;
	
	signal t1,t2,t3,t5,t6 : std_logic_vector (15 downto 0) ;
	signal t4 : std_logic_vector(5 downto 0) ;
	signal alu_parity : std_logic := '0' ;


	type state is (S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16);
	
	signal curr_state : state := S0 ;
	
	
	begin

	memory_64 : main_memory port map (address => address, data_in => data_in,mem_write => mem_write,clk => clk ,data_out => data_out) ;
	
	memory_RF : RF port map ( A1 => A1, A2 => A2, A3 => A3, D3 => D3,D1 => D1, D2 => D2,rf_write => rf_write,clk => clk);
	
	ALU : adder_16bit port map (a => t1, b => t2, cin => alu_parity, sum => t3 ) ;
	
	t1_out <= t1;
	t2_out <= t2;
	t3_out <= t3;
	extender : extender_6bit port map ( inp => t4 ,output => t5 ) ;
	A1_out <= A1 ;
	A2_out <= A2 ;
	A3_out <= A3 ;
	D1_out <= D1 ;
	D2_out <= D2 ;
	D3_out <= D3 ;
--	data_in <= D1 ;
	
--	A2 <= instr(8 downto 6) ;
	output <= data_out ;
	
	process (clk,curr_state)
	
	
	variable next_state : state ;
	
	
	
	begin 
	
	
		if (curr_state = S0) then
		
		---deciding the operation based on opcode
			
			if(instr(15 downto 12) = "0100") then
				--
				-- the load operation triggered 
				next_state := S7 ;
				

			
			elsif (instr(15 downto 12) = "0101" ) then
			
				-- the store operations triggered
				next_state := S12 ;
				

			end if ;
			
----begining of load operation sequence			
		elsif (curr_state = S7) then

				next_state := S8 ;
				
				A1 <= instr( 8 downto 6) ;
				
				t1 <= D1 ;
				
				rf_write <='0' ; ---------this is required to stop any ongoing writing process from previous instruction 
				mem_write <= '0' ;
			
			
		elsif (curr_state = S8) then
	

			next_state := S9 ;
			
			t4 <= instr( 5 downto 0) ;
																-- extender in action 
			t2 <= t5 ;
			
			alu_parity <= '0' ;			
			
			--now t3 contains the required address of main_memory

			
		elsif (curr_state = S9) then
		

			next_state := S10 ;
			
			address <= t3 ;



			
		elsif (curr_state = S10) then
			--now data_out contains the required address
			next_state := S0;
		
			rf_write <= '1' ;
			A3 <= instr( 11 downto 9) ;
			D3 <= data_out ;		
		
	
			--finally load operation done, so reset to state S0 ; 
	
------end of load operation sequence

------begining of store operation sequence
		elsif ( curr_state = S12) then

				next_state := S13 ; 
				
				A1 <= instr ( 11 downto 9);
				
				A2 <= instr (8 downto 6) ;
				
				t6 <= D1 ;
				
				t1 <= D2 ;	

				-- now D1 contains the required value to be stored
				-- now D2 has the base address
				
				rf_write <='0' ; ---------this is required to stop any ongoing writing process from previous instruction 
				mem_write <= '0' ;

		elsif (curr_state = S13 )  then 

				next_state := S14 ;
				
				t4 <= instr( 5 downto 0) ;   -- extender in action 
				t2 <= t5 ;
				alu_parity <= '0';
			
			-- now t3 contains the required address of the main memory

		elsif (curr_state = S14) then 
		
				next_state := S0;
				
				
				address <= t3 ;
				data_in <= D1 ;		
				mem_write <= '1' ;
			

		end if ;
		
		
		
		
		-------------------clock part
	
	
		if(rising_edge(clk)) then
			curr_state <= next_state ;
		end if ;
		
	
	
	
	
	end process ;
	
	
	
	
	
	
	
	
end load ;
	
	
	
	
	



