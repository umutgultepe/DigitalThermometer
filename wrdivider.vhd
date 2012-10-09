library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity wrdivider is
    Port ( clkin : in std_logic;
           clkout : out std_logic);
end wrdivider;

architecture Behavioral of wrdivider is
signal int_clock:std_logic :='0';
signal count:integer :=0;
begin
	clkout<=int_clock;
	process(clkin)
		begin
		if (clkin'event and clkin = '1') then
			if count = 12500000 then
				count<=0;
				int_clock <= not int_clock; 
			else 
				count <= count +1;
			end if;
		end if;
	end process;
end Behavioral;
