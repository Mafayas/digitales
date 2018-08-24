`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2018 16:53:08
// Design Name: 
// Module Name: disp_driver
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


module disp_driver(
	input logic [3:0]state,
	input logic [15:0]a,
	input logic [15:0]b,
	input logic [16:0]res,
	output logic [31:0]num
    );
    
    always_comb
    	case (state)
    		4'd0: begin
    			num = {16'b0,res[15:0]};
    			end
    		4'd1: begin
    			num = {32'b0};
    			end
    		4'd2: begin
    			num = {32'b0};
    			end
    		4'd3: begin
    			num = {32'b0};
    			end
    		4'd4: begin
    			num = {16'b0,a};
    			end
    		4'd5: begin
    			num = {16'b0,a};
    			end
    		4'd6: begin
    			num = {16'b0,a};
    			end
    		4'd7: begin
    			num = {16'b0,a};
    			end
    		4'd8: begin
    			num = {16'b0,b};
    			end
    		4'd9: begin
    			num = {16'b0,b};
    			end
    		4'd10: begin
    			num = {16'b0,b};
    			end
    		4'd11: begin
    			num = {16'b0,res[15:0]};
    			end
    		default: num = 32'd0;
    		endcase
endmodule
