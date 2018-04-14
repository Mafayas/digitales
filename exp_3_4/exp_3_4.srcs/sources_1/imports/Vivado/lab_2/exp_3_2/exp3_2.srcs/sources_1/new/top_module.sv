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
	input logic clk, reset,
	output logic [6:0]sevenseg,
	output logic [7:0]an
    );
    
    logic [7:0]dig0 = 8'd87;
    logic [7:0]dig1 = 8'd77;
    logic [7:0]dig2 = 8'd32;
    logic [7:0]dig3 = 8'd86;
    logic [7:0]dig4 = 8'd78;
    logic [7:0]dig5 = 8'd32;
    logic [7:0]dig6 = 8'd67;
    logic [7:0]dig7 = 8'd68;
    logic clk480;
    logic [2:0]counter;
    logic [7:0]disp;
    
    	
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
    	
    display_multiplexer_8bits MUL(
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
    
    ascii8bit_to_sevenseg_ltr SEV(
    	.ent(disp),
    	.sevenseg(sevenseg)
    	);
    
    	
endmodule
