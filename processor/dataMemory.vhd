----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:50:17 05/13/2020 
-- Design Name: 
-- Module Name:    dataMemory - Behavioral 
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

entity dataMemory is
    Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
			  INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
           RW : in  STD_LOGIC;
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
end dataMemory;

architecture Behavioral of dataMemory is

	type memory_file is array(0 to 255) of STD_LOGIC_VECTOR (7 downto 0); -- each register has 8 bits rate
	signal memory : memory_file;

begin

 process 
	begin
	
		wait until CLK'event and CLK = '1'; -- synch on rising edge
		
		if RST = '0' then -- if RST is up
			memory <= (others => X"00"); -- all elements init to 0x00
		else
			if RW = '1' then -- if write is up
				memory(to_integer(unsigned(addr))) <= INPUT; -- write the DATA
			elsif RW='0' then 
			OUTPUT <= memory(to_integer(unsigned(addr))) ; -- OUTPUT is reset to 0x00
			end if;
		end if;
	end process ;
	
	

end Behavioral;

