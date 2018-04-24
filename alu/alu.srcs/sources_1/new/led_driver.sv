`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2018 22:08:11
// Design Name: 
// Module Name: led_driver
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


module led_driver(
	input logic [2:0]op,
	input logic [7:0]res,
	input logic [7:0]a,
	input logic [7:0]b,
	output logic [15:0]leds
    );
    
    always_comb
    begin
    	case(op)
    	001: begin
    		leds = {a,b}; //suma
    		end
    	010: begin
    		leds = {8'b0,res}; //and
    		end
    	011: begin
    		leds = {8'b0,res}; //or
    		end
    	100: begin
    		leds = {a,b}; //resta
    		end
    	default: begin
    		leds = {a,b};
    		end
    	endcase
    end
endmodule
