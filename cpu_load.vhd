library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity cpu_load is 
	port (clk : in std_logic; 
	instr_out,t1_out,t2_out,t3_out,D1_out,D2_out,D3_out,PC_out,address_out,data_in_out,data_out_out : out std_logic_vector (15 downto 0) ;
	A1_out,A2_out,A3_out :  out std_logic_vector ( 2 downto 0 );
	c_flag_out,z_flag_out,rf_write_out,mem_write_out : out std_logic ) ;
end entity ;

--output is for debugging

architecture load of cpu_load is



	component adder_16bit is
	port( a,b : in std_logic_vector (15 downto 0) ; cin : in std_logic ; sum : out std_logic_vector (15 downto 0); cout : out std_logic );	
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

	
	component nand_16bit is
	port(a,b: in std_logic_vector(15 downto 0);
		c: out std_logic_vector(15 downto 0));	
	end component ;
	
	
	component extender_9bit is
	port ( a : in std_logic_vector (8 downto 0) ; output : out std_logic_vector (15 downto 0)  ) ;
	end component ;
	
	component extender_9bit_signed is
	
	port (a : in std_logic_vector (8 downto 0) ; output : out std_logic_vector (15 downto 0)) ;	
	end component ;
	
	component zero_checker is
	port(a:in std_logic_vector(15 downto 0);
	     c: out std_logic);
	end component ;
	
	
	
	
	
	signal address, data_in, data_out,D1,D2,D3 : std_logic_vector (15 downto 0) ;
	signal rf_write,mem_write,c_flag,z_flag,cout_1,cout_2,cout_3 ,zero_out: std_logic := '0' ;
	signal A1,A2,A3 : std_logic_vector (2 downto 0) ;
	
	signal instr,t1,t2,t3,t5,t6,t1n,nand_in1,nand_in2,nand_out , e9_out,next_addr,e9s_out,zero_in : std_logic_vector (15 downto 0) ;
	signal t4 : std_logic_vector(5 downto 0) ;
	signal alu_parity : std_logic := '0' ;
	signal  e9_in : std_logic_vector (8 downto 0);
	signal PC, next_A3 : std_logic_vector (15 downto 0) := "0000000000000000" ;
	

	type state is (S_fetch,S0,S1,S2,S3,S4,S5,S6,S7,S8,S9,S10,S11,S12,S13,S14,S15,S16,S17,S18,S19,S20,S21,S22,S23,S24,S25,S26,S27,S28,S29,S30,S31,S32,S33,S34,S35,S36,S37,S38,S39,S40);
	
	signal curr_state : state := S_fetch ;
	
	
	begin

	memory_64 : main_memory port map (address => address, data_in => data_in,mem_write => mem_write,clk => clk ,data_out => data_out) ;
	
	memory_RF : RF port map ( A1 => A1, A2 => A2, A3 => A3, D3 => D3,D1 => D1, D2 => D2,rf_write => rf_write,clk => clk);
	
	ALU : adder_16bit port map (a => t1, b => t2, cin => alu_parity, sum => t3,cout => cout_1 ) ;

	Nander : nand_16bit port map (a=> nand_in1,b=> nand_in2, c=> nand_out) ;
	
	ALU_2 : adder_16bit port map (a=> t1n, b => "0000000000000001", cin => '0'  , sum => next_addr ,cout => cout_2 ) ;
	
	ALU_3 : adder_16bit port map (a => t6, b => "0000000000000001" , cin => '0', sum =>  next_A3 , cout => cout_3) ;

	extender : extender_6bit port map ( inp => t4 ,output => t5 ) ;
	
	extender_9bit_1 : extender_9bit port map ( a => e9_in, output => e9_out) ;
	
	extender_9bit_2 : extender_9bit_signed port map (a => e9_in, output => e9s_out ) ;
	
	zero_checker_component : zero_checker port map (a => zero_in, c=> zero_out);
	
	t1_out <= t1;
	t2_out <= t2;
	t3_out <= t3;
	A1_out <= A1 ;
	A2_out <= A2 ;
	A3_out <= A3 ;
	D1_out <= D1 ;
	D2_out <= D2 ;
	D3_out <= D3 ;
	PC_out <= PC ;
	rf_write_out <= rf_write ;
	mem_write_out <= mem_write ;
	address_out <= address ;
	data_in_out <= data_in ;
	data_out_out <= data_out ;
	instr_out <= instr ;
	c_flag_out <= c_flag ;
	z_flag_out <= z_flag ;
--	data_in <= D1 ;
	
--	A2 <= instr(8 downto 6) ;

	
	process (clk,curr_state)
	
	
	variable next_state : state ;
	

------------opcode map-----------------
--=========  opcode     opcode name======

------------ 0000       Add (ADD, ADC,ADZ)

------------ 0001       ADI

------------ 0010       NDU (NDC, NDZ)

------------ 0011       LHI

------------ 0100       LW

------------ 0101       SW

------------ 0110       LA	
	
------------ 0111       SA	

------------ 1100       BEQ

------------ 1000       JAL

------------ 1001       JLR
	begin 
	
		if(curr_state = S_fetch) then
			
			address <= PC ;
			instr <= data_out ;
			
			next_state := S0 ;
			
			if (falling_edge(clk)) then
			
				rf_write <='0' ; ---------this is required to stop any ongoing writing process from previous instruction 
				mem_write <= '0' ;
			end if ;
	
	
		elsif (curr_state = S0) then
		
		---deciding the operation based on opcode
			
			if( instr(15 downto 12) = "0000") then
			
			-- ADD operation group triggered       S1-S3
			
				
				next_state := S1 ;
				
				t1n <= PC ;         --next_addr will be ready with next PC
			
			elsif (instr(15 downto 12) = "0001") then
			
				-- ADI operation triggered    S4-S7
				next_state := S4 ;
				t1n <= PC ;			
			
			elsif (instr(15 downto 12) = "0010") then
			
				-- NDU operations group triggered    S17-S19 
				next_state := S17 ;	
				t1n <= PC ;

			elsif (instr (15 downto 12) = "0011") then
			
				-- LHI operation triggered     S20- S21
				next_state := S20 ;
	

			elsif(instr(15 downto 12) = "0100") then
				--
				-- the load operation triggered S8-S12
				next_state := S8 ;            
				

			
			elsif (instr(15 downto 12) = "0101" ) then
			
				-- the store operations triggered S13-S16
				next_state := S13 ;
			

			elsif (instr (15 downto 12) = "0110" ) then
			
				-- the load all operation triggered S22-S26
				
				next_state := S22 ;
				
				D3 <= "1111111111111111" ;
				
			elsif (instr (15 downto 12)  = "0111" ) then
			
				-- the store all operation triggered S27-S31

				next_state := S27 ;
				
			elsif (instr (15 downto 12) = "1100" ) then
			
				-- the BEQ operation triggered S32-S33
				
				next_state := S32 ;
			
			elsif (instr (15 downto 12) = "1000" ) then
			
				-- the JAL operation triggered S34-S35
				
				next_state  := S34 ;
			
			elsif (instr (15 downto 12) = "1001" ) then
			
				-- the JLR operation triggered S36-S37
				
				next_state := S36  ;
			
			else
				
				next_state := S_fetch ;

			end if ;
			
			
			

			
			
			
------- begining of ADD operation sequence
		elsif (curr_state = S1 ) then
			
				next_state := S2 ;
				
				PC <= next_addr ;
				
				--next_addr will be ready with next PC
				
				--c_flag checking
				
				if (instr(1) = '1') then
				
					if(c_flag = '1' ) then
					
						next_state := S2 ;
					
					else 
					
						next_state := S0 ;
					
					end if;
				
				--z_flag checking
				
				elsif(instr(0) = '1') then
				
					if(z_flag = '1') then
						
						next_state := S2 ;
					
					else
					
						next_state := S0 ;
						
					end if ;
						
				
				
				end if;
				
				


		elsif (curr_state = S2) then
		
				next_state := S3;
				
				A1 <= instr ( 11 downto 9);
				A2 <= instr ( 8 downto 6) ;
				t1 <= D1 ;
				t2 <= D2 ;			

				alu_parity <= '0' ;
				
				
				
				
			-- now t1, t2 are ready for bein fed to Alu, t3 will be ready at the next cycle
			
		elsif (curr_state = S3 ) then
		
				next_state := S_fetch;
				D3 <= t3 ;
				zero_in <= t3 ;
			-- c_flag update
			
				c_flag <= cout_1 ;
				A3 <= instr (5 downto 3) ;
				
				rf_write <= '1' ;
			-- z_flag update		
				z_flag <= zero_out ;
--------end of ADD operation
		
-------- begining of ADI operation sequence

		elsif (curr_state = S4) then
				
				next_state := S5 ;
				
				PC <= next_addr ;
				

		elsif (curr_state = S5)  then
		
				next_state := S6 ;
				
				A1 <= instr(11 downto 9);
				t1 <= D1 ;
				t4 <= instr(5 downto 0) ;
				
		elsif (curr_state = S6) then
		
				next_state := S7;
				
				t2 <= t5 ;
				
				--now t3 will be ready with the required value
		elsif (curr_state = S7) then
				
				next_state := S_fetch ;
				rf_write <= '1' ;
				A3 <= instr (8 downto 6) ;
				D3 <= t3 ;
				zero_in <= t3 ;
				
				-- c_flag update
				c_flag <= cout_1 ;

				-- z_flag update
				z_flag <= zero_out ;
				
--------end of ADI operation 				
		
----begining of load operation sequence		

		elsif (curr_state = S8 ) then
		
				next_state := S9 ;
				
				t1n <= PC ;
				
	
		elsif (curr_state = S9) then

				next_state := S10 ;
				
				PC <= next_addr ;
				
				A1 <= instr( 8 downto 6) ;
				
				t1 <= D1 ;
				

			
			
		elsif (curr_state = S10) then
	

			next_state := S11 ;
			
			t4 <= instr( 5 downto 0) ;
																-- extender in action 
			t2 <= t5 ;
			
			alu_parity <= '0' ;			
			
			--now t3 contains the required address of main_memory

			
		elsif (curr_state = S11) then
		

			next_state := S12 ;
			
			address <= t3 ;

			--z_flag update
			
			zero_in <= t3 ;
			
			z_flag <= zero_out ;

			
		elsif (curr_state = S12) then
			--now data_out contains the required address
			next_state := S_fetch;
		
			rf_write <= '1' ;
			A3 <= instr( 11 downto 9) ;
			D3 <= data_out ;		
		
	
			--finally load operation done, so reset to state S0 ; 
	
------end of load operation sequence

------begining of store operation sequence

		elsif (curr_state = S13 ) then
			
			next_state := S14 ;
			
			t1n <= PC ;

		elsif ( curr_state = S14) then

				next_state := S15 ; 
				
				PC <= next_addr ;
				
				A1 <= instr ( 11 downto 9);
				
				A2 <= instr (8 downto 6) ;
				

				
				t1 <= D2 ;	

				-- now D1 contains the required value to be stored
				-- now D2 has the base address
				
				rf_write <='0' ; ---------this is required to stop any ongoing writing process from previous instruction 
				mem_write <= '0' ;

		elsif (curr_state = S15 )  then 

				next_state := S16 ;
				
				t4 <= instr( 5 downto 0) ;   -- extender in action 
				t2 <= t5 ;
				alu_parity <= '0';
			
			-- now t3 contains the required address of the main memory

		elsif (curr_state = S16) then 
		
				next_state := S_fetch;
				
				
				address <= t3 ;
				data_in <= D1 ;		
				mem_write <= '1' ;
				
---------end of store operation	

--------- begining of NDU operation

		elsif (curr_state = S17 ) then
		
				next_state := S18 ;
				
				PC <= next_addr ;
				
				
			--- carry flag check
				if(instr(1) = '1') then
					if(c_flag = '1' )  then
						next_state := S18;
					else
						next_state := S0 ;
				
					end if ;
					
			--- zero flag check
				elsif (instr(0) ='1') then
					if(z_flag ='1') then
						next_state := S18 ;
					else
						next_state := S0 ;
						
					end if ;
			
				end if ;

		elsif (curr_state = S18) then
		
				next_state := S19 ;
				
				A1 <= instr (11 downto 9);
				A2 <= instr (8 downto 6) ;
				nand_in1 <= D1;
				nand_in2 <= D2;
				-- nandout will be ready with the required value
				rf_write <='0' ; ---------this is required to stop any ongoing writing process from previous instruction 
				mem_write <= '0' ;	

		elsif (curr_state = S19) then
		
				next_state := S_fetch;
				
				A3 <= instr (5 downto 3) ;
				D3 <= nand_out ;
				rf_write <= '1' ;
				
				--z_flag update
				zero_in <= nand_out ;
				z_flag <= zero_out ;
			
-------end of NDU operation			

------- begining of LHI operation

		elsif (curr_state = S20) then
		
				next_state := S21 ;
				
				t1n <= PC ;

		elsif (curr_state = S21)  then
		
				next_state := S_fetch ;
				
				PC <= next_addr ;	
			
				e9_in <= instr(8 downto 0) ;
				
				D3 <= e9_out ;
				A3 <= instr (11 downto 9) ;
				
				rf_write <='1' ;
				mem_write <= '0' ;

------- end of LHI operation

-------- begining of load all operation
	
		elsif (curr_state = S22 ) then
		
			next_state := S23 ;
			
			t1n <= PC ;
		
		elsif (curr_state = S23) then
		
			
			
			next_state := S24 ;
			
			PC <= next_addr ;
			
			A1 <= instr (11 downto 9) ;
			address <= D1 ;
			
			
			rf_write <= '1';
			
			A3 <= "000";
			D3 <= data_out ;
			
			t6(2 downto 0) <= A3 ;
			
			mem_write <= '0' ;

		elsif(curr_state = S24) then
		
			next_state := S25 ;
			
			A3 <= "000" ;
			D3 <= data_out ;
		
			
		elsif (curr_state = S25 ) then
	
			t1n <= address ;
			
			next_state := S26 ;
			
			t6 ( 2 downto 0) <= A3;
			

			--next_addr will be ready with next address
		elsif (curr_state = S26) then
		
			A3 <= next_A3 ( 2 downto 0) ;
			
			address <= next_addr ;
			
			D3 <= data_out ;
			
			if(A3 = "111") then
			
				next_state := S_fetch;
				
			else 
			
				next_state := S25 ;
			
			
			
				
			end if;
			
			
-------- end of load all operations		


-------- begining of store all operations

		elsif (curr_state = S27) then
		
			next_state := S28 ;
			
			t1n <= PC ;

		elsif (curr_state = S28 ) then
		
			next_state := S29 ;
	
			PC <= next_addr ;
			
			A1 <= instr (11 downto 9) ;
			
			address <= D1 ;
			
			A2 <= "000" ;
			
			rf_write <= '0' ;
			
		elsif (curr_state = S29) then
		
			next_state:= S30 ;
			data_in <= D2 ;
			
			mem_write <= '1' ;
			
			
			
			
			
		elsif (curr_state = S30 ) then
		
			next_state := S31 ;
			
			t1n <= address ;
			
			t6(2 downto 0) <= A2 ;
			
		elsif (curr_state = S31) then
		
			address <= next_addr ;
			
			data_in <= D2 ;
			
			A2 <= next_A3 (2 downto 0) ;
			
			if (A2 = "111") then
				
				next_state := S_fetch ;
				
			else 
			
				next_state := S30;
			
				
			end if;
			
			
			
			
------ end of store all operation 
		
		
------- begining of  BEQ operation

		elsif (curr_state = S32 ) then
		
		
			next_state := S33 ;
			
			A1 <= instr (11 downto 9 );
			
			A2 <= instr ( 8 downto 6 );
			
			t4 <= instr ( 5 downto 0 );
			
			t1n <= PC ;
			
			t2 <= t5 ;
			
			t1 <= PC ;
			
		elsif ( curr_state = S33 ) then
	
			
			next_state := S_fetch ;
			
			if (D1 = D2 ) then
			
				PC <= t3 ;
			
			else
			
				PC <= next_addr ;
			
			end if ;
			
------ end of BEQ operation

------ begining of JAL operation

	elsif (curr_state = S34) then
	
			next_state := S35 ;
			
			e9_in <= instr (8 downto 0 );
			
			A3 <= instr (11 downto 9) ;
			
			D3 <= PC ;
			
			rf_write <= '1' ;
			
			t1 <= PC ;
			
			t2 <= e9s_out ;
	
	
	elsif ( curr_state = S35 ) then
	
			next_state := S_fetch ;
			
			PC <= t3 ;
			
------ end of JAL operation 


------ begining of JLR operation


	elsif (curr_state = S36 ) then
	
			next_state := S37 ;
			
			A3 <= instr ( 11 downto 9 ) ;
			
			D3 <= PC ;
			
			rf_write <= '1' ;
			
			A2 <= instr (8 downto 6 ) ;
			
	elsif (curr_state = S37 ) then
	
			next_state := S_fetch ;
			
			PC <=  D2 ;
			
			
------ end of JLR operation			
		
		
		end if ;
		

		
		
		-------------------clock part
	
	
		if(rising_edge(clk)) then
			curr_state <= next_state ;
		end if ;
		
	
	
	
	
	end process ;
	
	
	
	
	
	
	
	
end load ;
	
	
	
	
	



