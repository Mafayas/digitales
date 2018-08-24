`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2018 22:25:58
// Design Name: 
// Module Name: display_driver
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


module display_driver #(parameter w = 8)(
	input logic [2:0]op,
	input logic [7:0]a,
	input logic [7:0]b,
	input logic [7:0]res,
	output logic [31:0]bcd
    );
    
    always_comb
    begin
    	case(op)
    		3'b001: begin
    			bcd = {24'b0,res}; //suma
    			end
    		3'b010: begin
    			bcd = {a,16'b0,b}; //and
    			end
    		3'b011: begin
    			bcd = {a,16'b0,b}; //or
    			end
    		3'b100: begin
    			bcd = {24'b0,res}; //resta
    			end
    		default: begin
    			bcd = {a,16'b0,b};
    			end
    	endcase
    end
endmodule
