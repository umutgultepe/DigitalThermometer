
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vgadriver is
    Port ( value:in std_logic_vector(7 downto 0);
		 mclk : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           red : out std_logic;
           grn : out std_logic;
           blu : out std_logic);
end vgadriver;

architecture Behavioral of vgadriver is


	constant hpixels		: std_logic_vector(9 downto 0) := "1100100000";	
	constant vlines		: std_logic_vector(9 downto 0) := "1000001001";	 
	
	constant hbp			: std_logic_vector(9 downto 0) := "0010010000";	 
	constant hfp			: std_logic_vector(9 downto 0) := "1100010000";
	constant vbp			: std_logic_vector(9 downto 0) := "0000011111";	
	constant vfp			: std_logic_vector(9 downto 0) := "0111111111";	
	constant zerovec		: std_logic_vector(9 downto 0) := "0110110011";
		

	signal hc, vc			: std_logic_vector(9 downto 0);						
	signal clkdiv			: std_logic;										
	signal vidon			: std_logic;											
	signal vsenable		: std_logic;
	signal temp			: std_logic_vector(9 downto 0);
	signal temp3			: std_logic_vector(9 downto 0);												

begin
	process(mclk)
		begin
			if(mclk = '1' and mclk'EVENT) then
				clkdiv <= not clkdiv;
			end if;
		end process;																			

	process(clkdiv)
		begin
			if(clkdiv = '1' and clkdiv'EVENT) then
				if hc = hpixels then														
					hc <= "0000000000";												
					vsenable <= '1';													
				else
					hc <= hc + 1;														
					vsenable <= '0';													
				end if;
		end if;
	end process;

	hs <= '1' when hc(9 downto 7) = "000" else '0';							

	process(clkdiv)
	begin
		if(clkdiv = '1' and clkdiv'EVENT and vsenable = '1') then	
			if vc = vlines then														
				vc <= "0000000000";
			else vc <= vc + 1;														
			end if;
		end if;
	end process;

	vs <= '1' when vc(9 downto 1) = "000000000" else '0';
	
	process(value)
	variable temp2:std_logic_vector(9 downto 0);
	variable temp4:std_logic_vector(9 downto 0);
	begin	
		temp2:="00" & value;
		temp4:=zerovec-temp2;
		temp4:=temp4-temp2;
		temp3<=temp4-temp2;				
	end process;
	temp<=temp3;

  	red <= '1' when (temp<"0101110111" and vc>temp and vc<"0110110011" and hc>"0110010000" and hc<"0110101110" and vidon ='1') else '0';		
  	grn <= '1' when (hc = "0101111100" and vc<"0110110011" and vc>"0010000111" and vidon ='1') else '0';		
  	blu <= '1' when (vc = "0010000111" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0010100101" and hc>"0101110010" and hc<"0101111100" and vidon ='1')		
	  else   '1' when (vc = "0011000011" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0011100001" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0011111111" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0100011101" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0100111011" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0101011001" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0101110111" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0110010101" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when (vc = "0110110011" and hc>"0101110010" and hc<"0101111100" and vidon ='1')
	  else   '1' when ("0110110011">temp and temp>"0101011001" and vc<"0110110011" and vc>temp and hc>"0110010000" and hc<"0110101110" and vidon ='1')
	  else   '0' ;


	vidon <= '1' when (((hc < hfp) and (hc > hbp)) or ((vc < vfp) and (vc > vbp))) else '0';

end Behavioral;
