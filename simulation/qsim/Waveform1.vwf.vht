-- Copyright (C) 2018  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- *****************************************************************************
-- This file contains a Vhdl test bench with test vectors .The test vectors     
-- are exported from a vector file in the Quartus Waveform Editor and apply to  
-- the top level entity of the current Quartus project .The user can use this   
-- testbench to simulate his design using a third-party simulation tool .       
-- *****************************************************************************
-- Generated on "11/28/2019 12:19:44"
                                                             
-- Vhdl Test Bench(with test vectors) for design  :          mips
-- 
-- Simulation tool : 3rd Party
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY mips_vhd_vec_tst IS
END mips_vhd_vec_tst;
ARCHITECTURE mips_arch OF mips_vhd_vec_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL a_ula : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL b_ula : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL clk : STD_LOGIC;
SIGNAL opcode_wf : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL PC_WF : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL pontos_wf : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL ULA_WF : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL Z_ula : STD_LOGIC;
COMPONENT mips
	PORT (
	a_ula : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	b_ula : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	clk : IN STD_LOGIC;
	opcode_wf : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	PC_WF : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	pontos_wf : OUT STD_LOGIC_VECTOR(10 DOWNTO 0);
	ULA_WF : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	Z_ula : OUT STD_LOGIC
	);
END COMPONENT;
BEGIN
	i1 : mips
	PORT MAP (
-- list connections between master ports and signals
	a_ula => a_ula,
	b_ula => b_ula,
	clk => clk,
	opcode_wf => opcode_wf,
	PC_WF => PC_WF,
	pontos_wf => pontos_wf,
	ULA_WF => ULA_WF,
	Z_ula => Z_ula
	);

-- clk
t_prcs_clk: PROCESS
BEGIN
	clk <= '1';
	WAIT FOR 10000 ps;
	FOR i IN 1 TO 49
	LOOP
		clk <= '0';
		WAIT FOR 10000 ps;
		clk <= '1';
		WAIT FOR 10000 ps;
	END LOOP;
	clk <= '0';
WAIT;
END PROCESS t_prcs_clk;
END mips_arch;
