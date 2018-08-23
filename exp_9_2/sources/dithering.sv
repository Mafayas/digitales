`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.08.2018 12:23:00
// Design Name: 
// Module Name: dithering
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


module dithering(
	input logic [23:0]pix_in,
	input logic [9:0]hc,
	input logic [9:0]vc,
	output logic [23:0]pix_out
    );
    
    logic [21:0] R, G, B;
    logic [24:0] RM, GM, BM;
    logic [3:0] NR, NG, NB;
    logic [6:0] hcn,vcn;
    logic [13:0] neo;
    assign R = {pix_in[23:16],14'd0};
    assign G = {pix_in[15:8], 14'd0};
    assign B = {pix_in[7:0], 14'd0};
    assign hcn = hc[6:0];
    assign vcn = vc[6:0];
    assign neo = {hcn[0]^vcn[0],vcn[0],hcn[1]^vcn[1],vcn[1],hcn[2]^vcn[2],vcn[2],hcn[3]^vcn[3],vcn[3],hcn[4]^vcn[4],vcn[4],hcn[5]^vcn[5],vcn[5],hcn[6]^vcn[6],vcn[6]};
	assign RM = R + ('d16 * (neo - 'd8192));
	assign GM = G + ('d16 * (neo - 'd8192));
	assign BM = B + ('d16 * (neo - 'd8192));
	
	always_comb begin
		if (RM[24])
			NR = 4'b0000;
		else if (RM[22] | (RM[21:18] == 4'b1111))
			NR = 4'b1111;
		else begin
			if (RM[17])
				NR = RM[21:18] + 'd1;
			else
				NR = RM[21:18];
		end
		
		if (GM[24])
			NG = 4'b0000;
		else if (GM[22] | (GM[21:18] == 4'b1111))
			NG = 4'b1111;
		else begin
			if (GM[17])
				NG = GM[21:18] + 'd1;
			else
				NG = GM[21:18];
		end
		
		if (BM[24]) //este esta bueno los otros no
			NB = 4'b0000;
		else if (BM[22] | (BM[21:18] == 4'b1111))
			NB = 4'b1111;
		else begin
			if (BM[17])
				NB = BM[21:18] + 'd1;
			else
				NB = BM[21:18];
		end
	end
	
    assign pix_out = {NR, 4'd0, NG, 4'd0, NB, 4'd0};
    
endmodule
