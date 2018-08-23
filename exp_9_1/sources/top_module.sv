`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2018 17:31:04
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
	input logic CLK100MHZ,
	input logic BTNL, BTNR, BTNC,
	input logic SW,
	output logic LED,
	output logic [6:0]sevenseg,
	output logic [7:0]AN
    );
    
    logic clk480, clk1000;
    logic BL, BC, BR, BLP, BCP, BRP, BLP1, BCP1, BRP1, BLP2, BCP2, BRP2;
    logic [31:0]hora;
    
    clockmaster #(480) C480 (
    	.clk_in(CLK100MHZ),
    	.clk_out(clk480),
    	.reset(1'b0)
    	);
    	
    clockmaster #(1000) C1000 (
    	.clk_in(CLK100MHZ),
    	.clk_out(clk1000),
    	.reset(1'b0)
    	);
    	
    PB_debouncer #(4) PBDL (
    	.clock(clk1000),
    	.reset(1'b0),
    	.PB(BTNL),
    	.PB_pressed_state(BL),
    	.PB_pressed_pulse(BLP)
    	);
    	
    PB_debouncer #(4) PBDC (
    	.clock(clk1000),
    	.reset(1'b0),
    	.PB(BTNC),
    	.PB_pressed_state(BC),
    	.PB_pressed_pulse(BCP)
    	);
    	
    PB_debouncer #(4) PBDR (
    	.clock(clk1000),
    	.reset(1'b0),
    	.PB(BTNR),
    	.PB_pressed_state(BR),
    	.PB_pressed_pulse(BRP)
    	);
    	
    clk_ss CLKSS (
    	.clk1000(clk1000),
    	.BTNL(BL),
    	.BTNC(BC),
    	.BTNR(BR),
    	.BTNLP(BLP),
    	.BTNCP(BCP),
    	.BTNRP(BRP),
    	.SW(SW),
    	.LED(LED),
    	.hora_completa(hora)
    	);
    	
    display_bcd BCD (
    	.digs(hora),
    	.an_on(8'b11011011),
    	.clk(clk480),
    	.sevenseg(sevenseg),
    	.an(AN)
    	);
    	
    
endmodule
