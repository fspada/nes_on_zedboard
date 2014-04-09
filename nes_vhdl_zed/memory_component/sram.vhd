library ieee;
use ieee.std_logic_1164.all;

entity sram is
	port 
	(	
		-- data_a	: in std_logic_vector(7 downto 0);
		-- data_b	: in std_logic_vector(7 downto 0);
		-- addr_a	: in natural range 0 to 63;
		-- addr_b	: in natural range 0 to 63;
		-- we_a	: in std_logic := '1';
		-- we_b	: in std_logic := '1';
		-- clk		: in std_logic;
		-- q_a		: out std_logic_vector(7 downto 0);
		-- q_b		: out std_logic_vector(7 downto 0)
		address_a		: in natural range 0 to 2047;
		address_b		: in natural range 0 to 2047;
		clock		: IN STD_LOGIC ;
		data_a		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren_a		: IN STD_LOGIC;
		wren_b		: IN STD_LOGIC;
		q_a		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		q_b		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
	
end sram;

architecture rtl of sram is
	
	-- Build a 2-D array type for the RAM
	subtype word_t is std_logic_vector(7 downto 0);
	type memory_t is array(2047 downto 0) of word_t;
	
	-- Declare the RAM
	shared variable ram : memory_t;

begin

	-- Port A
	process(clock)
	begin
		if(rising_edge(clock)) then 
			if(wren_a = '1') then
				ram(address_a) := data_a;
			end if;
			q_a <= ram(address_a);
		end if;
	end process;
	
	-- Port B
	process(clock)
	begin
		if(rising_edge(clock)) then
			if(wren_b = '1') then
				ram(address_b) := data_b;
			end if;
			q_b <= ram(address_b);
		end if;
	end process;
end rtl;
