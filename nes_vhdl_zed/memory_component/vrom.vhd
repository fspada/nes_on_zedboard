library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vrom is
	port 
	(
		address_a		: in natural range 0 to 8191;
		address_b		: in natural range 0 to 8191;
		clock		: IN STD_LOGIC ;
		q_a		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		q_b		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end entity;

architecture rtl of vrom is

	-- Build a 2-D array type for the ROM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(8191 downto 0) of word_t;
		
	function init_rom
	return memory_t is
	variable tmp : memory_t := (others => (others => '0'));
	begin 
		for addr_pos in 0 to 8191 loop 
			-- Initialize each address with the address itself
			tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 8));
		end loop;
		
		return tmp;
	end init_rom;
	
	-- Declare the ROM signal and specify a default value. Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := init_rom;
	
	begin
	
	process(clock)
	begin
		if(rising_edge(clock)) then
			q_a <= rom(address_a);
			q_b <= rom(address_b);
		end if;
	end process;

end rtl;
