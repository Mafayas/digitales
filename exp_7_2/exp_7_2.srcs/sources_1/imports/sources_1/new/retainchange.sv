`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2018 13:39:32
// Design Name: 
// Module Name: retainchange
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


module retainchange(
	input logic [2:0] state,
	output logic reta, retb, reto
    );
    
    always_comb begin
    	case (state)
    		3'b000: begin
    			reta = 1'b1;
    			retb = 1'b0;
    			reto = 1'b0;
    			end
    		3'b001: begin
    			reta = 1'b0;
    			retb = 1'b1;
    			reto = 1'b0;
    			end
    		3'b010: begin
    			reta = 1'b0;
    			retb = 1'b0;
    			reto = 1'b1;
    			end
    		default: begin
    			reta = 1'b0;
    			retb = 1'b0;
    			reto = 1'b0;
    		end
    	endcase
    end
endmodule
