--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:58:36 05/13/2020
-- Design Name:   
-- Module Name:   C:/Users/Alex/OneDrive - insa-toulouse.fr/Cours/4IR/S2/PSI/processor/testDataMemory.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dataMemory
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testDataMemory IS
END testDataMemory;
 
ARCHITECTURE behavior OF testDataMemory IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dataMemory
    PORT(
         addr : IN  std_logic_vector(7 downto 0);
         INPUT : IN  std_logic_vector(7 downto 0);
         RW : IN  std_logic;
         RST : IN  std_logic;
         CLK : IN  std_logic;
         OUTPUT : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(7 downto 0) := (others => '0');
   signal INPUT : std_logic_vector(7 downto 0) := (others => '0');
   signal RW : std_logic := '0';
   signal RST : std_logic := '0';
   signal CLK : std_logic := '0';

 	--Outputs
   signal OUTPUT : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dataMemory PORT MAP (
          addr => addr,
          INPUT => INPUT,
          RW => RW,
          RST => RST,
          CLK => CLK,
          OUTPUT => OUTPUT
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		addr <= "00000000";
		RW <= '0';
		INPUT <= "11111111";
		RST <= '0';
      wait for 100 ns;
		addr <= "00000001";
		RW <= '1';
		INPUT <= "11111111";
		RST <= '1';
		wait for 100 ns;
		addr <= "00000000";
		RW <= '1';
		INPUT <= "01010101";
		RST <= '1';
		wait for 100 ns;
		addr <= "00000001";
		RW <= '0';
		INPUT <= "11111111";
		RST <= '1';
		wait for 100 ns;
		addr <= "00000000";
		RW <= '0';
		INPUT <= "11111111";
		RST <= '1';
		wait for 100 ns;

      --wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
