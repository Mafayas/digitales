`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 23:21:33
// Design Name: 
// Module Name: switch_to_dig
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


module count_to_dig(
	input logic [15:0]count,
	output logic [3:0]dig0,[3:0]dig1,[3:0]dig2,[3:0]dig3
    );
    
    assign dig0 = {count[3],count[2],count[1],count[0]};
    assign dig1 = {count[7],count[6],count[5],count[4]};
    assign dig2 = {count[11],count[10],count[9],count[8]};
    assign dig3 = {count[15],count[14],count[13],count[12]};
endmodule
