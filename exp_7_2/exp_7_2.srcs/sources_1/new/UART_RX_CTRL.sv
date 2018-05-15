`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2018 19:39:37
// Design Name: 
// Module Name: UART_RX_CTRL
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


module UART_RX_CTRL(
	input logic rx_ready,
	input logic [7:0]rx_data,
	input logic reset,
	input logic clk,
	output logic [15:0]operando1,
	output logic [15:0]operando2,
	output logic [2:0]ALU_ctrl,
	output logic [3:0]stt
    );
    
    enum logic [3:0] {Wait_OP1_LSB,Store_OP1_LSB,Wait_OP1_MSB,Store_OP1_MSB,Wait_OP2_LSB,Store_OP2_LSB,Wait_OP2_MSB,Store_OP2_MSB,Wait_CMD,Store_CMD,Delay_1_cycle,Trigger_TX_result} state, nextstate;
    logic [7:0] OP1_LSB, OP1_MSB, OP2_LSB, OP2_MSB;
    logic [7:0] ALU_ctrl_stored;
    
    assign operando1 = {OP1_MSB,OP1_LSB};
    assign operando2 = {OP2_MSB,OP2_LSB};
    assign ALU_ctrl = ALU_ctrl_stored[2:0];
    assign stt = state;
    
    always_ff@(posedge clk) begin
        if (reset) state <= Wait_OP1_LSB;
        else state <= nextstate;
    end
    
    always_comb begin
		nextstate = state;
        case(state)
        	Wait_OP1_LSB: begin
                if (rx_ready)
                    nextstate = Store_OP1_LSB;
                end
        	Store_OP1_LSB: begin
                if (OP1_LSB == rx_data) 
                    nextstate = Wait_OP1_MSB;
                end
        	Wait_OP1_MSB: begin
                if (rx_ready)
                    nextstate = Store_OP1_MSB;
                end
        	Store_OP1_MSB: begin
                if (OP1_MSB == rx_data) 
                    nextstate = Wait_OP2_LSB;
                end
        	Wait_OP2_LSB: begin
                if (rx_ready)
                    nextstate = Store_OP2_LSB;
                end
        	Store_OP2_LSB: begin
                if (OP2_LSB == rx_data) 
                    nextstate = Wait_OP2_MSB;
                end
        	Wait_OP2_MSB: begin
                if (rx_ready)
                    nextstate = Store_OP2_MSB;
                end
        	Store_OP2_MSB: begin
                if (OP2_MSB == rx_data) 
                    nextstate = Wait_CMD;
                end
        	Wait_CMD: begin
        		if (rx_ready)
        			nextstate = Store_CMD;
        		end
        	Store_CMD: begin
        		if (ALU_ctrl_stored == rx_data)
        			nextstate = Delay_1_cycle;
        		end
        	Delay_1_cycle: begin
        		nextstate = Trigger_TX_result;
        		end
        	Trigger_TX_result: begin
        		nextstate = Wait_OP1_LSB;
        		end
        	default: nextstate = Wait_OP1_LSB;
        endcase
        end
    
    FDCE_1 #(8) RET_OP_1_LSB (
        .clk(clk),
        .RST_BTN_n(1'b1),
        .switches(rx_data),
        .retain(~(state == Store_OP1_LSB)),
        .leds(OP1_LSB)
        );
        
    FDCE_1 #(8) RET_OP_1_MSB (
        .clk(clk),
        .RST_BTN_n(1'b1),
        .switches(rx_data),
        .retain(~(state == Store_OP1_MSB)),
        .leds(OP1_MSB)
        );
        
    FDCE_1 #(8) RET_OP_2_LSB (
        .clk(clk),
        .RST_BTN_n(1'b1),
        .switches(rx_data),
        .retain(~(state == Store_OP2_LSB)),
        .leds(OP2_LSB)
        );
        
    FDCE_1 #(8) RET_OP_2_MSB (
        .clk(clk),
        .RST_BTN_n(1'b1),
        .switches(rx_data),
        .retain(~(state == Store_OP2_MSB)),
        .leds(OP2_MSB)
        );
        
    FDCE_1 #(8) RET_ALU_ctrl (
        .clk(clk),
        .RST_BTN_n(1'b1),
        .switches(rx_data),
        .retain(~(state == Store_CMD)),
        .leds(ALU_ctrl_stored)
        );
    
endmodule
