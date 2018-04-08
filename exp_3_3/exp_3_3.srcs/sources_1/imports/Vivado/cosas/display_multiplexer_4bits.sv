`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 22:34:18
// Design Name: 
// Module Name: display_multiplexer_4bits
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


module display_multiplexer_4bits(
	input logic [3:0]dig0,[3:0]dig1,[3:0]dig2,[3:0]dig3,
	input logic [3:0]dig4,[3:0]dig5,[3:0]dig6,[3:0]dig7,
	input logic [2:0]counter,
	output logic [3:0]disp,
	output logic a0,a1,a2,a3,a4,a5,a6,a7
    );
    
    always_comb begin
    	case (counter)
    		3'd0: begin
    			disp = dig0;
    			a0 = 1;
    			a1 = 0;
    			a2 = 0;
    			a3 = 0;
    			a4 = 0;
    			a5 = 0;
    			a6 = 0;
    			a7 = 0;
    		end
    		3'd1: begin
    			disp = dig1;
       			a0 = 0;
       			a1 = 1;
       			a2 = 0;
       			a3 = 0;
       			a4 = 0;
       			a5 = 0;
       			a6 = 0;
       			a7 = 0;
       		end
			3'd2: begin
       			disp = dig2;
         		a0 = 0;
       			a1 = 0;
       			a2 = 1;
      			a3 = 0;
  	   			a4 = 0;
       			a5 = 0;
      			a6 = 0;
       			a7 = 0;
       		end
       		3'd3: begin
       		    disp = dig3;
       		    a0 = 0;
       		    a1 = 0;
       		    a2 = 0;
       		    a3 = 1;
       		    a4 = 0;
       		    a5 = 0;
       		    a6 = 0;
       		    a7 = 0;
       		end
       		3'd4: begin
       		    disp = dig4;
       		    a0 = 0;
       		    a1 = 0;
       		    a2 = 0;
       		    a3 = 0;
       		    a4 = 1;
       		    a5 = 0;
       		    a6 = 0;
       		    a7 = 0;
       		end
       		3'd5: begin
       		    disp = dig5;
       		    a0 = 0;
       		    a1 = 0;
       		    a2 = 0;
       		    a3 = 0;
       		    a4 = 0;
       		    a5 = 1;
       		    a6 = 0;
       		    a7 = 0;
       		end
       		3'd6: begin
       		    disp = dig6;
       		    a0 = 0;
       		    a1 = 0;
       		    a2 = 0;
       		    a3 = 0;
       		    a4 = 0;
       		    a5 = 0;
       		    a6 = 1;
       		    a7 = 0;
       		end
       		3'd7: begin
       		    disp = dig7;
       		    a0 = 0;
       		    a1 = 0;
       		    a2 = 0;
       		    a3 = 0;
       		    a4 = 0;
       		    a5 = 0;
       		    a6 = 0;
       		    a7 = 1;
       		end
       		default: begin
       			disp = dig0;
       		    a0 = 0;
       		    a1 = 0;
         	    a2 = 0;
       		    a3 = 0;
       		    a4 = 0;
       		    a5 = 0;
       		    a6 = 0;
       		    a7 = 0;
       		end
       	endcase
    end
endmodule
