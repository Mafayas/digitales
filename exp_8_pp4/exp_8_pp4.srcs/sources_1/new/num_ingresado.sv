`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.08.2018 14:11:49
// Design Name: 
// Module Name: num_ingresado
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


module num_ingresado(
	input logic bc,
	input logic clk,
	input logic [4:0]val,
	input logic [2:0]calcstate,
	output logic guardar,
	output logic [15:0]op
    );
    
    enum logic [1:0]{dig1,dig2,dig3,dig4} stt, stt_next;
    logic [7:0] num1_ascii, num2_ascii, num3_ascii, num4_ascii;
    logic reset;
    logic [15:0]op_next;
    
    always_comb begin
    	reset = 1'b0;
    	guardar = 1'b0;
    	if (bc) begin
    		if ((calcstate !=3'b010) & (calcstate !=3'b011)) begin
    			if (val < 5'b1_0000) begin
    				if (op[15:12] == 4'b0000) begin
    					op_next = {op[11:0],val[3:0]};
    				end
    				else
    					op_next = op;
    			end
    			else if(val == 5'b10011) begin
    				guardar = 1'b1;
    				reset = 1'b1;
    			end
    			else begin
    				op_next = op;
    			end
    		end
    		else if (calcstate == 3'b010)
    			if (val > 5'b0_1111) begin
    				if(val == 5'b10011) begin
    			    	guardar = 1'b1;
    			    	reset = 1'b1;
    			    end
    			    else
    					op_next = {11'd0,val[4:0]};
    			end
    			else
    				op_next = op;
    		else
    			op_next = op;
    	end
    	else
    		op_next = op;
    end
    
    always_ff@(posedge clk) begin
    	if (reset)
    		op <= 16'b0000_0000_0000_0000;
    	else
    		op <= op_next;
    end
endmodule
