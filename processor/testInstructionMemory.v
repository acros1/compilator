`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:39:44 05/13/2020
// Design Name:   instructionMemory
// Module Name:   C:/Users/Alex/OneDrive - insa-toulouse.fr/Cours/4IR/S2/PSI/processor/testInstructionMemory.v
// Project Name:  processor
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: instructionMemory
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testInstructionMemory;

	// Inputs
	reg [7:0] addr;
	reg CLK;

	// Outputs
	wire [31:0] OUTPUT;

	// Instantiate the Unit Under Test (UUT)
	instructionMemory uut (
		.addr(addr), 
		.CLK(CLK), 
		.OUTPUT(OUTPUT)
	);

	initial begin
		// Initialize Inputs
		addr = 0;
		CLK = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

