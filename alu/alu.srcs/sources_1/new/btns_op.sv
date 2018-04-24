`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.04.2018 17:47:50
// Design Name: 
// Module Name: btns_op
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


module btns_op(
	input logic [3:0] btns,
	output logic [2:0] op
    );
    
    always_comb
    begin
    	case(btns)
    		0001: begin
    			op = 001; //suma
    			end
    		0010: begin
    			op = 010; //and
    			end
    		0100: begin
    			op = 011; //or
    			end
    		1000: begin
    			op = 100; //resta
    			end
    		default: begin
    			op = 000; //nada
    			end
    	endcase
 	end
endmodule
