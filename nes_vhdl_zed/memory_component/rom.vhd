library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity rom is

	port
	(
		address		: in natural range 0 to 32767;
		clock		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	
end entity;

architecture rtl of rom is

	-- Build a 2-D array type for the RoM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(32767 downto 0) of word_t;
		
	function init_rom
		return memory_t is
		variable tmp : memory_t := (others => (others => '0'));
		begin
			for addr_pos in 0 to 32767 loop
				-- Initialize each address with the address itself
				tmp(addr_pos) := std_logic_vector(to_unsigned(addr_pos, 8));
			end loop;
		return tmp;
	end init_rom;
	
	-- Declare the ROM signal and specify a default value.	Quartus II
	-- will create a memory initialization file (.mif) based on the 
	-- default value.
	signal rom : memory_t := init_rom;
	
begin
	
	process(clock)
	begin
		if(rising_edge(clock)) then
			q <= rom(address);
		end if;
	end process;
		
end rtl;
