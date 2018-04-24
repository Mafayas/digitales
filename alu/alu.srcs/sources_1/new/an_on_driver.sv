`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2018 22:20:55
// Design Name: 
// Module Name: an_on_driver
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


module an_on_driver(
	input logic [2:0]op,
	output logic [7:0]an_on
    );
    
    always_comb
    begin
    	case(op)
    	001: begin
    		an_on = 0001_1000; //suma
    		end
    	010: begin
    		an_on = 1100_0011; //and
    		end
    	011: begin
    		an_on = 1100_0011; //or
    		end
    	100: begin
    		an_on = 0001_1000; //resta
    		end
    	default: begin
    		an_on = 1100_0011;
    		end
    	endcase
    end
endmodule
