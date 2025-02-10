library IEEE;
use IEEE.std_logic_1164.all;

entity Top is 
port (

	------------------------------------------------------------------------------------------
	-- FPGA --
	------------------------------------------------------------------------------------------

	-- Warnings --
	-- Pins declared as "inout" shall be changed by the user to ensure the correct behavior
	-- Other pins are fixed by the layout of the board

	
	-------- USER INTERFACES -----------
	-- Page 22
	USER_KEYS :					in		std_logic_vector(3 downto 0);
	USER_SWITCHS :				in		std_logic_vector(3 downto 0);
	USER_LEDS :					out	std_logic_vector(3 downto 0);
	
	-------- HSMC -----------
	-- Page 23-26
	-- Clocks
	HSMC_CLK_IN0 :				in		std_logic;
	HSMC_CLKIN_n1 :			inout	std_logic;								-- Can be changed
	HSMC_CLKIN_n2 : 			inout std_logic;								-- Can be changed
	HSMC_CLKIN_p1 : 			inout std_logic;								-- Can be changed
	HSMC_CLKIN_p2 : 			inout std_logic;								-- Can be changed
	
	HSMC_CLK_OUT0 :			out	std_logic;
	HSMC_CLKOUT_n1 :			inout std_logic;								-- Can be changed
	HSMC_CLKOUT_n2 :			inout std_logic;								-- Can be changed
	HSMC_CLKOUT_p1 :			inout std_logic;								-- Can be changed
	HSMC_CLKOUT_p2 :			inout std_logic;								-- Can be changed

	-- Low speed signals
	HSMC_D :						inout std_logic_vector(3 downto 0); 	-- Can be changed
	HSMC_SDA :					out 	std_logic;
	HSMC_SCL :					out 	std_logic;

	-- Transcievers
	HSMC_GXB_RX_p :			in		std_logic_vector(7 downto 0);		
	HSMC_GXB_RX_n :			in		std_logic_vector(7 downto 0);		
	HSMC_GXB_TX_p :			in		std_logic_vector(7 downto 0);		
	HSMC_GXB_TX_n :			in		std_logic_vector(7 downto 0);	
	
	-- LVDS	
	HSMC_RX_n :					in		std_logic_vector(16 downto 0);
	HSMC_RX_p :					in		std_logic_vector(16 downto 0);
	HSMC_TX_n :					in		std_logic_vector(16 downto 0);
	HSMC_TX_p :					in		std_logic_vector(16 downto 0);
	
	-------- AUDIO CODEC -----------
	-- Page 27
	AUDIO_I2S_ADC_LRCLK :	out	std_logic;
	AUDIO_I2S_DATAIN :		in		std_logic;
	AUDIO_I2S_DAC_LRCLK :	out	std_logic;
	AUDIO_I2S_DATAOUT :		out 	std_logic;
	AUDIO_I2S_CHIP_CLK :		out	std_logic;
	AUDIO_I2S_BCLK :			out	std_logic;
	AUDIO_SCLK :				out	std_logic;
	AUDIO_SDA :					out 	std_logic;
	AUDIO_DAC_MUTE :			out	std_logic;
	
	-------- VGA -----------
	-- Page 27
	VIDEO_RED :					out	std_logic_vector(7 downto 0);
	VIDEO_GREEN :				out	std_logic_vector(7 downto 0);
	VIDEO_BLUE :				out	std_logic_vector(7 downto 0);
	VIDEO_CLK :					out	std_logic;
	VIDEO_VGA_HS :				out	std_logic;
	VIDEO_VGA_VS :				out	std_logic;
	VIDEO_SYNC :				out 	std_logic;
	VIDEO_BLANK :				out	std_logic;
	
	-------- IR -----------
	-- Page 31
	IR_DATA :					in		std_logic;
	
	-------- DDR3 -----------
	-- Page 31
	DDR_ADDR :					out	std_logic_vector(14 downto 0);
	DDR_BANK :					out	std_logic_vector(2 downto 0);
	DDR_CAS :					out	std_logic;
	DDR_CKE :					out	std_logic;
	DDR_RAS :					out 	std_logic;
	DDR_CLK_p :					out 	std_logic;
	DDR_CLK_n :					out 	std_logic;
	DDR_CS :						out	std_logic;
	DDR_DM :						out	std_logic_vector(3 downto 0);
	DDR_DATA :					inout std_logic_vector(31 downto 0);
	DDR_DQS_n :					out 	std_logic_vector(3 downto 0);
	DDR_DQS_p :					out 	std_logic_vector(3 downto 0);
	DDR_ODT :					out 	std_logic;
	DDR_RESET :					out 	std_logic;
	DDR_WE :						out	std_logic;
	DDR_RZQ :					in 	std_logic;
	
	-------- TEMPERATURE SENSOR -----------
	-- Page 34
	TEMP_CS :					out	std_logic;
	TEMP_DIN :					in 	std_logic;
	TEMP_DOUT :					out 	std_logic;
	TEMP_SCLK :					out 	std_logic;
	
	------------------------------------------------------------------------------------------
	-- HPD --
	------------------------------------------------------------------------------------------
	-- In this case, they're mapped on the FPGA domain...
	
	-------- USER INTERFACES -----------
	-- Page 35
	HPS_USER_KEYS :			in		std_logic_vector(3 downto 0);
	HPS_USER_SWITCHS :		in		std_logic_vector(3 downto 0);
	HPS_USER_LEDS :			out	std_logic_vector(3 downto 0)
	
);
end entity;

architecture structural of Top is
	begin
	
end structural;
		