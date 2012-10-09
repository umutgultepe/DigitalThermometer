library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity segmentdriver is
    Port ( clk : in std_logic;
    		 valuex:in std_logic_vector(7 downto 0);           
           segmentx : out std_logic_vector(6 downto 0);
           selectorx : out std_logic_vector(3 downto 0));
end segmentdriver;

architecture archdriver of segmentdriver is 
signal dd0,dd1,dd2,dd3: std_logic_vector (3 downto 0);
signal clkx: std_logic;
component segment
    Port ( clk : in std_logic;
           d0 : in std_logic_vector(3 downto 0);
           d1 : in std_logic_vector(3 downto 0);
           d2 : in std_logic_vector(3 downto 0);
           d3 : in std_logic_vector(3 downto 0);
           segments : out std_logic_vector(6 downto 0);
           selector : out std_logic_vector(3 downto 0));
end component;
component decoder
	Port ( value : in std_logic_vector(7 downto 0);
           d3 : out std_logic_vector(3 downto 0);
           d2 : out std_logic_vector(3 downto 0);
           d1 : out std_logic_vector(3 downto 0);
           d0 : out std_logic_vector(3 downto 0));
end component;	
component divider
	    Port ( clkin : in std_logic;
           clkout : out std_logic);
end component;
begin

dec: decoder port map(valuex,dd3,dd2,dd1,dd0);
div: divider port map(clk,clkx);
seg: segment port map(clkx,dd0,dd1,dd2,dd3,segmentx,selectorx);
end archdriver;
