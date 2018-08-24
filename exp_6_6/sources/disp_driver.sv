`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2018 16:53:08
// Design Name: 
// Module Name: disp_driver
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


module disp_driver(
	input logic [2:0]state,
	input logic [15:0]SW,
	input logic [16:0]res,
	output logic [31:0]num
    );
    
    always_comb
    	case (state)
    		3'b000: begin
    			num = {16'b0,SW};
    			end
    		3'b001: begin
    			num = {16'b0,SW};
    			end
    		3'b010: begin
    			num = 32'd0;
    			end
    		3'b011: begin
    			num = {16'b0,res[15:0]};
    			end
    		default: num = 32'd0;
    		endcase
endmodule
