`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2018 23:21:40
// Design Name: 
// Module Name: color_scrambler
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


module color_scrambler(
	input logic [23:0]pix_in,
	input logic [5:0]switch,
	output logic [23:0]pix_out
    );
    
    logic [7:0] R, G, B, NR, NG, NB;
    assign R = pix_in[23:16];
    assign G = pix_in[15:8];
    assign B = pix_in[7:0];
    assign pix_out = {NR, NG, NB};
    
    always_comb begin
    	case (switch[5:4])
    		2'd0: NR = R;
    		2'd1: NR = G;
    		2'd2: NR = B;
    		2'd3: NR = 'd0;
    	endcase
    	case (switch[3:2])
    		2'd0: NG = R;
    		2'd1: NG = G;
    		2'd2: NG = B;
    		2'd3: NG = 'd0;
    	endcase
    	case (switch[1:0])
    		2'd0: NB = R;
    		2'd1: NB = G;
    		2'd2: NB = B;
    		2'd3: NB = 'd0;
    	endcase
    end
    
endmodule
