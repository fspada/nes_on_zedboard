library ieee;
use ieee.std_logic_1164.all;

entity spram is
	port
	(
		address		: in natural range 0 to 255;
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	
end entity;

architecture rtl of spram is

	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(255 downto 0) of word_t;
	
	-- Declare the RAM signal.
	signal ram : memory_t;
	
	-- Register to hold the address
	signal addr_reg : natural range 0 to 255;

begin

	process(clock)
	begin
		if(rising_edge(clock)) then
			if(wren = '1') then
				ram(address) <= data;
			end if;
			
			-- Register the address for reading
			addr_reg <= address;
		end if;
	
	end process;
	
	q <= ram(addr_reg);
	
end rtl;
