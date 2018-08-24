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


module counter_3bit(
	input logic clk, reset,
	output logic [2:0]counter
    );
    
    logic [2:0] count = 3'b000;
    assign counter = count;
    
    always_ff @(posedge clk)begin
    	if (reset)
    		count <=3'b000;
    	else
    		count <= count + 3'b001;
    end
endmodule
