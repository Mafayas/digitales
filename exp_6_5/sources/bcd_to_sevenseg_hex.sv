`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03.04.2018 16:06:42
// Design Name: 
// Module Name: bcd_to_sevenseg
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


module bcd_to_sevenseg_hex(
	input logic [3:0] bcd,
	output logic [6:0] sevenseg
    );
    
    always_comb
    begin
    	case(bcd)
    		4'd0:	sevenseg = 7'b0000001;
    		4'd1:	sevenseg = 7'b1001111;
    		4'd2:	sevenseg = 7'b0010010;
    		4'd3:	sevenseg = 7'b0000110;
    		4'd4:	sevenseg = 7'b1001100;
    		4'd5:	sevenseg = 7'b0100100;
    		4'd6:	sevenseg = 7'b0100000;
    		4'd7:	sevenseg = 7'b0001111;
    		4'd8:	sevenseg = 7'b0000000;
    		4'd9:	sevenseg = 7'b0001100;
    		4'd10:	sevenseg = 7'b0001000;
    		4'd11:	sevenseg = 7'b1100000;
    		4'd12:	sevenseg = 7'b0110001;
    		4'd13:	sevenseg = 7'b1000010;
    		4'd14:	sevenseg = 7'b0110000;
    		4'd15:	sevenseg = 7'b0111000;
    		default: sevenseg = 7'b1111111;
    	endcase
    end
endmodule
