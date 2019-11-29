
-- Quartus Prime VHDL Template
-- One-bit wide, N-bit long shift register with asynchronous reset

library ieee;
use ieee.std_logic_1164.all;

entity regPIPE_MEMWB is

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
			
		write_back_in : in std_logic_vector(wbLen - 1 downto 0);
		write_back_out : out std_logic_vector(wbLen - 1 downto 0); 
		
		rt_rd_mux_in : in std_logic_vector(regLen - 1 downto 0);
		rt_rd_mux_out : out std_logic_vector(regLen - 1 downto 0);
		
		datamem_read_in : in std_logic_vector(dataWidth - 1 downto 0);
		datamem_read_out : in std_logic_vector(dataWidth - 1 downto 0);
		
--		instrucRD_in : in std_logic_vector(regLen - 1 downto 0);
--		instrucRD_out : out std_logic_vector(regLen - 1 downto 0);
		
		ALU_result_in : in std_logic_vector(dataWidth - 1 downto 0);
		ALU_result_out : out std_logic_vector(dataWidth - 1 downto 0)
	);

end entity;

architecture MEMWB of regPIPE_MEMWB is
--	signal data_s : std_logic_vector(NUM_BITS - 1 downto 0) := (OTHERS=>'0');
begin
	process (clk, reset)
		begin
			if (rising_edge(clk)) then	
				write_back_out <= write_back_in;
				
				rt_rd_mux_out <= rt_rd_mux_in;
				
				ALU_result_out <= ALU_result_in;
				
				datamem_read_out <= datamem_read_in;
				
				instrucRD_out <= instrucRD_in;
				
			end if;
		end process;

		--data_out <= data_s;

end MEMWB;
