library ieee;
use ieee.std_logic_1164.all;
entity nes_top is
  port (
	clock_100	: in std_logic;
	reset	:	in std_logic;
	VGA_R	:	out std_logic_vector(3 downto 0);
	VGA_G	:	out std_logic_vector(3 downto 0);
	VGA_B	:	out std_logic_vector(3 downto 0);
	VGA_HS	:	out std_logic;
	VGA_VS	:	out std_logic
	-- joypad	:	in std_logic_vector(7 downto 0)
  ) ;
end entity ; -- nes_top

architecture beh of nes_top is

	component detest is
		port(
			KEY	:	in std_logic_vector(3 downto 0);
			SW	:	in std_logic_vector(17 downto 0);
			HEX0	:	out std_logic_vector(6 downto 0);
			HEX1	:	out std_logic_vector(6 downto 0);
			HEX2	:	out std_logic_vector(6 downto 0);
			HEX3	:	out std_logic_vector(6 downto 0);
			LEDR	:	out std_logic_vector(17 downto 0);
			LEDG	:	out std_logic_vector(7 downto 0);
			CLOCK_50	:	in std_logic;
			PS2_CLK	:	in std_logic;
			PS2_DAT	:	in std_logic;
			VGA_BLANK	:	out std_logic;
			VGA_SYNC	:	out std_logic;
			VGA_CLK	:	out std_logic; 
			VGA_R	:	out std_logic_vector(9 downto 0);
			VGA_G	:	out std_logic_vector(9 downto 0);
			VGA_B	:	out std_logic_vector(9 downto 0);
			VGA_HS	:	out std_logic;
			VGA_VS	:	out std_logic
			);
	end component;

signal sw 			: std_logic_vector(17 downto 0);
signal clock_50 	: std_logic := '0';
signal key_to_det	: std_logic_vector(3 downto 0);

signal r : std_logic_vector(9 downto 0);
signal g : std_logic_vector(9 downto 0);
signal b : std_logic_vector(9 downto 0);

begin

det : detest port map(key_to_det, sw, open, open, open, open, open, open, clock_50, '0', '0', open, open, open, r, g, b, VGA_HS, VGA_VS);

key_to_det(0)			<= reset;
key_to_det(3 downto 1)	<= "000";

sw(3 downto 0)		<= "1111";
sw(4)				<= '1';
sw(12 downto 5) 	<= "00000000";--joypad;
sw(13)				<= '0';
sw(17 downto 14)	<= "0000";

gen_clk_50 : process( clock_100 )
begin
	if rising_edge(clock_100) then 
		CLOCK_50 <= not clock_50;
	end if;
end process ; -- clk_50

VGA_R <= r(9 downto 6);
VGA_G <= g(9 downto 6);
VGA_B <= b(9 downto 6);

end architecture ; -- beh