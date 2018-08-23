`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2018 23:52:35
// Design Name: 
// Module Name: grayscale
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


module grayscale(
	input logic [23:0]pix_in,
	output logic [23:0]pix_out
    );
    
    logic [7:0] R, G, B, Y;
    logic [18:0] RG, GG, BG, YG;
    assign R = pix_in[23:16];
    assign G = pix_in[15:8];
    assign B = pix_in[7:0];
    assign RG = R * 'd217;
    assign GG = G * 'd732;
    assign BG = B * 'd74;
    assign YG = RG + GG + BG;
    assign Y = YG[17:10];
    assign pix_out = {Y, Y, Y};
    
endmodule
