----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:35:29 05/13/2020 
-- Design Name: 
-- Module Name:    instructionMemory - Behavioral 
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
use IEEE.STD_LOGIC_unsigned.ALL;
--use IEEE.STD_LOGIC_arith.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity instructionMemory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (31 downto 0));
end instructionMemory;

architecture Behavioral of instructionMemory is

	type memory_file is array(0 to 255) of STD_LOGIC_VECTOR (31 downto 0); -- each register has 8 bits rate
	signal memory : memory_file;

begin
	-- Test AFC
	memory <= (X"06050F00", others => X"00000000");
	
	-- Test COP
	--memory <= (X"06050F00", X"05080500", others => X"00000000");
 process 
	begin
	
		wait until CLK'event and CLK = '1'; -- synch on rising edge
		
		OUTPUT <= memory(to_integer(unsigned(addr))) ; -- OUTPUT is reset to 0x00
		
	end process ;
	
end Behavioral;

