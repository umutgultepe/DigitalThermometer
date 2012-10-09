library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
    Port ( value : in std_logic_vector(7 downto 0);
           d3 : out std_logic_vector(3 downto 0);
           d2 : out std_logic_vector(3 downto 0);
           d1 : out std_logic_vector(3 downto 0);
           d0 : out std_logic_vector(3 downto 0));
end decoder;

architecture Behavioral of decoder is
begin
process(value)
variable count:integer:=0;
variable temp: integer;
begin
	count:=0;
	temp:=CONV_INTEGER(value);
	d3<="0000";
	for i in 1 to 10 loop
		if temp>99 then
			temp:=temp-100;
			count:=count+1;
		end if;
	end loop;
	d2<=CONV_STD_LOGIC_VECTOR(count,4);
	count:=0;
	for i in 1 to 11 loop
		if temp>9 then
			temp:=temp-10;
			count:=count+1;
		end if;
	end loop;
	d1<=CONV_STD_LOGIC_VECTOR(count,4);
	d0<=CONV_STD_LOGIC_VECTOR(temp,4);
end process;	
end Behavioral;
