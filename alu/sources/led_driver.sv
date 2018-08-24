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


module led_driver #(parameter w = 8)(
	input logic [2:0]op,
	input logic [w-1:0]res,
	input logic [w-1:0]a,
	input logic [w-1:0]b,
	output logic [15:0]leds
    );
    
    always_comb
    begin
    	case(op)
    	3'b001: begin
    		if ({a,b} < 17'b1_0000_0000_0000_0000) begin
    			leds = {a,{(16-2*w){1'b0}},b}; //suma
    			end
    		else begin
    			leds = 16'b1;
    			end
    		end
    	3'b010: begin
    		leds = {{(16-w){1'b0}},res}; //and
    		end
    	3'b011: begin
    		leds = {{(16-w){1'b0}},res}; //or
    		end
    	3'b100: begin
    		if ({a,b} < 17'b1_0000_0000_0000_0000) begin
    			leds = {a,{(16-2*w){1'b0}},b}; //resta
    			end
    		else begin
    			leds = 16'b1;
    			end
    		end
    	default: begin
    		if ({a,b} < 17'b1_0000_0000_0000_0000) begin
    			leds = {a,{(16-2*w){1'b0}},b}; //suma
    			end
    		else begin
    			leds = 16'b1;
    			end
    		end
    	endcase
    end
endmodule
