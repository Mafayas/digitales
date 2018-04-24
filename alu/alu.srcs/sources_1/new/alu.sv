`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2018 16:56:48
// Design Name: 
// Module Name: alu
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


module alu (
	input logic [7:0]a,
	input logic [7:0]b,
	input logic [2:0]op,
	output logic [7:0]res
    );
    always_comb
    begin
    	case(op)
    		001: begin
    			res = (a + b); //suma
    			end
    		010: begin
    			res = a&&b; //and
    			end
    		011: begin
    			res = a||b; //or
    			end
    		100: begin
    			res = (a - b); //resta
    			end
    		default: begin
    			res = 8'd0;
    			end
    	endcase
    end
endmodule
