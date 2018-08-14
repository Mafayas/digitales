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
	logic up, down, right, left, center;
	logic [4:0]val;
	logic clk50mhz;
	logic [15:0] num;
	logic [7:0] numa1, numa2, numa3, numa4;
	logic [15:0] a, b;
	logic [15:0] operacion;
	logic [2:0]stt;
	logic save;
	logic [15:0]res;


	calculator_screen(
		.clk_vga(CLK82MHZ),
		.rst(rst),
		.mode(SW[0]),
		.op(operacion),
		.pos_x(pos_x),
		.pos_y(pos_y),
		.a(a),
		.b(b),
		.input_screen(16'd0),
		.numa1(numa1),
		.numa2(numa2),
		.numa3(numa3),
		.numa4(numa4),
		
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B));

	grid_cursor(
		.clk(CLK82MHZ),
		.rst(hw_rst),
		.restriction(SW[0]),
		.dir_up(up),
		.dir_down(down),
		.dir_left(left),
		.dir_right(right),
		.pos_x(pos_x),
		.pos_y(pos_y),
		.val(val)
		);
		
	num_ingresado NUM (
		.bc(center),
		.clk(CLK82MHZ),
		.val(val),
		.calcstate(3'b000),
		.guardar(save),
		.op(num)
		);
		
	space_padding SPC (
		.value({4'd0,num}),
		.no_pading(),
		.padding()
		);
		
	calculadora CL (
		.clk(CLK82MHZ),
		.reset(),
		.BP(save),
		.BD(),
		.stat(stt)
		);
	
	logic reta, retb, reto;
	
	retainchange RTC (
		.state(stt),
		.reta(reta),
		.retb(retb),
		.reto(reto)
		);
		
	FDCE_1 #(16) OP1 (
		.clk(CLK82MHZ),
		.RST_BTN_n(1'b1),
		.switches(num),
		.retain(~reta),
		.leds(a)
		);
		
	FDCE_1 #(16) OP2 (
		.clk(CLK82MHZ),
		.RST_BTN_n(1'b1),
		.switches(num),
		.retain(~retb),
		.leds(b)
		);
		
	FDCE_1 #(16) OPN (
		.clk(CLK82MHZ),
		.RST_BTN_n(1'b1),
		.switches(num),
		.retain(~reto),
		.leds(operacion)
		);
			
	hex_to_ascii HTA1 (
		.hex_num(num[3:0]),
		.ascii_conv(numa1)
		);
		
	hex_to_ascii HTA2 (
		.hex_num(num[7:4]),
		.ascii_conv(numa2)
		);
		
	hex_to_ascii HTA3 (
		.hex_num(num[11:8]),
		.ascii_conv(numa3)
		);
		
	hex_to_ascii HTA4 (
		.hex_num(num[15:12]),
		.ascii_conv(numa4)
		);
			

	clockmaster #(50000000) CLK50MHZ (
		.clk_in(CLK100MHZ),
		.reset(rst),
		.clk_out(clk50mhz)
		);
	
	PB_debouncer #(20) BU (
		.clock(CLK82MHZ),
		.reset(rst),
		.PB(BTNU),
		.PB_pressed_state(),
		.PB_pressed_pulse(up),
		.PB_released_pulse()
		);
		
	PB_debouncer #(20) BD (
		.clock(CLK82MHZ),
		.reset(rst),
		.PB(BTND),
		.PB_pressed_state(),
		.PB_pressed_pulse(down),
		.PB_released_pulse()
		);
			
	PB_debouncer #(20) BL (
		.clock(CLK82MHZ),
		.reset(rst),
		.PB(BTNL),
		.PB_pressed_state(),
		.PB_pressed_pulse(left),
		.PB_released_pulse()
		);
				
	PB_debouncer #(20) BR (
		.clock(CLK82MHZ),
		.reset(rst),
		.PB(BTNR),
		.PB_pressed_state(),
		.PB_pressed_pulse(right),
		.PB_released_pulse()
		);
		
	PB_debouncer #(20) BC (
		.clock(CLK82MHZ),
		.reset(rst),
		.PB(BTNC),
		.PB_pressed_state(),
		.PB_pressed_pulse(center),
		.PB_released_pulse()
		);
		
	alu #(16) ALU (
		.a(a),
		.b(b),
		.op(operacion),
		.res(res)
		);
	
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

    always_comb begin
        if (hex_num < 4'b1010) begin
            ascii_conv = {4'b0011, hex_num};
            end
        else begin
            ascii_conv = {4'b0100, hex_num - 4'd9};
            end
    end
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
	input logic [3:0]num,
	output logic [4*8-1:0]bit_ascii
	);

  always_comb begin
       bit_ascii = {7'd24,num[3],7'd24,num[2],7'd24,num[1],7'd24,num[0]};
    end
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
	input [15:0] a,
	input [15:0] b,
	input [15:0] input_screen,
	input [7:0] numa1, numa2, numa3, numa4,
	input [15:0]res,
	input [2:0]stt,
	
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

	logic [7:0]aa1,aa2,aa3,aa4,ba1,ba2,ba3,ba4,opa, resa1, resa2,resa3,resa4;
	hex_to_ascii HTAop11 (
		.hex_num(a[15:12]),
		.ascii_conv(aa1)
		);
			
	hex_to_ascii HTop12 (
		.hex_num(a[11:8]),
		.ascii_conv(aa2)
		);
			
	hex_to_ascii HTAop13 (
		.hex_num(a[7:4]),
		.ascii_conv(aa3)
		);
			
	hex_to_ascii HTAop14 (
		.hex_num(a[3:0]),
		.ascii_conv(aa4)
		);
			
	hex_to_ascii HTAop21 (
		.hex_num(b[15:12]),
		.ascii_conv(ba1)
		);
			
	hex_to_ascii HTAop22 (
		.hex_num(b[11:8]),
		.ascii_conv(ba2)
		);
			
	hex_to_ascii HTAop23 (
		.hex_num(b[7:4]),
		.ascii_conv(ba3)
		);
			
	hex_to_ascii HTAop24 (
		.hex_num(b[3:0]),
		.ascii_conv(ba4)
		);
		
	hex_to_ascii HTAre1 (
		.hex_num(res[15:12]),
		.ascii_conv(resa1)
		);
		
	hex_to_ascii HTAre2 (
		.hex_num(res[11:8]),
		.ascii_conv(resa2)
		);
		
	hex_to_ascii HTAre3 (
		.hex_num(res[7:4]),
		.ascii_conv(resa3)
		);
		
	hex_to_ascii HTAre4 (
		.hex_num(res[3:0]),
		.ascii_conv(resa4)
		);
		
	logic [31:0]in_screen = {numa4,numa3,numa2,numa1};
			
	always_comb begin
		case(op)
			16'd16: opa = 8'b0010_1011; //suma
			16'd17: opa = 8'b0010_1010; //mul
			16'd18: opa = 8'b0010_0110; //and
			16'd20: opa = 8'b0010_1101; //resta
			16'd21: opa = 8'b0111_1100; //or
			default: opa = 8'b00100000;
		endcase
		
		if (stt == 3'b011)
			in_screen = {resa4,resa3,resa2,resa1};
		else
			in_screen = {numa4,numa3,numa2,numa1};
	end
	
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
			.the_line(in_screen), 
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
			.the_line(opa), 
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
			.the_line({ba1,ba2,ba3,ba4}), 
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
			.the_line({aa1,aa2,aa3,aa4}), 
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
		  
	logic select_bg, select_fg;
		  
	always_comb begin
		  	case(pos_x)
		  		3'd0:
		  				case(pos_y)
		  					2'd0: {select_bg, select_fg} = {generic_bg[0], generic_fg[0]};
		  					2'd1: {select_bg, select_fg} = {generic_bg[4], generic_fg[4]};
		  					2'd2: {select_bg, select_fg} = {generic_bg[8], generic_fg[8]};
		  					2'd3: {select_bg, select_fg} = {generic_bg[12], generic_fg[12]};
		  				endcase
		  		3'd1:
		  				case(pos_y)
		  					2'd0: {select_bg, select_fg} = {generic_bg[1], generic_fg[1]};
		  					2'd1: {select_bg, select_fg} = {generic_bg[5], generic_fg[5]};
		  					2'd2: {select_bg, select_fg} = {generic_bg[9], generic_fg[9]};
		  					2'd3: {select_bg, select_fg} = {generic_bg[13], generic_fg[13]};
		  				endcase
		  	
		  		3'd2:
		  				case(pos_y)
		  					2'd0: {select_bg, select_fg} = {generic_bg[2], generic_fg[2]};
		  					2'd1: {select_bg, select_fg} = {generic_bg[6], generic_fg[6]};
		  					2'd2: {select_bg, select_fg} = {generic_bg[10], generic_fg[10]};
		  					2'd3: {select_bg, select_fg} = {generic_bg[14], generic_fg[14]};
		  				endcase
		  		3'd3:
		  				case(pos_y)
		  					2'd0: {select_bg, select_fg} = {generic_bg[3], generic_fg[3]};
		  					2'd1: {select_bg, select_fg} = {generic_bg[7], generic_fg[7]};
		  					2'd2: {select_bg, select_fg} = {generic_bg[11], generic_fg[11]};
		  					2'd3: {select_bg, select_fg} = {generic_bg[15], generic_fg[15]};
		  				endcase
		  		3'd4:
		  				case(pos_y)
		  					2'd0: {select_bg, select_fg} = {generic_bg[16], generic_fg[16]};//suma
		  					2'd1: {select_bg, select_fg} = {generic_bg[18], generic_fg[18]};//mult
		  					2'd2: {select_bg, select_fg} = {generic_bg[20], generic_fg[20]};//and
		  					2'd3: {select_bg, select_fg} = {generic_bg[22], generic_fg[22]};//EXE
		  				endcase
		  		3'd5:
		  				case(pos_y)
		  					2'd0: {select_bg, select_fg} = {generic_bg[17], generic_fg[17]};//resta
		  					2'd1: {select_bg, select_fg} = {generic_bg[19], generic_fg[19]};//or
		  					2'd2: {select_bg, select_fg} = {generic_bg[21], generic_fg[21]};//CE
		  					2'd3: {select_bg, select_fg} = {generic_bg[23], generic_fg[23]};//CLR
		  				endcase
		  		default:
		  				{select_bg, select_fg} = {generic_bg[0], generic_fg[0]};
			endcase
		end
	
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
			else if (select_fg)
				VGA_COLOR = COLOR_RED;
			else if (select_bg)
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
	input [8*5 -1:0]no_pading,
	output logic [8*5 -1:0]padding);
	
	always_comb begin
	       if (value[19:16] == 4'd0) begin
	           padding = {8'b0010_0000, no_pading[31:0]};
	           if (value[15:12] == 4'd0) begin
	               padding = {8'b0010_0000,8'b0010_0000, no_pading[23:0]};
	               if (value[11:8] == 4'd0) begin
	                   padding = {8'b0010_0000,8'b0010_0000,8'b0010_0000, no_pading[15:0]};
	                   if (value[7:4] == 4'd0) begin
	                       padding = {8'b0010_0000,8'b0010_0000,8'b0010_0000,8'b0010_0000, no_pading[7:0]};
	                       if (value[3:0] == 4'd0) begin
	                           padding = {8'b0010_0000,8'b0010_0000,8'b0010_0000,8'b0010_0000,8'b0010_0000};
	                       end
	                       else padding = no_pading;
	                   end
	                   else padding = no_pading;
	               end
	               else padding = no_pading;
	           end
	           else padding = no_pading;
	       end
	       else padding = no_pading;
	    end
	endmodule

