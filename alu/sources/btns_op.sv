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
    		4'b0001: begin
    			op = 3'b001; //suma
    			end
    		4'b0010: begin
    			op = 3'b010; //and
    			end
    		4'b0100: begin
    			op = 3'b011; //or
    			end
    		4'b1000: begin
    			op = 3'b100; //resta
    			end
    		default: begin
    			op = 3'b000; //nada
    			end
    	endcase
 	end
endmodule
