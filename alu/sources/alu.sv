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


module alu #(parameter w = 8) (
	input logic [w-1:0]a,
	input logic [w-1:0]b,
	input logic [2:0]op,
	output logic [w-1:0]res
    );
    always_comb
    begin
    	case(op)
    		3'b001: begin
    			res = (a + b); //suma
    			end
    		3'b010: begin
    			res = a & b; //and
    			end
    		3'b011: begin
    			res = a | b; //or
    			end
    		3'b100: begin
    			res = (a - b); //resta
    			end
    		default: begin
    			res = 'd0;
    			end
    	endcase
    end
endmodule
