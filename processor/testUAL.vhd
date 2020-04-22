--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:14:29 04/22/2020
-- Design Name:   
-- Module Name:   C:/Users/Alex/OneDrive - insa-toulouse.fr/Cours/4IR/S2/processor/testUAL.vhd
-- Project Name:  processor
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: UAL
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
 
ENTITY testUAL IS
END testUAL;
 
ARCHITECTURE behavior OF testUAL IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT UAL
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         NOZC : OUT  std_logic_vector(3 downto 0);
         S : OUT  std_logic_vector(7 downto 0);
         Ctrl_Alu : IN  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := (others => '0');
   signal B : std_logic_vector(7 downto 0) := (others => '0');
   signal Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal NOZC : std_logic_vector(3 downto 0);
   signal S : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
	signal clk : std_logic;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: UAL PORT MAP (
          A => A,
          B => B,
          NOZC => NOZC,
          S => S,
          Ctrl_Alu => Ctrl_Alu
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
      wait for 100 ns;
		A <= x"05";
		B <= x"06";
		Ctrl_Alu <= "000";
		wait for 100 ns;
		A <= x"01";
		B <= x"02";
		Ctrl_Alu <= "001";
		wait for 100 ns;
		A <= x"04";
		B <= x"02";
		Ctrl_Alu <= "010";
		wait for 100 ns;
		A <= x"09";
		B <= x"05";
		Ctrl_Alu <= "000";
		wait for 100 ns;
		A <= x"14";
		B <= x"95";
		Ctrl_Alu <= "001";		

      -- insert stimulus here 

      wait;
   end process;

END;
