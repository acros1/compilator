--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:50:33 05/07/2020
-- Design Name:   
-- Module Name:   C:/Users/Alex/OneDrive - insa-toulouse.fr/Cours/4IR/S2/compilator/processor/testRegisterFile.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: registersFile
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
 
ENTITY testRegisterFile IS
END testRegisterFile;
 
ARCHITECTURE behavior OF testRegisterFile IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT registersFile
    PORT(
         addrA : IN  std_logic_vector(3 downto 0);
         addrB : IN  std_logic_vector(3 downto 0);
         addrW : IN  std_logic_vector(3 downto 0);
         W : IN  std_logic;
         DATA : IN  std_logic_vector(7 downto 0);
         RST : IN  std_logic;
         CLK : IN  std_logic;
         QA : OUT  std_logic_vector(7 downto 0);
         QB : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal addrA : std_logic_vector(3 downto 0) := (others => '0');
   signal addrB : std_logic_vector(3 downto 0) := (others => '0');
   signal addrW : std_logic_vector(3 downto 0) := (others => '0');
   signal W : std_logic := '0';
   signal DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal RST : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal QA : std_logic_vector(7 downto 0);
   signal QB : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	--signal clk : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: registersFile PORT MAP (
          addrA => addrA,
          addrB => addrB,
          addrW => addrW,
          W => W,
          DATA => DATA,
          RST => RST,
          CLK => CLK,
          QA => QA,
          QB => QB
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
		RST <= '0';
      wait for 100 ns;
		addrA <= "0000";
		addrB <= "0000";
		addrW <= "0001";
		W <= '1';
		DATA <= "11111111";
		RST <= '1';
		wait for 100 ns;
		addrA <= "0000";
		addrB <= "0001";
		addrW <= "0011";
		W <= '1';
		DATA <= "01010101";
		RST <= '1';
		wait for 100 ns;
		addrA <= "0001";
		addrB <= "0110";
		addrW <= "0001";
		W <= '0';
		DATA <= "11111111";
		RST <= '1';
		wait for 100 ns;
		addrA <= "0001";
		addrB <= "0110";
		addrW <= "0001";
		W <= '0';
		DATA <= "11111111";
		RST <= '1';
		wait for 100 ns;

      -- wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
