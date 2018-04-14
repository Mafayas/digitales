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


module ascii8bit_to_sevenseg_ltr(
	input logic [7:0] ent,
	output logic [6:0] sevenseg
    );
    
    always_comb
    begin
    	case(ent)
    		8'd32:	sevenseg = 7'b1111111;
    		8'd48:	sevenseg = 7'b0000001;
    		8'd49:	sevenseg = 7'b1001111;
    		8'd50:	sevenseg = 7'b0010010;
    		8'd51:	sevenseg = 7'b0000110;
    		8'd52:	sevenseg = 7'b1001100;
    		8'd53:	sevenseg = 7'b0100100;
    		8'd54:	sevenseg = 7'b0100000;
    		8'd55:	sevenseg = 7'b0001111;
    		8'd56:	sevenseg = 7'b0000000;
    		8'd57:	sevenseg = 7'b0001100;
    		8'd65:	sevenseg = 7'b0001000;
    		8'd66:	sevenseg = 7'b1100000;
    		8'd67:	sevenseg = 7'b0110001;
    		8'd68:	sevenseg = 7'b1000010;
    		8'd69:	sevenseg = 7'b0110000;
    		8'd70:	sevenseg = 7'b0111000;
    		8'd71:	sevenseg = 7'b0000100;
    		8'd72:	sevenseg = 7'b1001000;
    		8'd73:	sevenseg = 7'b1111001;
    		8'd74:	sevenseg = 7'b1000011;
    		8'd75:	sevenseg = 7'b1001000;
    		8'd76:	sevenseg = 7'b1110001;
    		8'd77:	sevenseg = 7'b0001001;
    		8'd78:	sevenseg = 7'b1101010;
    		8'd79:	sevenseg = 7'b1100010;
    		8'd80:	sevenseg = 7'b0011000;
    		8'd81:	sevenseg = 7'b0001100;
    		8'd82:	sevenseg = 7'b1111010;
    		8'd83:	sevenseg = 7'b0100100;
    		8'd84:	sevenseg = 7'b1110000;
    		8'd85:	sevenseg = 7'b1000001;
    		8'd86:	sevenseg = 7'b1100011;
    		8'd87:	sevenseg = 7'b1100011;
    		8'd88:	sevenseg = 7'b1001000;
    		8'd89:	sevenseg = 7'b1000100;
    		8'd90:	sevenseg = 7'b0010010;
    		default: sevenseg = 7'b1111111;
    	endcase
    end
endmodule
