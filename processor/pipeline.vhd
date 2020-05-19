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

entity pipeline is
    Port ( CLK : in  STD_LOGIC);
end pipeline;

architecture Behavioral of pipeline is

	component dataMemory is
		 Port ( addr : in  STD_LOGIC_VECTOR (7 downto 0);
				  INPUT : in  STD_LOGIC_VECTOR (7 downto 0);
				  RW : in  STD_LOGIC;
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  OUTPUT : out  STD_LOGIC_VECTOR (7 downto 0));
	end component ;

	component registersFile is
		 Port ( addrA : in  STD_LOGIC_VECTOR (3 downto 0);
				  addrB : in  STD_LOGIC_VECTOR (3 downto 0);
				  addrW : in  STD_LOGIC_VECTOR (3 downto 0);
				  W : in  STD_LOGIC;
				  DATA : in  STD_LOGIC_VECTOR (7 downto 0);
				  RST : in  STD_LOGIC;
				  CLK : in  STD_LOGIC;
				  QA : out  STD_LOGIC_VECTOR (7 downto 0);
				  QB : out  STD_LOGIC_VECTOR (7 downto 0));
	end component ;

	component UAL is
		 PORT(
				A : IN  std_logic_vector(7 downto 0);
				B : IN  std_logic_vector(7 downto 0);
				NOZC : OUT  std_logic_vector(3 downto 0);
				S : OUT  std_logic_vector(7 downto 0);
				Ctrl_Alu : IN  std_logic_vector(2 downto 0)
			  );
	end component;

	component instructionMemory is
		 PORT(
				addr : IN  std_logic_vector(7 downto 0);
				CLK : IN  std_logic;
				OUTPUT : OUT  std_logic_vector(31 downto 0)
			  );
	end component;

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
	
	----------------------------------------SIGNALS----------------------------------------
	
	------------------------data memory------------------------
	--Inputs
   signal dm_addr : std_logic_vector(7 downto 0) := (others => '0');
   signal dm_INPUT : std_logic_vector(7 downto 0) := (others => '0');
   signal dm_RW : std_logic := '0';
   signal dm_RST : std_logic := '0';
   -- signal dm_CLK : std_logic := '0';

 	--Outputs
   signal dm_OUTPUT : std_logic_vector(7 downto 0);
	
	---------------------instruction memory---------------------
	--Inputs
   signal im_addr : std_logic_vector(7 downto 0) := (others => '0');
   --signal CLK : std_logic := '0';

 	--Outputs
   signal im_OUTPUT : std_logic_vector(31 downto 0);
	
	------------------------register file------------------------
	--Inputs
   signal rf_addrA : std_logic_vector(3 downto 0) := (others => '0');
   signal rf_addrB : std_logic_vector(3 downto 0) := (others => '0');
   signal rf_addrW : std_logic_vector(3 downto 0) := (others => '0');
   signal rf_W : std_logic := '0';
   signal rf_DATA : std_logic_vector(7 downto 0) := (others => '0');
   signal rf_RST : std_logic := '0';
   -- signal clk : std_logic := '0';

 	--Outputs
   signal rf_QA : std_logic_vector(7 downto 0);
   signal rf_QB : std_logic_vector(7 downto 0);
	
	------------------------------UAL----------------------------
	--Inputs
   signal UAL_A : std_logic_vector(7 downto 0) := (others => '0');
   signal UAL_B : std_logic_vector(7 downto 0) := (others => '0');
   signal UAL_Ctrl_Alu : std_logic_vector(2 downto 0) := (others => '0');

 	--Outputs
   signal UAL_NOZC : std_logic_vector(3 downto 0);
   signal UAL_S : std_logic_vector(7 downto 0);
	
	----------------------------------------SIGNALS----------------------------------------
	
	constant OP_AFC : std_logic_vector(7 downto 0) := X"06";
	constant OP_COP : std_logic_vector(7 downto 0) := X"05";


begin

	-- Instantiate the data memory
		dataMemoryInstance: dataMemory PORT MAP (
			 addr => dm_addr,
			 INPUT => dm_INPUT,
			 RW => dm_RW,
			 RST => dm_RST,
			 CLK => CLK,
			 OUTPUT => dm_OUTPUT
		  );
		  
	-- Instantiate the instruction memory
	instructionMemoryInstance: instructionMemory PORT MAP (
			 addr => im_addr,
			 CLK => CLK,
			 OUTPUT => im_OUTPUT
		  );
		  
	-- Instantiate the register file
		registerFileInstance: registersFile PORT MAP (
			 addrA => rf_addrA,
			 addrB => rf_addrB,
			 addrW => rf_addrW,
			 W => rf_W,
			 DATA => rf_DATA,
			 RST => rf_RST,
			 CLK => CLK,
			 QA => rf_QA,
			 QB => rf_QB
		  );
		  
	-- Instantiate the UAL 
		UALInstance: UAL PORT MAP (
			 A => UAL_A,
			 B => UAL_B,
			 NOZC => UAL_NOZC,
			 S => UAL_S,
			 Ctrl_Alu => UAL_Ctrl_Alu
		  );

	process
	begin
		  
		wait until CLK'event and CLK = '1'; -- synch on rising edge
		
		li_di_A <= im_OUTPUT(23 downto 16);
		li_di_OP <= im_OUTPUT(31 downto 24);	
		li_di_B <= im_OUTPUT(15 downto 8);
		li_di_C <= im_OUTPUT(7 downto 0);
		
		rf_addrA <= li_di_B(3 downto 0);
	
		di_ex_A <= li_di_A;
		di_ex_OP <= li_di_OP;
		-- B value of COP
		if li_di_OP = OP_COP then
			di_ex_B <= rf_QA;
		else
			di_ex_B <= li_di_B;
		end if;
		di_ex_C <= li_di_C;
	
		ex_mem_A <= di_ex_A;
		ex_mem_OP <= di_ex_OP;
		ex_mem_B <= di_ex_B;
	
		mem_re_A <= ex_mem_A;
		mem_re_OP <= ex_mem_OP;
		mem_re_B <= ex_mem_B;
		
		im_addr <= im_addr + 1;
		
		rf_addrW <= mem_re_A(3 downto 0);
		
		-- if OP is AFC then write
		if mem_re_OP = OP_AFC then
			rf_W <= '1';
		end if;	
	
		rf_DATA <= mem_re_B;			
	
	end process RE;

end Behavioral;

