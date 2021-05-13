library ieee;
use ieee.std_logic_1164.all;

entity cpu is
	port(
	clk, rst : in std_logic;
	output : out std_logic_vector(15 downto 0));
end entity;

architecture arch of cpu is

component xor_16bit is
	port(a,b: in std_logic_vector(15 downto 0);
		c: out std_logic_vector(15 downto 0));
end component;


component RF is
	port ( A1,A2,A3 : in std_logic_vector( 2 downto 0) ;
			 D3 : in std_logic_vector( 15 downto 0 ) ;  
			 D1,D2 : out std_logic_vector(15 downto 0) ;
			 rf_write, clk : in std_logic ) ;
end component ;

component nand_16bit is
	port(a,b: in std_logic_vector(15 downto 0);
		c: out std_logic_vector(15 downto 0));
end component nand_16bit;

component main_memory is
	port (
	address, data_in : in std_logic_vector (15 downto 0) ;
	mem_write ,clk: in std_logic ;
	data_out : out std_logic_vector ( 15 downto 0) ) ;
end component ;

component adder_16bit is
	port( a,b : in std_logic_vector (15 downto 0) ; cin : in std_logic ; sum : out std_logic_vector (15 downto 0) );
end component ;

type FsmState is ();

signal aluA, aluB : std_logic_vector(15 downto 0);
signal rf_a1, rf_a2, rf_a3 : std_logic_vector(2 downto 0);
signal rf_d1, rf_d2, rf_d3 : std_logic_vector(15 downto 0);
signal rf_write, mem_write : std_logic;
signal fsm_state : FsmState;

begin



end arch;