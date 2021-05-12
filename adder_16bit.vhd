library std;
use std.standard.all;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;	 
use ieee.std_logic_unsigned.all;


entity adder_16bit is
	port( a,b : in std_logic_vector (15 downto 0) ; cin : in std_logic ; sum : out std_logic_vector (15 downto 0) );
end entity ;


architecture addition of adder_16bit is



	component FA is
	port ( a,b,cin : in std_logic ; cout, sum : out std_logic) ;	
	end component ;


	signal ben,carry : std_logic_vector ( 15 downto 0 ) ;
	
	
	begin 
	
	ben(0) <= b(0) xor cin ;
	ben(1) <= b(1) xor cin ;
	ben(2) <= b(2) xor cin ;
	ben(3) <= b(3) xor cin ;
	ben(4) <= b(4) xor cin ;
	ben(5) <= b(5) xor cin ;
	ben(6) <= b(6) xor cin ;
	ben(7) <= b(7) xor cin ;
	ben(8) <= b(8) xor cin ;
	ben(9) <= b(9) xor cin ;
	ben(10) <= b(10) xor cin ;
	ben(11) <= b(11) xor cin ;
	ben(12) <= b(12) xor cin ;
	ben(13) <= b(13) xor cin ;
	ben(14) <= b(14) xor cin ;
	ben(15) <= b(15) xor cin ;
	
	sum_0 : FA port map ( a => a(0) , b => ben(0) , cin => cin , cout => carry(0), sum => sum(0) );
	sum_1 : FA port map ( a => a(1) , b => ben(1) , cin => carry(0) , cout => carry(1), sum => sum(1) );
	sum_2 : FA port map ( a => a(2) , b => ben(2) , cin => carry(1) , cout => carry(2), sum => sum(2) );
	sum_3 : FA port map ( a => a(3) , b => ben(3) , cin => carry(2) , cout => carry(3), sum => sum(3) );
	sum_4 : FA port map ( a => a(4) , b => ben(4) , cin => carry(3) , cout => carry(4), sum => sum(4) );
	sum_5 : FA port map ( a => a(5) , b => ben(5) , cin => carry(4) , cout => carry(5), sum => sum(5) );
	sum_6 : FA port map ( a => a(6) , b => ben(6) , cin => carry(5) , cout => carry(6), sum => sum(6) );
	sum_7 : FA port map ( a => a(7) , b => ben(7) , cin => carry(6) , cout => carry(7), sum => sum(7) );
	sum_8 : FA port map ( a => a(8) , b => ben(8) , cin => carry(7) , cout => carry(8), sum => sum(8) );
	sum_9 : FA port map ( a => a(9) , b => ben(9) , cin => carry(8) , cout => carry(9), sum => sum(9) );
	sum_10 : FA port map ( a => a(10) , b => ben(10) , cin => carry(9) , cout => carry(10), sum => sum(10) );
	sum_11 : FA port map ( a => a(11) , b => ben(11) , cin => carry(10) , cout => carry(11), sum => sum(11) );
	sum_12 : FA port map ( a => a(12) , b => ben(12) , cin => carry(11) , cout => carry(12), sum => sum(12) );
	sum_13 : FA port map ( a => a(13) , b => ben(13) , cin => carry(12) , cout => carry(13), sum => sum(13) );
	sum_14 : FA port map ( a => a(14) , b => ben(14) , cin => carry(13) , cout => carry(14), sum => sum(14) );
	sum_15 : FA port map ( a => a(15) , b => ben(15) , cin => carry(14) , cout => carry(15), sum => sum(15) );
	
	
	
	
	










end addition ;