library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity keyboarddriver is
	Port (CLK, KD, KC: in std_logic;
			WaitReg:out std_logic_vector(7 downto 0));
end keyboarddriver;
	 
architecture Behavioral of keyboarddriver is

	signal clkDiv : std_logic_vector (3 downto 0);
	signal pclk : std_logic;
	signal KDI, KCI : std_logic;
	signal shiftRegSig1: std_logic_vector(10 downto 0);
	signal shiftRegSig2: std_logic_vector(10 downto 1);
	begin
	CLKDivider: Process (CLK)
		begin
			if (CLK = '1' and CLK'Event) then
				clkDiv <= clkDiv +1;
			end if;
		end Process; 
		pclk <= clkDiv(3); 

		Process (pclk, KC, KD)
		begin
		if (pclk = '1' and pclk'Event) then
			KDI <= KD;KCI <= KC; 
		end if;
	end process;
	Process(KDI, KCI) 
		begin
		if (KCI = '0' and KCI'Event) then
			ShiftRegSig1(10 downto 0) <= KDI & ShiftRegSig1(10 downto 1);
			ShiftRegSig2(10 downto 1) <= ShiftRegSig1(0) &
			ShiftRegSig2(10 downto 2);
		end if;
	end process;
	process(ShiftRegSig1, ShiftRegSig2, KCI)
	begin
		if(KCI'event and KCI = '1' and ShiftRegSig2(8 downto 1) =
		"11110000")then
		WaitReg <= ShiftRegSig1(8 downto 1);
		end if;
	end Process;  				
end Behavioral;