-- Design de Computadores
-- file: UC_ULA.vhd
-- date: 18/10/2019

library ieee;
use ieee.std_logic_1164.all;
use work.constantesMIPS.all;

entity UC_ULA is
	port
    (
        funct               : IN STD_LOGIC_VECTOR(FUNCT_WIDTH-1 DOWNTO 0);
        ALUop               : IN STD_LOGIC_VECTOR(ALU_OP_WIDTH-1 DOWNTO 0);
        ALUctr              : OUT STD_LOGIC_VECTOR(CTRL_ALU_WIDTH-1 DOWNTO 0)
    );
end entity;

architecture bhv of UC_ULA is	
--    signal ALUop_s : STD_LOGIC_VECTOR(ALU_OP_WIDTH-1 DOWNTO 0);
	 signal funct_filtered : STD_LOGIC_VECTOR(CTRL_ALU_WIDTH-1 DOWNTO 0);
begin
	
	funct_filtered <= ulaCtrlAdd when (ALUop = "010" AND funct = functADD) else
							ulaCtrlSub when (ALUop = "010" AND funct = functSUB) else
							ulaCtrlAND when (ALUop = "010" AND funct = functAND) else
							ulaCtrlOR when (ALUop = "010" AND funct = functOR) else
							ulaCtrlSLT;
							
	
	ALUctr <= ulaCtrlAdd when (ALUop = "000") else
				 ulaCtrlSub when (ALUop = "001") else
				 funct_filtered;


end bhv;