library ieee;
use ieee.std_logic_1164.all;

entity nand_16bit is
	port(a,b: in std_logic_vector(15 downto 0);
		c: out std_logic_vector(15 downto 0));
end entity nand_16bit;

architecture temp of nand_16bit is

	begin
		c<= a nand b;

end architecture temp;