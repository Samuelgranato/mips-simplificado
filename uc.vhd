-- Design de Computadores
-- file: uc.vhd
-- date: 18/10/2019

library ieee;
use ieee.std_logic_1164.all;
use work.constantesMIPS.all;

entity uc is
	generic
	(
		dataWidth : natural := 6
	);
	port
    (
        opcode              	: IN STD_LOGIC_VECTOR(OPCODE_WIDTH-1 DOWNTO 0);
        pontosDeControle    	: OUT STD_LOGIC_VECTOR(CONTROLWORD_WIDTH-1 DOWNTO 0)
    );
end entity;

architecture bhv of uc is

	constant tipoR : std_logic_vector(dataWidth - 1 downto 0) := "000000";
	constant BEQ : std_logic_vector(dataWidth - 1 downto 0) := "000100";
	constant LW : std_logic_vector(dataWidth - 1 downto 0) := "100011";
	constant SW : std_logic_vector(dataWidth - 1 downto 0) := "101011";
	constant Jump : std_logic_vector(dataWidth - 1 downto 0) := "000010";
	
	alias ULAop : std_logic_vector(2 downto 0) is pontosDeControle(10 downto 8);
	alias habEscritaReg : std_logic is pontosDeControle(7);
	alias habEscritaMEM : std_logic is pontosDeControle(6);
	alias habLeituraMEM : std_logic is pontosDeControle(5);
	alias muxULAmem : std_logic is pontosDeControle(4);
	alias muxRTRD : std_logic is pontosDeControle(3);
	alias muxRTImediato : std_logic is pontosDeControle(2);
	alias BEQOut : std_logic is pontosDeControle(1);
	alias muxJump : std_logic is pontosDeControle(0);
	

	
begin
--    process(opcode)
--		begin
			muxJump <= '1' when (opcode = Jump) else '0';
			
			muxRTRD <= '1' when (opcode = tipoR) else
						  '0';
			
			habEscritaReg <= '1' when ( (opcode = tipoR) OR (opcode = LW) ) else
								  '0';
								  
			muxRTImediato <= '0' when ( (opcode = TipoR) OR (opcode = BEQ) ) else
								  '1';
								  
			ULAop <= "000" when ( (opcode = LW) OR (opcode = SW) )  else
						"001" when (opcode = BEQ) else
						"010" when (opcode = tipoR) else
						"011";
						
			muxULAmem <= '0' when (opcode = tipoR) else
							 '1';
							 
			BEQOut <= '1' when (opcode = BEQ) else
						 '0';
			
			habLeituraMEM <= '1' when (opcode = LW) else
								  '0';
								  
			habEscritaMEM <= '1' when (opcode = SW) else
								  '0';
								  
--			pontosDeControle <= muxJump & muxRTRD & habEscritaReg & muxRTImediato & ULAop & muxULAmem & BEQOut & habLeituraMEM & habEscritaMEM;
--		end process;
end bhv;