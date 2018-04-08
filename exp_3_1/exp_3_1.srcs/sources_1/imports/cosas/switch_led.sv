`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.04.2018 21:23:23
// Design Name: 
// Module Name: switch_led
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


module switch_led(
	input logic sw0,sw1,sw2,sw3,sw4,sw5,sw6,sw7,sw8,sw9,swa,swb,swc,swd,swe,swf,
	output logic led0,led1,led2,led3,led4,led5,led6,led7,led8,led9,leda,ledb,ledc,ledd,lede,ledf
    );
    
    assign led0 = sw0;
    assign led1 = sw1;
    assign led2 = sw2;
    assign led3 = sw3;
    assign led4 = sw4;
    assign led5 = sw5;
    assign led6 = sw6;
    assign led7 = sw7;
    assign led8 = sw8;
  	assign led9 = sw9;
   	assign leda = swa;
    assign ledb = swb;
    assign ledc = swc;
    assign ledd = swd;
    assign lede = swe;
    assign ledf = swf;
endmodule
