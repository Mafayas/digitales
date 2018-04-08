`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2018 00:17:20
// Design Name: 
// Module Name: sevenseg_separator
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


module sevenseg_separator(
	input logic [6:0]sevenseg,
	output logic ca,cb,cc,cd,ce,cf,cg
    );
    
    assign ca = sevenseg[6];
    assign cb = sevenseg[5];
    assign cc = sevenseg[4];
    assign cd = sevenseg[3];
    assign ce = sevenseg[2];
    assign cf = sevenseg[1];
    assign cg = sevenseg[0];
endmodule
