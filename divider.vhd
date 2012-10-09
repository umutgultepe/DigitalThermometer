library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity divider is
    Port ( clkin : in std_logic;
           clkout : out std_logic);
end divider;

architecture Behavioral of divider is
signal int_clock:std_logic :='0';
signal count:integer range 0 to 50000000 :=0;
begin
	clkout<=int_clock;
	process(clkin)
		begin
		if (clkin'event and clkin = '1') then
			if count = 12500 then
			int_clock <= not int_clock; count <=0;
			else count <= count +1;
			end if;
		end if;
	end process;
end Behavioral;
