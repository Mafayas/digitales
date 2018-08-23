`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.08.2018 17:33:53
// Design Name: 
// Module Name: clk_ss
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


module clk_ss(
    input logic clk1000,
    input logic BTNL, BTNR, BTNC, BTNLP, BTNRP, BTNCP,
    input logic SW,
    output logic LED,
    output logic [31:0] hora_completa
    );
    
    logic [7:0] seg, segn;       //seg_1 es el numero de la izquierda y seg_2 es el numero de la derecha ej de hora: "00:00:seg_1 seg_2"
    logic [7:0] min, minn;       //min_1 es el numero de la izquierda y min_2 es el numero de la derecha ej de hora: "00:min_1 min_2:00"
    logic [7:0] hora, horan, horaq;     //hora_1 es el numero de la izquierda y hora_2 es el numero de la derecha ej de hora: "hora_1 hora_2:00:00"
    logic [9:0] cn;
    logic [11:0] cnt3s;
    logic [8:0]cnt05s;
    logic [31:0] segb, minb, horab;
    logic aum_minc, aum_horac;
    
    
    unsigned_to_bcd SEG (
    	.clk(clk1000),
    	.trigger(1'b1),
    	.in({23'd0,seg}),
    	.idle(),
    	.bcd(segb)
    	);
    	
    unsigned_to_bcd MIN (
    	.clk(clk1000),
    	.trigger(1'b1),
    	.in({23'd0,min}),
    	.idle(),
    	.bcd(minb)
    	);
    	
    unsigned_to_bcd HOR (
    	.clk(clk1000),
    	.trigger(1'b1),
    	.in({23'd0,horaq}),
    	.idle(),
    	.bcd(horab)
    	);
    
    assign LED = SW;
	assign hora_completa = {horab[7:0], 4'd0, minb[7:0], 4'd0, segb[7:0]};
	
	always_comb begin

			if (seg < 'd59) begin
				segn = seg + 'd1;
				aum_minc = 1'd0;
			end
			else begin
				segn = 'd0;
				aum_minc = 1'd1;
			end
			if (aum_minc | BTNL) begin
				if (min < 'd59) begin
					minn = min + 'd1;
					aum_horac = 1'd0;
				end
				else begin
					minn = 'd0;
					aum_horac = 1'd1;
				end
			end
			else begin
				minn = min;
				aum_horac = 1'd0;
			end
			if (aum_horac | BTNR) begin
				if (hora < 'd23) begin
					horan = hora + 'd1;
				end
				else begin
					horan = 'd0;
				end
			end
			else
				horan = hora;	

		
		if (SW) begin
			if (hora < 'd13)
				horaq = hora;
			else
				horaq = hora - 'd12;
		end
		else
			horaq = hora;
	end
    
    always_ff@(posedge clk1000) begin
    	cn <= cn + 'd1;
    	cnt3s <= 'd0;
    	cnt05s <= 'd0;
    	if ((cn == 'd1000) & ~BTNC & ~BTNL & ~BTNR) begin
			seg <= segn;
			min <= minn;
			hora <= horan;
		end
		if (BTNC) begin
			cn <= 1'b0;
			seg <= 'd0;
		end
		if (BTNL) begin
			cn <= 1'b0;
			if (cnt3s == 'd0) begin
				min <= minn;
				cnt3s <= cnt3s + 'd1;
			end
			else if (cnt3s == 'd3000) begin
				cnt3s <= 'd3000;
				cnt05s <= cnt05s + 'd1;
				if (cnt05s == 'd500) begin
					min <= minn;
					cnt05s <= 'd0;
				end
			end
			else
				cnt3s <= cnt3s +'d1;
		end
		if (BTNR) begin
			cn <= 1'b0;
			if (cnt3s == 'd0) begin
				hora <= horan;
				cnt3s <= cnt3s + 'd1;
			end
			else if (cnt3s == 'd3000) begin
				cnt3s <= 'd3000;
				cnt05s <= cnt05s + 'd1;
				if (cnt05s == 'd500) begin
					hora <= horan;
					cnt05s <= 'd0;
				end
			end
			else
				cnt3s <= cnt3s +'d1;
		end
    end
    
	
    
    // AM PM o 24 horas
    // si esta activado el switch y la hora pasa las 12, entonces se le restara 12 a la hora y se prendera el led

    
endmodule
