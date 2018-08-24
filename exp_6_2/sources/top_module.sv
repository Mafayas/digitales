`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2018 23:01:58
// Design Name: 
// Module Name: top_module
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


module top_module(
	input logic CLK100MHZ,
	input logic [15:0]SW,
	output logic LED16_B, LED16_G, LED16_R
    );
    
    logic clk60;
    
    clockmaster #(48) CLK60 (
    	.clk_in(CLK100MHZ),
    	.reset(1'b0),
    	.clk_out(clk60)
    	);
    	
    always_comb begin
    		if (SW[0]) begin
    			LED16_R = clk60;
    			end
    		else LED16_R = 1'b0;
    		if (SW[1]) begin
    			LED16_G = clk60;
    			end
    		else LED16_G = 1'b0;
    		if (SW[2]) begin
    			LED16_B = clk60;
    			end
    		else LED16_B = 1'b0;
    	end
    	
endmodule
