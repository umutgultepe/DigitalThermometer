library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity segment is
    Port ( clk : in std_logic;
           d0 : in std_logic_vector(3 downto 0);
           d1 : in std_logic_vector(3 downto 0);
           d2 : in std_logic_vector(3 downto 0);
           d3 : in std_logic_vector(3 downto 0);
           segments : out std_logic_vector(6 downto 0);
           selector : out std_logic_vector(3 downto 0));
end segment;

architecture Behavioral of segment is
signal choose:std_logic_vector(3 downto 0);
begin
	process (clk)
	variable counter:integer:=0;
	begin
		if (clk'event and clk='1') then	
			counter:=counter+1;
			if counter=16 then
				counter:=0;
			end if;
			if counter<4 then
				selector<="1110";
				choose<=d0;
			elsif counter<8 then
				selector<="1101";
				choose<=d1;
			elsif counter<12 then
				selector<="1011";
				choose<=d2;
			elsif counter<16 then
				selector<="0111";
				choose<=d3;
			end if;
		end if;
	end process;
	process(choose)
	begin
	if choose="0000" then
		segments<="0000001";
	elsif choose="0001" then
		segments<="1001111";
	elsif choose="0010" then
		segments<="0010010";
	elsif choose="0011" then
		segments<="0000110";
	elsif choose="0100" then
		segments<="1001100";
	elsif choose="0101" then
		segments<="0100100";
	elsif choose="0110" then
		segments<="0100000";
	elsif choose="0111" then
		segments<="0001111";
	elsif choose="1000" then
		segments<="0000000";
	elsif choose="1001" then
		segments<="0001100";
	end if;
	end process;
end Behavioral;

