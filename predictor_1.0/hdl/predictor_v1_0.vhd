------------------------------------------------------------------------------
-- hw_acc - entity/architecture pair
------------------------------------------------------------------------------
--
-- ***************************************************************************
-- ** Copyright (c) 1995-2012 Xilinx, Inc.  All rights reserved.            **
-- **                                                                       **
-- ** Xilinx, Inc.                                                          **
-- ** XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS"         **
-- ** AS A COURTESY TO YOU, SOLELY FOR USE IN DEVELOPING PROGRAMS AND       **
-- ** SOLUTIONS FOR XILINX DEVICES.  BY PROVIDING THIS DESIGN, CODE,        **
-- ** OR INFORMATION AS ONE POSSIBLE IMPLEMENTATION OF THIS FEATURE,        **
-- ** APPLICATION OR STANDARD, XILINX IS MAKING NO REPRESENTATION           **
-- ** THAT THIS IMPLEMENTATION IS FREE FROM ANY CLAIMS OF INFRINGEMENT,     **
-- ** AND YOU ARE RESPONSIBLE FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE      **
-- ** FOR YOUR IMPLEMENTATION.  XILINX EXPRESSLY DISCLAIMS ANY              **
-- ** WARRANTY WHATSOEVER WITH RESPECT TO THE ADEQUACY OF THE               **
-- ** IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO ANY WARRANTIES OR        **
-- ** REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE FROM CLAIMS OF       **
-- ** INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS       **
-- ** FOR A PARTICULAR PURPOSE.                                             **
-- **                                                                       **
-- ***************************************************************************
--
------------------------------------------------------------------------------
-- Filename:          hw_acc
-- Version:           1.00.a
-- Description:       Example Axi Streaming core (VHDL).
-- Date:              Mon Sep 15 15:41:21 2014 (by Create and Import Peripheral Wizard)
-- VHDL Standard:     VHDL'93
------------------------------------------------------------------------------
-- Naming Conventions:
--   active low signals:                    "*_n"
--   clock signals:                         "clk", "clk_div#", "clk_#x"
--   reset signals:                         "rst", "rst_n"
--   generics:                              "C_*"
--   user defined types:                    "*_TYPE"
--   state machine next state:              "*_ns"
--   state machine current state:           "*_cs"
--   combinatorial signals:                 "*_com"
--   pipelined or register delay signals:   "*_d#"
--   counter signals:                       "*cnt*"
--   clock enable signals:                  "*_ce"
--   internal version of output port:       "*_i"
--   device pins:                           "*_pin"
--   ports:                                 "- Names begin with Uppercase"
--   processes:                             "*_PROCESS"
--   component instantiations:              "<ENTITY_>I_<#|FUNC>"
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-------------------------------------------------------------------------------------
--
--
-- Definition of Ports
-- ACLK              : Synchronous clock
-- ARESETN           : System reset, active low
-- S_AXIS_TREADY  : Ready to accept data in
-- S_AXIS_TDATA   :  Data in 
-- S_AXIS_TLAST   : Optional data in qualifier
-- S_AXIS_TVALID  : Data in is valid
-- M_AXIS_TVALID  :  Data out is valid
-- M_AXIS_TDATA   : Data Out
-- M_AXIS_TLAST   : Optional data out qualifier
-- M_AXIS_TREADY  : Connected slave device is ready to accept data out
--
-------------------------------------------------------------------------------

------------------------------------------------------------------------------
-- Entity Section
------------------------------------------------------------------------------

entity predictor_v1_0 is
	port 
	(   BRAM_ADDR      : out   std_logic_vector(31 downto 0);
	    BRAM_CLK       : out   std_logic;
	    BRAM_DIN       : out   std_logic_vector(31 downto 0);
	    BRAM_DOUT      : in    std_logic_vector(31 downto 0);
	    BRAM_EN        : out   std_logic;
	    BRAM_RST       : out   std_logic;
	    BRAM_WE        : out   std_logic;
		-- DO NOT EDIT BELOW THIS LINE ---------------------
		-- Bus protocol ports, do not add or delete. 
		ACLK	: in	std_logic;
		ARESETN	: in	std_logic;
		S_AXIS_TREADY	: out	std_logic;
		S_AXIS_TDATA	: in	std_logic_vector(31 downto 0);
		S_AXIS_TLAST	: in	std_logic;
		S_AXIS_TVALID	: in	std_logic;
		M_AXIS_TVALID	: out	std_logic;
		M_AXIS_TDATA	: out	std_logic_vector(31 downto 0);
		M_AXIS_TLAST	: out	std_logic;
		M_AXIS_TREADY	: in	std_logic
		-- DO NOT EDIT ABOVE THIS LINE ---------------------
	);

attribute SIGIS : string; 
attribute SIGIS of ACLK : signal is "Clk"; 

end predictor_v1_0;

------------------------------------------------------------------------------
-- Architecture Section
------------------------------------------------------------------------------

-- In this section, we povide an example implementation of ENTITY hw_acc
-- that does the following:
--
-- 1. Read all inputs
-- 2. Add each input to the contents of register 'sum' which
--    acts as an accumulator
-- 3. After all the inputs have been read, write out the
--    content of 'sum' into the output stream NUMBER_OF_OUTPUT_WORDS times
--
-- You will need to modify this example or implement a new architecture for
-- ENTITY hw_acc to implement your coprocessor

architecture Behavioral of predictor_v1_0 is

   -- Total number of input data.
   constant NUMBER_OF_INPUT_WORDS  : natural := 1;

   -- Total number of output data
   constant NUMBER_OF_OUTPUT_WORDS : natural := 1;

   type STATE_TYPE is (Idle, Read_Inputs, Compute, Write_Outputs);

   signal state        : STATE_TYPE;
   
   signal data         : std_logic_vector (31 downto 0);
   -- Counters to store the number inputs read & outputs written
   signal nr_of_reads  : natural range 0 to NUMBER_OF_INPUT_WORDS - 1;
   signal nr_of_writes : natural range 0 to NUMBER_OF_OUTPUT_WORDS - 1;
   
   -- Signals for forward pass computation
   signal forward_pass_rst : STD_LOGIC;
   signal forward_pass_en : STD_LOGIC;
   signal forward_pass_rdy : STD_LOGIC;

begin
    forward_pass : entity work.forward_pass_top
    port map ( clk => ACLK,
               rst => forward_pass_rst,
               en => forward_pass_en,
               ram_en => BRAM_EN,
               ram_addr => BRAM_ADDR,
               ram_din => BRAM_DOUT,
               ram_dout => BRAM_DIN,
               ram_we => BRAM_WE,
               rdy => forward_pass_rdy );
               
   -- CAUTION:
   -- The sequence in which data are read in and written out should be
   -- consistent with the sequence they are written and read in the
   -- driver's hw_acc.c file

   S_AXIS_TREADY  <= '1'   when state = Read_Inputs   else '0';
   M_AXIS_TVALID <= '1' when state = Write_Outputs else '0';
   M_AXIS_TLAST <= '1' when (state = Write_Outputs and nr_of_writes = 0) else '0';
   M_AXIS_TDATA <= data;
   
   BRAM_RST <= '0';
   BRAM_CLK <= ACLK;
   
   The_SW_accelerator : process (ACLK) is
   begin  -- process The_SW_accelerator
    if ACLK'event and ACLK = '1' then     -- Rising clock edge
      if ARESETN = '0' then               -- Synchronous reset (active low)
        -- CAUTION: make sure your reset polarity is consistent with the
        -- system reset polarity
        state        <= Idle;
        nr_of_reads  <= 0;
        nr_of_writes <= 0;
        forward_pass_rst <= '1';
        forward_pass_en <= '0';
      else
        case state is
          when Idle =>
            forward_pass_rst <= '1';
            forward_pass_en <= '0';            
            if (S_AXIS_TVALID = '1') then
              state       <= Read_Inputs;
              nr_of_reads <= NUMBER_OF_INPUT_WORDS - 1;
            end if;

          when Read_Inputs =>
            forward_pass_rst <= '0';
            forward_pass_en <= '1';
            data <= S_AXIS_TDATA;
            if (S_AXIS_TVALID = '1') then
              -- Coprocessor function (Adding) happens here
              if (nr_of_reads = 0) then
                state        <= Compute;
                nr_of_writes <= NUMBER_OF_OUTPUT_WORDS - 1;
              else
                nr_of_reads <= nr_of_reads - 1;
              end if;
            end if;
          
          when Compute =>
            forward_pass_rst <= '0';
            forward_pass_en <= '1';
            if (forward_pass_rdy = '1') then
              state <= Write_Outputs;
            else
              state <= Compute;
            end if;

          when Write_Outputs =>
            forward_pass_rst <= '0';
            forward_pass_en <= '0';
            if (M_AXIS_TREADY = '1') then                           
              if (nr_of_writes = 0) then
                state <= Idle;                
              else
                nr_of_writes <= nr_of_writes - 1;
              end if;
            end if;
        end case;
      end if;
    end if;
   end process The_SW_accelerator;
end architecture Behavioral;