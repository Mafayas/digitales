`timescale 1ns / 1ps

module top_mod(
	input logic [7:0]a,
	input logic [7:0]b,
	input logic [3:0]btns,
	input logic CLK100MHZ,
	input logic BTNC,
	output logic [15:0]leds,
	output logic [7:0]an,
	output logic [6:0]sevenseg
    );
    
    logic [2:0]op;
    logic [7:0]res;
    logic [7:0]an_on;
    logic [31:0]bcd;
    logic [31:0]bcdd;
    logic reset = 0;
    logic clk480;
    logic [31:0]bcdn;
    
    btns_op BTN (
    	.btns(btns),
    	.op(op)
    );
    
    alu ALU (
    	.a(a),
    	.b(b),
    	.op(op),
    	.res(res)
    	);
    	
    led_driver LED (
    	.op(op),
    	.res(res),
    	.a(a),
    	.b(b),
    	.leds(leds)
    	);
    	
    an_on_driver AN (
    	.op(op),
    	.an_on(an_on)
    	);
    	
    display_driver DD (
    	.op(op),
    	.a(a),
    	.b(b),
    	.res(res),
    	.bcd(bcd)
    	);
    	
    clockmaster #(480) CLK (
    	.clk_in(CLK100MHZ),
    	.reset(reset),
    	.clk_out(clk480)
    	);
    	
    display_bcd DISP (
    	.digs(bcdn),
    	.an_on(an_on),
    	.clk(clk480),
    	.sevenseg(sevenseg),
    	.an(an)
    	);
    	
    unsigned_to_bcd HTD (
    	.clk(CLK100MHZ),
    	.trigger(BTNC),
    	.in(bcd),
    	.bcd(bcdd)
    	);
    	
    always_comb begin
    	if (BTNC) begin
    		bcdn = bcdd;
    	end
    	else begin
    		bcdn = bcd;
    	end
    end
    	
endmodule
