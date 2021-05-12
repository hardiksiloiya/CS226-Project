library ieee;
use ieee.std_logic_1164.all;

entity xor_16bit is
	port(a,b: in std_logic_vector(15 downto 0);
		c: out std_logic_vector(15 downto 0));
end entity xor_16bit;

architecture temp of xor_16bit is

	begin
		c<= a XOR b;

end architecture temp;