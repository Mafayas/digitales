`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.05.2018 22:44:01
// Design Name: 
// Module Name: calculadora
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


module calculadora(
input logic clk, reset, BP,
output logic [2:0] leds
    );
logic [3:0] waitop1, waitop2,wait_operation,show_result;
logic [2:0] state, nextstate;

always_ff@(posedge clk) begin
    if (reset) state <= waitop1;
    else state <= nextstate;
end

always_comb begin
    //if (reset) nextstate = waitop1;
    case(state)
    waitop1:begin
            leds = 1'b0;
            if (BP) 
                nextstate = waitop2;
            else 
                nextstate = waitop1;
            end
    waitop2:begin
            leds = 1'b1;
            if (BP) 
                nextstate = wait_operation;
            else 
                nextstate = waitop2;
            end
    wait_operation:begin
            leds = 2'b0;
            if (BP)
                nextstate = show_result;
            else 
                nextstate = wait_operation;
            end
    show_result:begin
            leds = 3'b1;
            if (BP) 
                nextstate = waitop1;
            else 
                nextstate = show_result;
            end
    default nextstate = waitop1;
    endcase
    end
 
endmodule
