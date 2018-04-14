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
	logic [15:0]led;
	logic [15:0]sw;
	
    
    switch_led SWI(
    	.sw(sw),
    	.led(led)
    	);
    	
    	initial begin
    		sw = 16'b0;
    		repeat(16'b1111_1111_1111_1111) begin
    			#1
    			sw = sw+1;
    		end
    	end
endmodule
