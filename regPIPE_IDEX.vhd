
-- Quartus Prime VHDL Template
-- One-bit wide, N-bit long shift register with asynchronous reset

library ieee;
use ieee.std_logic_1164.all;

entity regPIPE_IDEX is

	generic
	(
		NUM_BITS : natural := 32;
		dataWidth : natural := 32;
		regLen : natural := 5;
		memLen := 3;
		exLen := 5;
		wbLen := 2
	);

	port 
	(
		clk	    : in std_logic;
		enable	: in std_logic;
		reset   : in std_logic;
				
		write_back_in : in std_logic;
		write_back_out : out std_logic; 
--		
		memory_access_in : in std_logic;
		memory_access_out : out std_logic;
--		
		execute_in : in std_logic_vector(exLen - 1 downto 0);
		execute_out : out std_logic_vector(exLen - 1 downto 0);
		
		read_data1_in : in std_logic_vector(dataWidth - 1 downto 0);
		read_data1_out : out std_logic_vector(dataWidth - 1 downto 0);
		read_data2_in : in std_logic_vector(dataWidth - 1 downto 0);
		read_data2_out : out std_logic_vector(dataWidth - 1 downto 0);
		
		instructionIMED_in : in std_logic_vector(dataWidth - 1 downto 0);
		instructionIMED_out : out std_logic_vector(dataWidth - 1 downto 0);
		
		instructionRT_in : in std_logic_vector(regLen - 1 downto 0);
		instructionRT_out : out std_logic_vector(regLen - 1 downto 0);
		
		instructionRD_in : in std_logic_vector(regLen - 1 downto 0);
		instructionRD_out : out std_logic_vector(regLen - 1 downto 0)
	);

end entity;

architecture IDEX of regPIPE_IFID is
--	signal data_s : std_logic_vector(NUM_BITS - 1 downto 0) := (OTHERS=>'0');
begin
	process (clk, reset)
		begin
			if (rising_edge(clk)) then
				PC_4_out <= PC_4_in;
				
				execute_out <= execute_in;
				
				write_back_out <= write_back_in;
				
				memory_access_out <= memory_access_in;
				
				read_data1_out <= read_data1_in;
				
				read_data2_out <= read_data2_in;
				
				instructionIMED_out <= instructionIMED_in;
				
				instructionRT_out <= instructionRT_in;
				
				instructionRD_out <= instructionRD_in;
				
				
			end if;
		end process;

end IDEX;
