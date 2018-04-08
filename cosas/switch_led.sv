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
    
    always_comb
    begin
    	led0 = sw0;
    	led1 = sw1;
    	led2 = sw2;
    	led3 = sw3;
    	led4 = sw4;
    	led5 = sw5;
    	led6 = sw6;
    	led7 = sw7;
    	led8 = sw8;
  		led9 = sw9;
   		leda = swa;
    	ledb = swb;
    	ledc = swc;
    	ledd = swd;
    	lede = swe;
    	ledf = swf;
    end
endmodule
