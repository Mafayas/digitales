`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.04.2018 14:19:58
// Design Name: 
// Module Name: test_simple
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_simple();
	logic [7:0]an;
	logic clk = 1'b0;
	logic reset = 1'b0;
	logic [6:0]sevenseg;
    
    top_module TOP(
    	.clk(clk),
    	.reset(reset),
    	.an(an),
    	.sevenseg(sevenseg)
    	);
    	
    	always #5 clk=~clk;
    	initial begin
    		reset = 1;
    		#10
    		reset = 0;
    	end
endmodule
