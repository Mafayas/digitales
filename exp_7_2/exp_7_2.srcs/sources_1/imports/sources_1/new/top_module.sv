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
	input logic CLK100MHZ,
	input logic CPU_RESETN,
	input logic UART_TXD_IN,
	output logic LED16_R,
	output logic LED16_G,
	output logic [3:0]LED,
	output logic [6:0]C,
	output logic [7:0]AN
    );
    
    logic [3:0]state;
    logic [15:0]a,b;
    logic [2:0]o;
    logic [16:0]res;
    logic [7:0]rx_data;
    logic rx_ready;
    logic [31:0]num,numd;
    logic clk480;
    logic clk48;
    
    assign LED = state;
    
    uart_basic UART (
    	.clk(CLK100MHZ),
    	.reset(1'b0), //0?
    	.rx(UART_TXD_IN), //????
    	.rx_data(rx_data),
    	.rx_ready(rx_ready),
    	.tx(),
    	.tx_start(),
    	.tx_data(),
    	.tx_busy()
    	);
    
    UART_RX_CTRL URC (
    	.rx_ready(rx_ready),
    	.rx_data(rx_data),
    	.reset(~CPU_RESETN),
    	.clk(CLK100MHZ),
    	.operando1(a), //16b
    	.operando2(b), //16b
    	.ALU_ctrl(o),  //3b
    	.stt(state)
    	);
    	
    alu #(16) ALU (
    	.a(a),
    	.b(b),
    	.op(o[1:0]),
    	.res(res)
    	);
    	
    disp_driver DD (
    	.state(state),
    	.a(a),
    	.b(b),
    	.res(res),
    	.num(num)
    	);
    	
    unsigned_to_bcd HTD (
    	.clk(CLK100MHZ),
    	.trigger(1'b1),
    	.in(num),
    	.bcd(numd)
    	);
    	
    clockmaster #(480) (
    	.clk_in(CLK100MHZ),
    	.reset(1'b0),
    	.clk_out(clk480)
    	);
    	
    display_bcd DISP (
    	.digs(numd),
    	.an_on(8'b1111_1111),
    	.clk(clk480), //480hz
    	.sevenseg(C),
    	.an(AN)
    	);
    	
    clockmaster #(48) (
    	.clk_in(CLK100MHZ),
    	.reset(1'b0),
    	.clk_out(clk48)
    	);
    	
    always_comb begin
    	if (state == 4'd0 |state == 4'd11) begin
    		if (res[16] == 1'b1) begin
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
    
endmodule
