`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.05.2018 00:11:51
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
	input logic BTNC, CPU_RESETN,
	input logic CLK100MHZ,
	output logic [2:0]LED
    );
    
    logic DBTNC;
    logic DBTNRES;
    
    PB_debouncer #(21) BDC (
    	.clock(CLK100MHZ),
    	.reset(1'b0),
    	.PB(BTNC),
    	.PB_pressed_pulse(DBTNC)
    	);
    	
    PB_debouncer #(21) BDRES (
    	.clock(CLK100MHZ),
    	.reset(1'b0),
    	.PB(CPU_RESETN),
    	.PB_pressed_state(DBTNRES)
    	);
    
    calculadora CAL (
    	.clk(CLK100MHZ),
    	.reset(~DBTNRES),
    	.BP(DBTNC),
    	.leds(LED)
    	);
    	
endmodule
