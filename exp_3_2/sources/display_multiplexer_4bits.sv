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
	output logic [7:0]an
    );
    
    always_comb begin
    	case (counter)
    		3'd0: begin
    			disp = dig0;
    			an=8'b1111_1110;
    		end
    		3'd1: begin
    			disp = dig1;
       			an=8'b1111_1101;
       		end
			3'd2: begin
       			disp = dig2;
         		an=8'b1111_1011;
       		end
       		3'd3: begin
       		    disp = dig3;
       		    an=8'b1111_0111;
       		end
       		3'd4: begin
       		    disp = dig4;
       		    an=8'b1110_1111;
       		end
       		3'd5: begin
       		    disp = dig5;
       		    an=8'b1101_1111;
       		end
       		3'd6: begin
       		    disp = dig6;
       		    an=8'b1011_1111;
       		end
       		3'd7: begin
       		    disp = dig7;
       		    an=8'b0111_1111;
       		end
       		default: begin
       			disp = dig0;
       		    an=8'b1111_1111;
       		end
       	endcase
    end
endmodule
