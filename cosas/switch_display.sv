`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2018 23:39:25
// Design Name: 
// Module Name: switch_display
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


module switch_display(
	input logic sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,swa,swb,swc,swd,swe,swf,clk,rst,
	output logic a4,a5,a6,a7,
	output logic [3:0]dnum
    );
    
    logic [3:0] num7;
    logic [3:0] num6;
    logic [3:0] num5;
    logic [3:0] num4;
    logic [1:0] count;
    assign num4 = {sw0,sw1,sw2,sw3};
    assign num5 = {sw4,sw5,sw6,sw7};
    assign num6 = {sw8,sw9,swa,swb};
    assign num7 = {swc,swd,swe,swf};
    
    always @(posedge clk) begin
    	if (rst) begin
    		count <= 2'd0;
    		dnum <= 4'd0;
    	end
    	else begin
    		count <= count + 2'd1;
    		case (count)
    			2'b00: begin
    				dnum <= num7;
    				a7 <= 1'b1;
    				a6 <= 1'b0;
    				a5 <= 1'b0;
    				a4 <= 1'b0;
    			end
    			2'b01: begin
    				dnum <= num6;
    			    a7 <= 1'b0;
    			    a6 <= 1'b1;
    			    a5 <= 1'b0;
    			    a4 <= 1'b0;
    			end
    			2'b10: begin
    				dnum <= num5;
    			    a7 <= 1'b0;
    			    a6 <= 1'b0;
    			    a5 <= 1'b1;
    			    a4 <= 1'b0;
    			end
    			2'b11: begin
    				dnum <= num4;
    			    a7 <= 1'b0;
    			    a6 <= 1'b0;
    			    a5 <= 1'b0;
    			    a4 <= 1'b1;
    			end
    		endcase
    	end
    end
endmodule
