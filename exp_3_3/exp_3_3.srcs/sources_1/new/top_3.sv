`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06.04.2018 17:20:30
// Design Name: 
// Module Name: top_3
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


module top_3(
	input logic clk, reset,
	output logic ca,cb,cc,cd,ce,cf,cg,
	output logic an0,an1,an2,an3,an4,an5,an6,an7
    );
    
    logic clk4;
    logic clk240;
    logic [15:0]count16;
    logic [3:0]dig0;
    logic [3:0]dig1;
    logic [3:0]dig2;
    logic [3:0]dig3;
    logic [3:0]dig4 = 4'd0;
    logic [3:0]dig5 = 4'd0;
    logic [3:0]dig6 = 4'd0;
    logic [3:0]dig7 = 4'd0;
    logic [2:0]count3;
    logic [3:0]dnum;
    logic [6:0]sevenseg;
    
    clock4hz CL4(
    	.clk_in(clk),
    	.reset(reset),
    	.clk_out(clk4)
    	);
    	
    clock240hz CL240(
    	.clk_in(clk),
    	.reset(reset),
    	.clk_out(clk240)
    	);
    
    counter_16bit CNT16(
    	.clk(clk4),
    	.reset(reset),
    	.counter(count16)
    	);
    	
    count_to_dig CTD(
    	.count(count16),
    	.dig0(dig0),
    	.dig1(dig1),
    	.dig2(dig2),
    	.dig3(dig3)
    	);
    	
    counter_3bit CNT3(
    	.clk(clk240),
    	.reset(reset),
    	.counter(count3)
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
    	.counter(count3),
    	.disp(dnum),
    	.a0(an0),
    	.a1(an1),
    	.a2(an2),
    	.a3(an3),
    	.a4(an4),
    	.a5(an5),
    	.a6(an6),
    	.a7(an7)
    	);
    	
    bcd_to_sevenseg_hex BCD(
    	.bcd(dnum),
    	.sevenseg(sevenseg)
    	);
    	
    sevenseg_separator SEV(
    	.sevenseg(sevenseg),
    	.ca(ca),
    	.cb(cb),
    	.cc(cc),
    	.cd(cd),
    	.ce(ce),
    	.cf(cf),
    	.cg(cg)
    	);
    
endmodule
