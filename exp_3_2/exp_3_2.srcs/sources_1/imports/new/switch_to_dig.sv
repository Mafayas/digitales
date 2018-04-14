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


module switch_to_dig(
	input logic [15:0]sw,
	output logic [3:0]dig0,[3:0]dig1,[3:0]dig2,[3:0]dig3
    );
    
    assign dig0 = {sw[3],sw[2],sw[1],sw[0]};
    assign dig1 = {sw[7],sw[6],sw[5],sw[4]};
    assign dig2 = {sw[11],sw[10],sw[9],sw[8]};
    assign dig3 = {sw[15],sw[14],sw[13],sw[12]};
endmodule
