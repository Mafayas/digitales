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


module alu #(parameter largo = 8) (
	input logic [largo-1:0]a,
	input logic [largo-1:0]b,
	input logic [1:0]op,
	output logic [largo:0]res
    );
    always_comb
    begin
    	case(op)
    		2'b00: begin
    			res = (a + b); //suma
    			end
    		2'b10: begin
    			res = a&b; //and
    			end
    		2'b11: begin
    			res = a|b; //or
    			end
    		2'b01: begin
    			res = (a - b); //resta
    			end
    		default: begin
    			res = 'd0;
    			end
    	endcase
    end
endmodule
