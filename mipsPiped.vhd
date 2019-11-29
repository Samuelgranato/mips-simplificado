-- Design de Computadores
-- file: mips.vhd
-- date: 18/10/2019

library ieee;
use ieee.std_logic_1164.all;
use work.constantesMIPS.all;

entity mipsPipedOne is
	port
    (
        clk			            : IN  STD_LOGIC;
		  ULA_WF						: out STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  PC_WF					  	: out STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  opcode_wf					: out std_logic_vector(DATA_WIDTH-1 downto 0);
		  pontos_wf					: out std_logic_vector(CONTROLWORD_WIDTH-1 DOWNTO 0);
		  Z_ula : out std_logic;
		  a_ula: out std_logic_vector(DATA_WIDTH-1 downto 0);
		  b_ula: out std_logic_vector(DATA_WIDTH-1 downto 0)
    );
end entity;

architecture estrutural of mipsPipedOne is

begin

    Somador: entity work.soma4
        generic map (
            larguraDados => DATA_WIDTH
        )
		port map (
            entrada => PC_s,
            saida   => PC_mais_4
        ); 

    -- ROM
    ROM: entity work.ROM 
        generic map (
            dataWidth => DATA_WIDTH, 
            addrWidth => larguraROM
        ) 
		port map (
            endereco => PC_s(larguraROM-1 downto 0),
            dado     => instrucao_s
        );
		  
	
	mux_jump: entity work.muxGenerico2 
        generic map (
            larguraDados => DATA_WIDTH
        )
		port map (
            entradaA => saida_mux_beq,
            entradaB => PC_4_concat_imed,
            seletor  => sel_mux_jump,
            saida    => saida_mux_jump
        );
	
end architecture;
