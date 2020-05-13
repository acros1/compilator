----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:55:31 04/30/2020 
-- Design Name: 
-- Module Name:    registersFile - Behavioral 
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

entity registersFile is
    Port ( addrA : in  STD_LOGIC_VECTOR (3 downto 0);
           addrB : in  STD_LOGIC_VECTOR (3 downto 0);
           addrW : in  STD_LOGIC_VECTOR (3 downto 0);
           W : in  STD_LOGIC;
           DATA : in  STD_LOGIC_VECTOR (7 downto 0);
           RST : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           QA : out  STD_LOGIC_VECTOR (7 downto 0);
           QB : out  STD_LOGIC_VECTOR (7 downto 0));
end registersFile;

architecture Behavioral of registersFile is
	
	type registers_file is array(0 to 15) of STD_LOGIC_VECTOR (7 downto 0); -- each register has 8 bits rate
	signal registers : registers_file;

begin

	Write : process 
	begin
	
		wait until CLK'event and CLK = '1'; -- synch on rising edge
		
		if RST = '0' then -- if RST is up
			registers <= (others => X"00"); -- all elements init to 0x00
		else
			if W = '1' then -- if write is up
				registers(to_integer(unsigned(addrW))) <= DATA; -- write the DATA
			end if;
		end if;
	end process Write;
	
	Read : process(addrA, addrB) -- launch each time addrA or B value change
	begin
		
		if RST = '0' then -- if RST is up (= 0)
			QA <= X"00"; -- QA is reset to 0x00
			QB <= X"00"; -- QB is reset to 0x00
		else
			-- read A and B before bypass
			QA <= registers(to_integer(unsigned(addrA)));		
			QB <= registers(to_integer(unsigned(addrB)));
			
			if W = '1' then -- if write is up
				if addrA = addrW then  -- Bypass for read A
					QA <= DATA;
				end if;
				if addrB = addrW then  -- Bypass for read B
					QB <= DATA;
				end if;
			end if;
		end if;
	
	end process Read;
	
end Behavioral;

