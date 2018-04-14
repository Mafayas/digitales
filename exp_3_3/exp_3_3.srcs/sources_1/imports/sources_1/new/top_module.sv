`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.04.2018 23:32:16
// Design Name: 
// Module Name: top_module
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


module top_module(
	input logic clk, reset, reset16,
	output logic [6:0]sevenseg,
	output logic [7:0]an
    );
    
    logic [3:0]dig0;
    logic [3:0]dig1;
    logic [3:0]dig2;
    logic [3:0]dig3;
    logic [3:0]dig4 = 4'd0;
    logic [3:0]dig5 = 4'd0;
    logic [3:0]dig6 = 4'd0;
    logic [3:0]dig7 = 4'd0;
    logic clk480;
    logic [2:0]counter;
    logic [3:0]disp;
    logic clk4;
    logic [15:0]count16;
    
	clock4hz CLK4(
		.clk_in(clk),
		.reset(reset),
		.clk_out(clk4)
		);
		
	counter_16bit CNT16(
		.clk(clk4),
		.reset(reset16),
		.counter(count16)
		);

    switch_to_dig SWITCH(
    	.sw(count16),
    	.dig0(dig0),
    	.dig1(dig1),
    	.dig2(dig2),
    	.dig3(dig3)
    	);
    	
    clock480hz CLK(
    	.clk_in(clk),
    	.reset(reset),
    	.clk_out(clk480)
    	);
    	
    counter_3bit CNT(
    	.clk(clk480),
    	.reset(reset),
    	.counter(counter)
    	);
    	
    display_multiplexer_4bits MUL(
    	.dig0(dig0),
    	.dig1(dig1),
    	.dig2(dig2),
    	.dig3(dig3),
    	.dig4(dig4),
    	.dig5(dig5),
    	.dig6(dig6),
    	.dig7(dig7),
    	.counter(counter),
    	.disp(disp),
    	.an(an)
    	);
    
    bcd_to_sevenseg_hex BCD(
    	.bcd(disp),
    	.sevenseg(sevenseg)
    	);
    
    	
endmodule
