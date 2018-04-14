`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 23:00:14
// Design Name: 
// Module Name: counter_3bit
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


module counter_16bit(
	input logic clk, reset,
	output logic [15:0]counter
    );
    
    logic [15:0] count = 16'd0;
    assign counter = count;
    
    always_ff @(posedge clk)begin
    	if (reset)
    		count <=16'd0;
    	else
    		count <= count + 16'd1;
    end
endmodule
