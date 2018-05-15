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
	input logic [31:0]digs,
	input logic [2:0]counter,
	input logic [7:0]an_on,
	output logic [3:0]disp,
	output logic [7:0]an
    );
    
    always_comb begin
    	case (counter)
    		3'd0: begin
    			disp = digs[3:0];
    			if (an_on[0]==1)
    				an=8'b1111_1110;
    			else
    				an=8'b1111_1111;
    		end
    		3'd1: begin
    			disp = digs[7:4];
    			if (an_on[1]==1)
    				an=8'b1111_1101;
    			else
    				an=8'b1111_1111;
       		end
			3'd2: begin
       			disp = digs[11:8];
    			if (an_on[2]==1)
       				an=8'b1111_1011;
       			else
       				an=8'b1111_1111;
       		end
       		3'd3: begin
       		    disp = digs[15:12];
    			if (an_on[3]==1)
       		    	an=8'b1111_0111;
       		    else
       		    	an=8'b1111_1111;
       		end
       		3'd4: begin
       		    disp = digs[19:16];
    			if (an_on[4]==1)
       		    	an=8'b1110_1111;
       		    else
       		    	an=8'b1111_1111;
       		end
       		3'd5: begin
       		    disp = digs[23:20];
    			if (an_on[5]==1)
       		    	an=8'b1101_1111;
       		    else
       		    	an=8'b1111_1111;
       		end
       		3'd6: begin
       		    disp = digs[27:24];
    			if (an_on[6]==1)
       		    	an=8'b1011_1111;
       		    else
       		    	an=8'b1111_1111;
       		end
       		3'd7: begin
       		    disp = digs[31:28];
    			if (an_on[7]==1)
       		    	an=8'b0111_1111;
       		    else
       		    	an=8'b1111_1111;
       		end
       		default: begin
       			disp = digs[3:0];
       		    an=8'b1111_1111;
       		end
       	endcase
    end
endmodule
