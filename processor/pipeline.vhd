----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:59:19 05/13/2020 
-- Design Name: 
-- Module Name:    pipeline - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pipeline is
    Port ( CLK : in  STD_LOGIC);
end pipeline;

architecture Behavioral of pipeline is

	-- pipelines LI/DI
	signal li_di_A : STD_LOGIC_VECTOR (7 downto 0);
	signal li_di_OP : STD_LOGIC_VECTOR (7 downto 0);
	signal li_di_B : STD_LOGIC_VECTOR (7 downto 0);
	signal li_di_C : STD_LOGIC_VECTOR (7 downto 0);
	
	-- pipelines DI/EX
	signal di_ex_A : STD_LOGIC_VECTOR (7 downto 0);
	signal di_ex_OP : STD_LOGIC_VECTOR (7 downto 0);
	signal di_ex_B : STD_LOGIC_VECTOR (7 downto 0);
	signal di_ex_C : STD_LOGIC_VECTOR (7 downto 0);
	
	-- pipelines EX/Mem
	signal ex_mem_A : STD_LOGIC_VECTOR (7 downto 0);
	signal ex_mem_OP : STD_LOGIC_VECTOR (7 downto 0);
	signal ex_mem_B : STD_LOGIC_VECTOR (7 downto 0);
	
	-- pipelines Mem/RE
	signal mem_re_A : STD_LOGIC_VECTOR (7 downto 0);
	signal mem_re_OP : STD_LOGIC_VECTOR (7 downto 0);
	signal mem_re_B : STD_LOGIC_VECTOR (7 downto 0);

begin

	-- Instantiate the data memory
		dataMemoryInstance: dataMemory PORT MAP (
			 addr => addr,
			 INPUT => INPUT,
			 RW => RW,
			 RST => RST,
			 CLK => CLK,
			 OUTPUT => OUTPUT
		  );
		  
	-- Instantiate the instruction memory
	instructionMemoryInstance: instructionMemory PORT MAP (
			 addr => addr,
			 CLK => CLK,
			 OUTPUT => OUTPUT
		  );
		  
	-- Instantiate the register file
		registerFileInstance: registersFile PORT MAP (
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
		  
	-- Instantiate the UAL 
		UALInstance: UAL PORT MAP (
				 A => A,
				 B => B,
				 NOZC => NOZC,
				 S => S,
				 Ctrl_Alu => Ctrl_Alu
			  );

end Behavioral;

