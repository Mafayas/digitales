`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.04.2018 19:28:14
// Design Name: 
// Module Name: display_bcd
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


module display_bcd(
	input logic [31:0]digs,
	input logic [7:0]an_on,
	input logic clk,
	output logic [6:0]sevenseg,
	output logic [7:0]an
    );
    
    logic [2:0]counter;
    logic [3:0]disp;
    logic reset = 0;
    
    display_multiplexer_4bits MUL(
    	.digs(digs),
    	.an_on(an_on),
    	.counter(counter),
    	.disp(disp),
    	.an(an)
    	);
    	
    counter_3bit CNT(
    	.clk(clk),
    	.reset(reset),
    	.counter(counter)
    	);
    	
    bcd_to_sevenseg_hex BDC(
    	.bcd(disp),
    	.sevenseg(sevenseg)
    	);
    	
endmodule
