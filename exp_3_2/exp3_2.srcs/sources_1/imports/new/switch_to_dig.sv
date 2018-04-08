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
	input logic sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,swa,swb,swc,swd,swe,swf,
	output logic [3:0]dig0,[3:0]dig1,[3:0]dig2,[3:0]dig3
    );
    
    assign dig0 = {sw3,sw2,sw1,sw0};
    assign dig1 = {sw7,sw6,sw5,sw4};
    assign dig2 = {swb,swa,sw9,sw8};
    assign dig3 = {swf,swe,swd,swc};
endmodule
