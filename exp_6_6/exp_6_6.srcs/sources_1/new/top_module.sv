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
	input logic BTNC, CPU_RESETN, BTNU, BTND,
	input logic CLK100MHZ,
	input logic [15:0]SW,
	output logic [7:0]AN,
	output logic [6:0]sevenseg,
	output logic LED16_R,
	output logic LED16_G
    );
    
    logic DBTNC, DBTNU;
    logic DBTNRES;
    logic [2:0]state;
    logic reta, retb, reto;
    logic [15:0] a,b;
    logic [16:0] res;
    logic [1:0] o;
    logic clk480;
    logic [31:0]num;
    logic clk48;
    logic [31:0]bcdd;
    logic [31:0]kentra;
    logic DBTND;
    
    PB_debouncer #(21) BDC (
    	.clock(CLK100MHZ),
    	.reset(1'b0),
    	.PB(BTNC),
    	.PB_pressed_pulse(DBTNC)
    	);
    	
    PB_debouncer #(21) BDD (
    	.clock(CLK100MHZ),
    	.reset(1'b0),
    	.PB(BTND),
    	.PB_pressed_pulse(DBTND)
    	);
    	
    PB_debouncer #(12) BDU (
    	.clock(CLK100MHZ),
    	.reset(1'b0),
    	.PB(BTNU),
    	.PB_pressed_state(DBTNU)
    	);
    	
    PB_debouncer #(12) BDRES (
    	.clock(CLK100MHZ),
    	.reset(1'b0),
    	.PB(CPU_RESETN),
    	.PB_pressed_state(DBTNRES)
    	);
    	
    retainchange RTC (
    	.state(state),
    	.reta(reta),
    	.retb(retb),
    	.reto(reto)
    	);
    
    calculadora CAL (
    	.clk(CLK100MHZ),
    	.reset(~DBTNRES),
    	.BP(DBTNC),
    	.BD(DBTND),
    	.stat(state)
    	);
    
    FDCE_1 #(16) RETA (
    	.clk(CLK100MHZ),
    	.RST_BTN_n(CPU_RESETN),
    	.switches(SW),
    	.retain(~reta),
    	.leds(a)
    	);
    	
    FDCE_1 #(16) RETB (
    	.clk(CLK100MHZ),
    	.RST_BTN_n(CPU_RESETN),
    	.switches(SW),
    	.retain(~retb),
    	.leds(b)
    	);
    	
    FDCE_1 #(2) RETO (
    	.clk(CLK100MHZ),
    	.RST_BTN_n(CPU_RESETN),
    	.switches(SW[1:0]),
    	.retain(~reto),
    	.leds(o)
    	);
    	
    alu #(16) ALU (
    	.a(a),
    	.b(b),
    	.op(o),
    	.res(res)
    	);
    	
    clockmaster #(480) CLK240 (
    	.clk_in(CLK100MHZ),
    	.reset(1'b0),
    	.clk_out(clk480)
    	);
    	
    disp_driver DD (
    	.state(state),
    	.SW(SW),
    	.res(res),
    	.num(num)
    	);
    	
    display_bcd DISP (
    	.digs(kentra),
    	.an_on(8'b1111_1111),
    	.clk(clk480),
    	.sevenseg(sevenseg),
    	.an(AN)
    	);
    	
    clockmaster #(48) CLK48(
    	.clk_in(CLK100MHZ),
    	.reset(1'b0),
    	.clk_out(clk48)
    	);
    	
    unsigned_to_bcd CTD (
    	.clk(CLK100MHZ),
    	.trigger(DBTNU),
    	.in(num),
    	.bcd(bcdd)
    	);
    
    always_comb begin
    if (state == 3'b011) begin
    	if (res[16]==1'b1) begin
    		LED16_R = clk48;
    		LED16_G = 1'b0;
    		end
    	else begin
    		LED16_R = 1'b0;
    		LED16_G = clk48;
    		end
    	end
    else begin
    	LED16_R = 1'b0;
    	LED16_G = 1'b0;
    	end
    end
    
    always_comb begin
    	if (DBTNU) begin
    		kentra = bcdd;
    	end
    	else begin
    		kentra = num;
    	end
    end
endmodule
