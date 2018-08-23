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
	output logic [17:0]adress,
	output logic [23:0]pix,
	output logic  wenable
    );
    
    enum logic [3:0] {Wait_R,Store_R,Wait_G,Store_G,Wait_B,Store_B,Save} state, nextstate;
    logic [7:0] R, G, B;
    
    assign pix = {R,G,B};
    
    always_ff@(posedge clk) begin
        if (reset) begin
        	state <= Wait_R;
        	wenable <= 1'b0;
        	adress <= 'd0;
        end
        else begin
            state <= nextstate;
        	if ((state == Store_B) & (nextstate == Wait_R))
        		wenable <= 1'b1;
       		else
       			wenable <= 1'b0;
        	if (wenable == 1'b1)
        		adress <= adress + 'd1;
        	else
        		adress <= adress;
        end
    end
    
    always_comb begin
		nextstate = state;
        case(state)
        	Wait_R: begin
                if (rx_ready)
                    nextstate = Store_R;
                end
        	Store_R: begin
                if (R == rx_data) 
                    nextstate = Wait_G;
                end
        	Wait_G: begin
                if (rx_ready)
                    nextstate = Store_G;
                end
        	Store_G: begin
                if (G == rx_data) 
                    nextstate = Wait_B;
                end
        	Wait_B: begin
                if (rx_ready)
                    nextstate = Store_B;
                end
        	Store_B: begin
                if (B == rx_data) 
                    nextstate = Wait_R;
                end
        	default: nextstate = state;
        endcase
        end
    
    FDCEret_1 #(8) RET_R (
        .clk(clk),
        .RST_BTN_n(~reset),
        .switches(rx_data),
        .retain(~(state == Store_R)),
        .leds(R)
        );
        
    FDCEret_1 #(8) RET_G (
        .clk(clk),
        .RST_BTN_n(~reset),
        .switches(rx_data),
        .retain(~(state == Store_G)),
        .leds(G)
        );
        
    FDCEret_1 #(8) RET_B (
        .clk(clk),
        .RST_BTN_n(~reset),
        .switches(rx_data),
        .retain(~(state == Store_B)),
        .leds(B)
        );
    
endmodule
