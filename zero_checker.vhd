library ieee;
use ieee.std_logic_1164.all;

entity zero_checker is
	port(a:in std_logic_vector(15 downto 0);
	     c: out std_logic);
end entity zero_checker;

architecture struct of zero_checker is

begin
	c<=a(0) or a(1) or a(2) or a(3) or a(4) or a(5) or a(6) or a(7) or a(8) or a(9) or a(10) or a(11) or a(12) or a(13) or a(14) or a(15)
end architecture struct;