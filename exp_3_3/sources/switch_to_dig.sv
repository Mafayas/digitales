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
	output logic [31:0]digs
    );
    
    assign digs = {16'b0000_0000_0000_0000,sw}
endmodule
