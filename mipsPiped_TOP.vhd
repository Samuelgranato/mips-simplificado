library ieee;
use ieee.std_logic_1164.all;
use work.constantesMIPS.all;

entity mipsPiped_TOP is
	port
    (
        clk			            : IN  STD_LOGIC;
    );
	 
	 
end entity;

architecture Pipeline of mipsPiped_TOP is
    signal instrucao_sig         : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
    signal PC4_sig             	: STD_LOGIC_VECTOR(ALU_OP_WIDTH-1 DOWNTO 0);
begin

Etapa1 : entity work.mipsPipedOne
		port map (
			clk => clk,
			PCSelect => 
			JumpAddr => 
			Instruc_out => 
			PC4_out => PC4_sig
			
      );

Pipe1 : entity work.regPIPE
		port map (
			clk => clk,    
			PC_4_in => PC4_sig,
			PC_4_out => ,
			Instruction_in => ,
			Instruction_out =>
		);

Etapa2 : entity work.mipsPipedTwo
		port map (
			clk => clk,
			PCSelect => 
			JumpAddr => 
			Instruc_out => 
			PC4_out => PC4_sig
			
      );
		
	
Pipe2 : entity work.regPIPE_IDEX
		port map (
			clk => clk,    
			PC_4_in => PC4_sig,
			PC_4_out => ,
			Instruction_in => ,
			Instruction_out =>
		);
		
Etapa3 : entity work.mipsPipedThree
		port map (
			clk => clk,
			PCSelect => 
			JumpAddr => 
			Instruc_out => 
			PC4_out => PC4_sig
			
      );
		
Pipe3 : entity work.regPIPE_IDEX
		port map (
			clk => clk,    
			PC_4_in => PC4_sig,
			PC_4_out => ,
			Instruction_in => ,
			Instruction_out =>
		);
		
		
Etapa4 : entity work.mipsPipedFour
		port map (
			clk => clk,
			PCSelect => 
			JumpAddr => 
			Instruc_out => 
			PC4_out => PC4_sig
			
      );
		
		
Pipe4 : entity work.regPIPE_IDEX
		port map (
			clk => clk,    
			PC_4_in => PC4_sig,
			PC_4_out => ,
			Instruction_in => ,
			Instruction_out =>
		);
		
		


