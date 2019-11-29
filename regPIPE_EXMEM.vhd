
-- Quartus Prime VHDL Template
-- One-bit wide, N-bit long shift register with asynchronous reset

library ieee;
use ieee.std_logic_1164.all;

entity regPIPE_EXMEM is

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
		
--		PC_4_in : in std_logic_vector(NUM_BITS - 1 downto 0);
--		PC_4_out : out std_logic_vector(NUM_BITS - 1 downto 0);
			
		write_back_in : in std_logic_vector(wbLen - 1 downto 0);
		write_back_out : out std_logic_vector(wbLen - 1 downto 0); 
	
		memory_access_in : in std_logic_vector(memLen - 1 downto 0);
		memory_access_out : out std_logic_vector(memLen - 1 downto 0);
	
--		execute_in : in std_logic_vector(NUM_BITS - 1 downto 0);
--		execute_out : out std_logic_vector(NUM_BITS - 1 downto 0);

		add_result_in : in std_logic_vector(dataWidth - 1 downto 0);
		add_result_out : out std_logic_vector(dataWidth - 1 downto 0);

		read_data2_in : in std_logic_vector(dataWidth - 1 downto 0);
		read_data2_out : out std_logic_vector(dataWidth - 1 downto 0);
		
		ALU_result_in : in std_logic_vector(dataWidth - 1 downto 0);
		ALU_result_out : out std_logic_vector(dataWidth - 1 downto 0);
		
		rt_rd_mux_in : in std_logic_vector(regLen - 1 downto 0);
		rt_rd_mux_out : out std_logic_vector(regLen - 1 downto 0);
		
		zero_in : in std_logic;
		zero_out : out std_logic
	);

end entity;

architecture EXMEM of regPIPE_EXMEM is
--	signal data_s : std_logic_vector(NUM_BITS - 1 downto 0) := (OTHERS=>'0');
begin
	process (clk, reset)
		begin
			if (rising_edge(clk)) then
				write_back_out <= write_back_in;
				
				memory_access_out <= memory_access_in;
				
				read_data2_out <= read_data2_in;
				
				add_result_out <= add_result_in;
				
				ALU_result_out <= ALU_result_in;
				
				rt_rd_mux_out <= rt_rd_mux_in;
								
				zero_out <= zero_in;
				
			end if;
		end process;

end EXMEM;