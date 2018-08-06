module lab_8(
	input CLK100MHZ,
	input [1:0]SW,
	input BTNC,	BTNU, BTNL, BTNR, BTND, CPU_RESETN,
	output [15:0] LED,
	output CA, CB, CC, CD, CE, CF, CG,
	output DP,
	output [7:0] AN,

	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	
	
	logic CLK82MHZ;
	logic rst = 0;
	logic hw_rst = ~CPU_RESETN;
	
	clk_wiz_0 inst(
		// Clock out ports  
		.clk_out1(CLK82MHZ),
		// Status and control signals               
		.reset(1'b0), 
		//.locked(locked),
		// Clock in ports
		.clk_in1(CLK100MHZ)
		);
	//Fill here
	



	/************************* VGA ********************/
	logic [2:0] op;
	logic [2:0] pos_x;
	logic [1:0] pos_y;
	logic [15:0] op1, op2;

	calculator_screen(
		.clk_vga(CLK82MHZ),
		.rst(rst),
		.mode(SW[0]),
		.op(op),
		.pos_x(pos_x),
		.pos_y(pos_y),
		.op1(op1),
		.op2(op2),
		.input_screen(16'd0),
		
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B));

endmodule

/**
 * @brief Este modulo convierte un numero hexadecimal de 4 bits
 * en su equivalente ascii de 8 bits
 *
 * @param hex_num		Corresponde al numero que se ingresa
 * @param ascii_conv	Corresponde a la representacion ascii
 *
 */

module hex_to_ascii(
	input [3:0] hex_num,
	output logic[7:0] ascii_conv
	);

	//fill here
endmodule


/**
 * @brief Este modulo convierte un numero hexadecimal de 4 bits
 * en su equivalente ascii, pero binario, es decir,
 * si el numero ingresado es 4'hA, la salida debera sera la concatenacion
 * del string "1010" (cada caracter del string genera 8 bits).
 *
 * @param num		Corresponde al numero que se ingresa
 * @param bit_ascii	Corresponde a la representacion ascii pero del binario.
 *
 */
module hex_to_bit_ascii(
	input [3:0]num,
	output [4*8-1:0]bit_ascii
	);

	//fill Here
	
endmodule


/**
 * @brief Este modulo es el encargado de dibujar en pantalla
 * la calculadora y todos sus componentes graficos
 *
 * @param clk_vga		:Corresponde al reloj con que funciona el VGA.
 * @param rst			:Corresponde al reset de todos los registros
 * @param mode			:'0' si se esta operando en decimal, '1' si esta operando hexadecimal
 * @param op			:La operacion matematica a realizar
 * @param pos_x			:Corresponde a la posicion X del cursor dentro de la grilla.
 * @param pos_y			:Corresponde a la posicion Y del cursor dentro de la grilla.
 * @param op1			:El operando 1 en formato hexadecimal.
 * @param op2			;El operando 2 en formato hexadecimal.
 * @param input_screen	:Lo que se debe mostrar en la pantalla de ingreso de la calculadora (en hexa)
 * @param VGA_HS		:Sincronismo Horizontal para el monitor VGA
 * @param VGA_VS		:Sincronismo Vertical para el monitor VGA
 * @param VGA_R			:Color Rojo para la pantalla VGA
 * @param VGA_G			:Color Verde para la pantalla VGA
 * @param VGA_B			:Color Azul para la pantalla VGA
 */
module calculator_screen(
	input clk_vga,
	input rst,
	input mode, //bcd or dec.
	input [2:0]op,
	input [2:0]pos_x,
	input [1:0]pos_y,
	input [15:0] op1,
	input [15:0] op2,
	input [15:0] input_screen,
	
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	
	
	localparam CUADRILLA_XI = 		212;
	localparam CUADRILLA_XF = 		CUADRILLA_XI + 600;
	
	localparam CUADRILLA_YI = 		300;
	localparam CUADRILLA_YF = 		CUADRILLA_YI + 400;
	
	
	logic [10:0]vc_visible,hc_visible;
	
	// MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	driver_vga_1024x768 m_driver(
		.clk_vga(clk_vga),
		.hs(VGA_HS),
		.vs(VGA_VS),
		.hc_visible(hc_visible),
		.vc_visible(vc_visible)
		);
	/*************************** VGA DISPLAY ************************/
		
	logic [10:0]hc_template, vc_template;
	logic [2:0]matrix_x;
	logic [1:0]matrix_y;
	logic lines;
	
	template_6x4_600x400 #( .GRID_XI(CUADRILLA_XI), 
							.GRID_XF(CUADRILLA_XF), 
							.GRID_YI(CUADRILLA_YI), 
							.GRID_YF(CUADRILLA_YF)) 
    // MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	template_1(
		.clk(clk_vga),
		.hc(hc_visible),
		.vc(vc_visible),
		.matrix_x(matrix_x),
		.matrix_y(matrix_y),
		.lines(lines)
		);
	
	logic [11:0]VGA_COLOR;
	
	logic text_sqrt_fg;
	logic text_sqrt_bg;

	logic [39:0]generic_fg;
	logic [39:0]generic_bg;	

	localparam GRID_X_OFFSET	= 25;
	localparam GRID_Y_OFFSET	= 18;
	
	localparam FIRST_SQRT_X = 212;
	localparam FIRST_SQRT_Y = 300;
	
//	hello_world_text_square m_hw(	.clk(clk_vga), 
//									.rst(1'b0), 
//									.hc_visible(hc_visible), 
//									.vc_visible(vc_visible), 
//									.in_square(text_sqrt_bg), 
//									.in_character(text_sqrt_fg));

	
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
					.CHAR_Y_LOC(FIRST_SQRT_Y + GRID_Y_OFFSET)) 
	ch_00(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("0"), 
		  .in_square(generic_bg[0]), 
		  .in_character(generic_fg[0]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET), 
		  			.CHAR_Y_LOC(FIRST_SQRT_Y + GRID_Y_OFFSET)) 
	ch_01(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("1"), 
		  .in_square(generic_bg[1]), 
		  .in_character(generic_fg[1]));
		  	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET), 
		  	  		.CHAR_Y_LOC(FIRST_SQRT_Y + GRID_Y_OFFSET)) 
	ch_02(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("2"), 
		  .in_square(generic_bg[2]), 
		  .in_character(generic_fg[2]));
		  	  	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET), 
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + GRID_Y_OFFSET)) 
	ch_03(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("3"), 
		  .in_square(generic_bg[3]), 
		  .in_character(generic_fg[3]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
	ch_04(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("4"), 
		  .in_square(generic_bg[4]), 
		  .in_character(generic_fg[4]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET), 
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
	ch_05(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("5"), 
		  .in_square(generic_bg[5]), 
		  .in_character(generic_fg[5]));
		  	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET), 
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
	ch_06(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("6"), 
		  .in_square(generic_bg[6]), 
		  .in_character(generic_fg[6]));
		  	  	  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET), 
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
	ch_07(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("7"), 
		  .in_square(generic_bg[7]), 
		  .in_character(generic_fg[7]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET), 
		  		  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
	ch_08(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("8"), 
		  .in_square(generic_bg[8]), 
		  .in_character(generic_fg[8]));
		  		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET),
		  	  		.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
	ch_09(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("9"), 
		  .in_square(generic_bg[9]), 
		  .in_character(generic_fg[9]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
	ch_10(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("a"), 
		  .in_square(generic_bg[10]), 
		  .in_character(generic_fg[10]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
	ch_11(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("b"), 
		  .in_square(generic_bg[11]), 
		  .in_character(generic_fg[11]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*0 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
	ch_12(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("c"), 
		  .in_square(generic_bg[12]), 
		  .in_character(generic_fg[12]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*1 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
	ch_13(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("d"), 
		  .in_square(generic_bg[13]), 
		  .in_character(generic_fg[13]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*2 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
	ch_14(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("e"), 
		  .in_square(generic_bg[14]), 
		  .in_character(generic_fg[14]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*3 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*3 + GRID_Y_OFFSET)) 
	ch_15(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("f"), 
		  .in_square(generic_bg[15]), 
		  .in_character(generic_fg[15]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
	ch_16(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("+"), 
		  .in_square(generic_bg[16]), 
		  .in_character(generic_fg[16]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*0 + GRID_Y_OFFSET)) 
	ch_17(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("-"), 
		  .in_square(generic_bg[17]), 
		  .in_character(generic_fg[17]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
	ch_18(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("*"), 
		  .in_square(generic_bg[18]), 
		  .in_character(generic_fg[18]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*5 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*1 + GRID_Y_OFFSET)) 
	ch_19(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("|"), 
		  .in_square(generic_bg[19]), 
		  .in_character(generic_fg[19]));
		  
	show_one_char #(.CHAR_X_LOC(FIRST_SQRT_X + 100*4 + GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(FIRST_SQRT_Y + 100*2 + GRID_Y_OFFSET)) 
	ch_20(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char("&"), 
		  .in_square(generic_bg[20]), 
		  .in_character(generic_fg[20]));
		  
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*5 + 17), 
		  			.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*2 + 27), 
		  			.MAX_CHARACTER_LINE(2), 
		  			.ancho_pixel(5), 
		  			.n(3)) 
	ce(	.clk(clk_vga), 
		 	.rst(rst), 
		  	.hc_visible(hc_visible), 
		  	.vc_visible(vc_visible), 
		  	.the_line("CE"), 
		  	.in_square(generic_bg[21]), 
		  	.in_character(generic_fg[21]));
	
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*4 + 2), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*3 + 27), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
	exe(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("EXE"), 
			.in_square(generic_bg[22]), 
			.in_character(generic_fg[22]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 100*5 + 2), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y + 100*3 + 27), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(5), 
					.n(3)) 
	clr(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("CLR"), 
			.in_square(generic_bg[23]), 
			.in_character(generic_fg[23]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(3), 
					.n(3)) 
	p24(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("0000"), 
			.in_square(generic_bg[24]), 
			.in_character(generic_fg[24]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 100), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(3), 
					.n(3)) 
	p25(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("0000"), 
			.in_square(generic_bg[25]), 
			.in_character(generic_fg[25]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 200), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(3), 
					.n(3)) 
	p26(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("0000"), 
			.in_square(generic_bg[26]), 
			.in_character(generic_fg[26]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 300), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34), 
					.MAX_CHARACTER_LINE(4), 
					.ancho_pixel(3), 
					.n(3)) 
	p27(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("0000"), 
			.in_square(generic_bg[27]), 
			.in_character(generic_fg[27]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94), 
					.MAX_CHARACTER_LINE(5), 
					.ancho_pixel(8), 
					.n(4)) 
	p28(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("00000"), 
			.in_square(generic_bg[28]), 
			.in_character(generic_fg[28]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 220 + 48), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 + 4), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(3), 
					.n(3)) 
	p29(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("HEX"), 
			.in_square(generic_bg[29]), 
			.in_character(generic_fg[29]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 220 + 48), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 + 4 + 24 + 6), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(3), 
					.n(3)) 
	p30(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("DEC"), 
			.in_square(generic_bg[30]), 
			.in_character(generic_fg[30]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 220 + 57 + 48), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 + 4), 
					.MAX_CHARACTER_LINE(1), 
					.ancho_pixel(3), 
					.n(3)) 
	p38(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line(8'b01111111), 
			.in_square(generic_bg[38]), 
			.in_character(generic_fg[38]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 220 + 57 + 48), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 + 4 + 24 + 6), 
					.MAX_CHARACTER_LINE(1), 
					.ancho_pixel(3), 
					.n(3)) 
	p31(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line(8'b01111111), 
			.in_square(generic_bg[31]), 
			.in_character(generic_fg[31]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 - 27 - 20), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(3), 
					.n(3)) 
	p34(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("op "), 
			.in_square(generic_bg[34]), 
			.in_character(generic_fg[34]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 - 27 - 20 - 27 - 20), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(3), 
					.n(3)) 
	p33(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("op2"), 
			.in_square(generic_bg[33]), 
			.in_character(generic_fg[33]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 - 27 - 20 - 27 - 20 - 27 - 20), 
					.MAX_CHARACTER_LINE(3), 
					.ancho_pixel(3), 
					.n(3)) 
	p32(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("op1"), 
			.in_square(generic_bg[32]), 
			.in_character(generic_fg[32]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 77), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 - 27 - 20), 
					.MAX_CHARACTER_LINE(1), 
					.ancho_pixel(3), 
					.n(3)) 
	p37(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("+"), 
			.in_square(generic_bg[37]), 
			.in_character(generic_fg[37]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 77), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 - 27 - 20 - 27 - 20), 
					.MAX_CHARACTER_LINE(5), 
					.ancho_pixel(3), 
					.n(3)) 
	p36(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("00000"), 
			.in_square(generic_bg[36]), 
			.in_character(generic_fg[36]));
			
	show_one_line #(.LINE_X_LOCATION(FIRST_SQRT_X + 112 + 77), 
					.LINE_Y_LOCATION(FIRST_SQRT_Y - 34 - 94 - 27 - 20 - 27 - 20 - 27 - 20), 
					.MAX_CHARACTER_LINE(5), 
					.ancho_pixel(3), 
					.n(3)) 
	p35(	.clk(clk_vga), 
			.rst(rst), 
			.hc_visible(hc_visible), 
			.vc_visible(vc_visible), 
			.the_line("00000"), 
			.in_square(generic_bg[35]), 
			.in_character(generic_fg[35]));
			
	logic [7:0]sw0c;
	assign sw0c = mode? "1":"0";
	
	show_one_char #(.CHAR_X_LOC(GRID_X_OFFSET),
		  	  	  	.CHAR_Y_LOC(GRID_Y_OFFSET)) 
	ch_39(.clk(clk_vga), 
		  .rst(rst), 
		  .hc_visible(hc_visible), 
		  .vc_visible(vc_visible), 
		  .the_char(sw0c), 
		  .in_square(generic_bg[39]), 
		  .in_character(generic_fg[39]));
	
	logic draw_cursor = (pos_x == matrix_x) && (pos_y == matrix_y);
	
	
	localparam COLOR_BLUE 		= 12'h00F;
	localparam COLOR_YELLOW 	= 12'hFF0;
	localparam COLOR_RED		= 12'hF00;
	localparam COLOR_BLACK		= 12'h000;
	localparam COLOR_WHITE		= 12'hFFF;
	localparam COLOR_CYAN		= 12'h0FF;
	localparam COLOR_GREEN		= 12'h0F0;
	localparam COLOR_MAGENTA	= 12'hF0F;
	
	always@(*)
		if((hc_visible != 0) && (vc_visible != 0))
		begin
			
			if(text_sqrt_fg)
				VGA_COLOR = COLOR_RED;
			else if (text_sqrt_bg)
				VGA_COLOR = COLOR_YELLOW;
			else if(|generic_fg)
				VGA_COLOR = COLOR_BLACK;
			else if(generic_bg)
				VGA_COLOR = COLOR_WHITE;
			
			//si esta dentro de la grilla.
			else if((hc_visible > CUADRILLA_XI) && (hc_visible <= CUADRILLA_XF) && (vc_visible > CUADRILLA_YI) && (vc_visible <= CUADRILLA_YF))
				if(lines)//lineas negras de la grilla
					VGA_COLOR = COLOR_BLACK;
				else if (draw_cursor) //el cursor
					VGA_COLOR = COLOR_YELLOW;
				else
					VGA_COLOR = COLOR_WHITE;// el fondo de la grilla.
			else
				VGA_COLOR = COLOR_RED;//el fondo de la pantalla
		end
		else
			VGA_COLOR = COLOR_BLACK;//esto es necesario para no poner en riesgo la pantalla.

	assign {VGA_R, VGA_G, VGA_B} = VGA_COLOR;
endmodule



/**
 * @brief Este modulo cambia los ceros a la izquierda de un numero, por espacios
 * @param value			:Corresponde al valor (en hexa o decimal) al que se le desea hacer el padding.
 * @param no_pading		:Corresponde al equivalente ascii del value includos los ceros a la izquierda
 * @param padding		:Corresponde al equivalente ascii del value, pero sin los ceros a la izquierda.
 */

module space_padding(
	input [19:0] value,
	input [8*6 -1:0]no_pading,
	
	output logic [8*6 -1:0]padding);
	
	
endmodule
