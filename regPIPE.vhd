
-- Quartus Prime VHDL Template
-- One-bit wide, N-bit long shift register with asynchronous reset

library ieee;
use ieee.std_logic_1164.all;

entity regPIPE is

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
		
		PC_4_in : in std_logic_vector(NUM_BITS - 1 downto 0);
		PC_4_out : out std_logic_vector(NUM_BITS - 1 downto 0);
		
		Instruction_in : in std_logic_vector(dataWidth - 1 downto 0);
		Instruction_out : out std_logic_vector(dataWidth - 1 downto 0)
	);

end entity;

architecture IFID of regPIPE is
--	signal data_s : std_logic_vector(NUM_BITS - 1 downto 0) := (OTHERS=>'0');
begin
	process (clk, reset)
		begin
			if (rising_edge(clk)) then
				PC_4_out <= PC_4_in;
				
				Instruction_out <= Instruction_in;
				
			end if;
		end process;

end IFID;
