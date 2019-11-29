-- Design de Computadores
-- file: mips.vhd
-- date: 18/10/2019

library ieee;
use ieee.std_logic_1164.all;
use work.constantesMIPS.all;

entity mipsPipedTwo is
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
        clk			            : IN  STD_LOGIC;
		  PC4_etp2in			   : IN  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  PC4_etp2out				: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  Instruc_in			  	: IN STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  dadoEscrita				: IN  STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  RegEscrita				: IN  STD_LOGIC;
		  dadoLeitura1				: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  dadoLeitura2				: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  ImedEstendido			: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  rt_out						: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  rd_out						: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		  WBcontrole				: OUT STD_LOGIC_VECTOR(wbLen - 1 DOWNTO 0);
		  Memcontrole				: OUT STD_LOGIC_VECTOR(memLen -1 DOWNTO 0);
		  EXcontrole				: OUT STD_LOGIC_VECTOR(exLen - 1 DOWNTO 0)
  
		  
    );
end entity;

architecture pip2 of mipsPipedTwo is

-- Declaração de sinais auxiliares
    
	-- Sinais auxiliar da instrução
	signal instrucao_s : std_logic_vector(DATA_WIDTH-1 downto 0);

	-- Sinais auxiliares para o banco de registradores
	signal RA, RB : std_logic_vector(DATA_WIDTH-1 downto 0);

	-- Sinais auxiliares para a ULA
	signal saida_ula : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal Z_out : std_logic;

	-- Sinais auxiliares para a lógica do PC
	signal PC_s, PC_mais_4, PC_mais_4_mais_imediato, entrada_somador_beq : std_logic_vector(DATA_WIDTH-1 downto 0);

	-- Sinais auxiliares para a RAM
	signal dado_lido_mem : std_logic_vector(DATA_WIDTH-1 downto 0);

	-- Sinais auxiliares para os componentes manipuladores do imediato
	signal sinal_ext : std_logic_vector(DATA_WIDTH-1 downto 0);

	-- Sinais auxiliares para os componentes manipuladores do endereço de jump
	signal PC_4_concat_imed : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal saida_shift_jump : std_logic_vector(27 downto 0);
			
	-- Sinais auxiliares dos MUXs
	signal sel_mux_beq : std_logic;
	signal saida_mux_ula_mem, saida_mux_banco_ula, saida_mux_beq, saida_mux_jump : std_logic_vector(DATA_WIDTH-1 downto 0);
	signal saida_mux_rd_rt : std_logic_vector(REGBANK_ADDR_WIDTH-1 downto 0);

	-- Parsing da instrucao
	alias RS_addr   : std_logic_vector(REGBANK_ADDR_WIDTH-1 downto 0) is instrucao_s(25 downto 21);
	alias RT_addr   : std_logic_vector(REGBANK_ADDR_WIDTH-1 downto 0) is instrucao_s(20 downto 16);
	alias RD_addr   : std_logic_vector(REGBANK_ADDR_WIDTH-1 downto 0) is instrucao_s(15 downto 11);
	alias funct     : std_logic_vector(FUNCT_WIDTH-1 downto 0) is  instrucao_s(5 DOWNTO 0);
	alias imediato  : std_logic_vector(15 downto 0) is instrucao_s(15 downto 0);
	alias opcode6bits : std_logic_vector(OPCODE_WIDTH-1 downto 0) is Instruc_in(31 DOWNTO 26);

	signal pontosDeControle_sig : STD_LOGIC_VECTOR(CONTROLWORD_WIDTH-1 DOWNTO 0);
	
	-- Codigos da palavra de controle:
	alias ULAop : std_logic_vector(2 downto 0) is pontosDeControle(10 downto 8);
	alias habEscritaReg : std_logic is pontosDeControle_sig(7);
	alias habEscritaMEM : std_logic is pontosDeControle_sig(6);
	alias habLeituraMEM : std_logic is pontosDeControle_sig(5);
	alias muxULAmem : std_logic is pontosDeControle_sig(4);
	alias muxRTRD : std_logic is pontosDeControle_sig(3);
	alias muxRTImediato : std_logic is pontosDeControle_sig(2);
	alias BEQOut : std_logic is pontosDeControle_sig(1);
	alias muxJump : std_logic is pontosDeControle_sig(0);
	 
begin

	instrucao_s <= Instruc_in;
	
	PC4_etp2out <= PC4_etp2in;
	
	WBcontrole(wbLen - 1) <= habEscritaReg;
	WBcontrole(wbLen - 2) <= muxULAmem;
	
	Memcontrole(memLen - 1) <= BEQOut;
	Memcontrole(memLen - 2) <= habLeituraMEM;
	Memcontrole(memLen - 3) <= habEscritaMEM;
	
	EXcontrole(exLen - 1 downto exLen - 3) <= ULAop;
	EXcontrole(exlen - 4) <= muxRTRD;
	EXcontrole(exLen - 5) <= muxRTImediato;
	
	
		
	BancoReg: entity work.bancoRegistradores
		port map(
			clk => clk,
			enderecoA => RS_addr,
			enderecoB => RT_addr,      
			enderecoC => RD_addr,	
			dadoEscritaC => dadoEscrita,   
			escreveC => RegEscrita,
			saidaA => dadoLeitura1,      
			saidaB => dadoLeitura2     
		);

	Extensor: entity work.estendeSinalGenerico
		generic map(
			larguraDadoEntrada => 16,
			larguraDadoSaida => 32
		)
		port map(
			estendeSinal_IN => imediato,
			estendeSinal_OUT => ImedEstendido
		);
		  
	
	UnidadeControle: entity work.uc
		port map(
			opcode => opcode6bits,
			pontosDeControle => pontosDeControle_sig 
		);
	
end architecture;
