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
	input logic sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,swa,swb,swc,swd,swe,swf,
	input logic clk, reset,
	output logic ca,cb,cc,cd,ce,cf,cg,
	output logic an0,an1,an2,an3,an4,an5,an6,an7
    );
    
    logic [3:0]dig0;
    logic [3:0]dig1;
    logic [3:0]dig2;
    logic [3:0]dig3;
    logic [3:0]dig4 = 4'd0;
    logic [3:0]dig5 = 4'd0;
    logic [3:0]dig6 = 4'd0;
    logic [3:0]dig7 = 4'd0;
    logic clk240;
    logic [2:0]counter;
    logic [3:0]disp;
    logic [6:0]num;
    
    switch_to_dig SWITCH(
    	.sw0(sw0),
    	.sw1(sw1),
    	.sw2(sw2),
    	.sw3(sw3),
    	.sw4(sw4),
    	.sw5(sw5),
    	.sw6(sw6),
    	.sw7(sw7),
    	.sw8(sw8),
    	.sw9(sw9),
    	.swa(swa),
    	.swb(swb),
    	.swc(swc),
    	.swd(swd),
    	.swe(swe),
    	.swf(swf),
    	.dig0(dig0),
    	.dig1(dig1),
    	.dig2(dig2),
    	.dig3(dig3)
    	);
    	
    clock240hz CLK(
    	.clk_in(clk),
    	.reset(reset),
    	.clk_out(clk240)
    	);
    	
    counter_3bit CNT(
    	.clk(clk240),
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
    	.bcd(disp),
    	.sevenseg(num)
    	);
    
    sevenseg_separator SES(
    	.sevenseg(num),
    	.ca(ca),
    	.cb(cb),
    	.cc(cc),
    	.cd(cd),
    	.ce(ce),
    	.cf(cf),
    	.cg(cg)
    	);
    	
endmodule
