----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:34:56 04/22/2020 
-- Design Name: 
-- Module Name:    UAL - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in  STD_LOGIC_VECTOR (7 downto 0);
           B : in  STD_LOGIC_VECTOR (7 downto 0);
           NOZC : out  STD_LOGIC_VECTOR (3 downto 0);
           S : out  STD_LOGIC_VECTOR (7 downto 0);
           Ctrl_Alu : in  STD_LOGIC_VECTOR (2 downto 0));
end UAL;

architecture Behavioral of UAL is

signal Sadd : STD_LOGIC_VECTOR (8 downto 0);
signal Ssub : STD_LOGIC_VECTOR (8 downto 0);
signal Smul : STD_LOGIC_VECTOR (15 downto 0);

-- Temporary NOZC values
signal NOZCadd : STD_LOGIC_VECTOR (3 downto 0);
signal NOZCsub : STD_LOGIC_VECTOR (3 downto 0);
signal NOZCmul : STD_LOGIC_VECTOR (3 downto 0);
signal Stmp : STD_LOGIC_VECTOR (7 downto 0);

begin

Sadd <= ('0' & A) + ('0' & B);
Ssub <= ('0' & A) - ('0' & B);
Smul <= A * B;

S <= Stmp;

Stmp <= 	Sadd(7 downto 0) when Ctrl_Alu = "000" else 
			Ssub(7 downto 0) when Ctrl_Alu = "001"	else
			Smul(7 downto 0);

-- ------------------------Temporary NOZC operations------------------------

-- -----------Add-----------
-- Carry flag
NOZCadd(0) <= 	Sadd(8);

-- Overflow flag
NOZCadd(2) <= '1' when ( 
								(A(7) = '0' and B(7) = '0' and Sadd(7) = '1')
								or (A(7) = '1' and B(7) = '1' and Sadd(7) = '0') ) 
						else '0'; 

-- -----------Sub-----------
-- Carry flag
NOZCsub(0) <= 	Ssub(8);

-- Overflow flag
NOZCsub(2) <= '1' when ( 
								(A(7) = '1' and B(7) = '0' and Ssub(7) = '0')
								or (A(7) = '0' and B(7) = '1' and Ssub(7) = '1') ) 
						else '0';

-- -----------Mul-----------
-- Overflow flag
NOZCmul(2) <= 	'0' when ( Smul(15 downto 8) = "00000000" ) else
					'1';

-- ----------------------------Flag affections-----------------------------
-- Carry flag			
NOZC(0) <= 	NOZCadd(0) when Ctrl_Alu = "000" else 
				NOZCsub(0) when Ctrl_Alu = "001"	else
				NOZCmul(0);
				
-- Zero flag
NOZC(1) <= 	'1' when Stmp = "00000000" else
				'0';
				
-- Overflow flag				
NOZC(2) <= 	NOZCadd(2) when Ctrl_Alu = "000" else 
				NOZCsub(2) when Ctrl_Alu = "001"	else
				NOZCmul(2);
				
-- Negative flag
NOZC(3) <= Stmp(7);
				
end Behavioral;

