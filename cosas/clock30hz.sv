`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 02:31:29
// Design Name: 
// Module Name: clock30hz
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


module clock30hz(
	input logic clk_in,
	input logic reset,
	output logic clk_out
    );
    
    localparam counter_max = 21'd1666666;
    logic [21:0]counter = 'd0;
    
    always_ff @(posedge clk_in) begin
    	if (reset == 1'b1) begin
    		counter <= 'd0;
    		clk_out <= 0;
    		end
    	else if (counter == counter_max) begin
    		counter <= 'd0;
    		clk_out <= ~clk_out;
    		end
    	else begin
    		counter <= counter + 'd1;
    		clk_out <= clk_out;
    		end
    end
endmodule
