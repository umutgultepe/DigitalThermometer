library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity commander is
	Port(clkx,kdx,kcx: in std_logic;
		segmentx: out std_logic_vector(6 downto 0);
		selectorx: out std_logic_vector(3 downto 0);
		hsx : out std_logic;
          vsx : out std_logic;
          redx : out std_logic;
          grnx : out std_logic;
          blux : out std_logic;
		intr: in std_logic;
		cs:out std_logic;
		rd:out std_logic;
		wr:out std_logic;
		temprature:in std_logic_vector(7 downto 0));
		
end commander;		

architecture Behavioral of commander is
signal clktemp2:std_logic;
signal tempkeyb:std_logic_vector(7 downto 0):="00100011";
signal temptemprature:std_logic_vector(7 downto 0);
signal redtemp : std_logic;
signal grntemp : std_logic;
signal blutemp : std_logic;
signal redtemp2 : std_logic;
signal grntemp2 : std_logic;
signal blutemp2 : std_logic;
signal mon:std_logic:='1';
signal tempmon:std_logic:='1';
signal ton:std_logic:='1';
signal tempon:std_logic:='1';
signal tempwr:std_logic;

component segmentdriver
	Port ( clk : in std_logic;
    		 valuex:in std_logic_vector(7 downto 0);           
           segmentx : out std_logic_vector(6 downto 0);
           selectorx : out std_logic_vector(3 downto 0));	
end component;		  
component wrdivider 
    Port ( clkin : in std_logic;
           clkout : out std_logic);
end component;
component keyboarddriver
    Port (CLK, KD, KC: in std_logic;
			WaitReg:out std_logic_vector(7 downto 0));
end component;
component vgadriver 
    Port ( value:in std_logic_vector(7 downto 0);
		 mclk : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           red : out std_logic;
           grn : out std_logic;
           blu : out std_logic);
end component;	
begin 	
	seg: segmentdriver port map(clkx,temptemprature,segmentx,selectorx);
	keyb: keyboarddriver port map(clkx,kdx,kcx,tempkeyb);
	vga: vgadriver port map(temptemprature,clkx,hsx,vsx,redtemp2,grntemp2,blutemp2);
	wrd: wrdivider port map(clkx,clktemp2);
	cs<='0';
	rd<='0';
	process(tempkeyb)
	begin 	
		if(tempkeyb="00011011") then --clear monitor
			tempmon<='0';
			if ton='1' then
				tempon<='1';
			else 
				tempon<='0';
			end if;
		elsif(tempkeyb="00011101") then --turn on monitor
			tempmon<='1';
			if ton='1'then
				tempon<='1';
			else 
				tempon<='0';
			end if;
		elsif(tempkeyb="00100011") then --start 
			tempon<='1';
			if mon='1'then
				tempmon<='1';
			else 
				tempmon<='0';
			end if;	
		elsif(tempkeyb="00011100") then --stop 
			tempon<='0';
			if mon='1'then
				tempmon<='1';
			else 
				tempmon<='0';
			end if;
		else
			if ton='1'then
				tempon<='1';
			else 
				tempon<='0';
			end if;
			if mon='1'then
				tempmon<='1';
			else 
				tempmon<='0';
			end if;
		end if;
	end process;			
	process(ton,mon)
	begin
	if mon='1' then
		redtemp<=redtemp2;
		grntemp<=grntemp2;
		blutemp<=blutemp2;
		if ton='1' then
		tempwr<=clktemp2;
		temptemprature<=temprature; 		
		else
		tempwr<='0';
		end if;
	else
		redtemp<='0';
		grntemp<='0';
		blutemp<='0';
		if ton='1' then
		tempwr<=clktemp2;
		temptemprature<=temprature; 		
		else
		tempwr<='0';
		end if;
	end if;
	end process;
	ton<=tempon;
	mon<=tempmon;
	redx<=redtemp;
	grnx<=grntemp;
	blux<=blutemp;
	wr<=tempwr; 	
end Behavioral;
