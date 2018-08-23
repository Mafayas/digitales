module lab_9(
	input CLK100MHZ,
	input [15:0]SW,
	input CPU_RESETN,
	input UART_TXD_IN,

	output [15:0]LED,
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);
	
	logic CLK82MHZ;
	logic rst = 0;
	logic hw_rst = ~CPU_RESETN;
	logic [7:0]rx_data;
	logic rx_ready;
	logic [17:0]addra;
	logic [17:0]addrb;
	logic [23:0]pixw;
	logic [23:0]pixr, pix1, pix2;
	logic ena;
	logic [23:0]pix_scrambler;
	logic [23:0]pix_gray;
	logic [23:0]pix_dither;
	logic [9:0]hc,vc;
	
	assign LED = addra[17:2];
	
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
	
	blk_mem_gen_0 mem(
		.clka(CLK100MHZ),
		.ena(1'b1),
		.wea(ena),
		.addra(addra),
		.dina(pixw),
		.clkb(CLK82MHZ),
		.enb(1'b1),
		.addrb(addrb),
		.doutb(pixr)
		);
	
	uart_basic UAR(
		.clk(CLK100MHZ),
		.reset(1'b0),
		.rx(UART_TXD_IN),
		.rx_data(rx_data),
		.rx_ready(rx_ready)
		);
		
	UART_RX_CTRL URX(
		.rx_ready(rx_ready),
		.rx_data(rx_data),
		.reset(hw_rst),
		.clk(CLK100MHZ),
		.adress(addra),
		.pix(pixw),
		.wenable(ena)
		);
		
	dithering D(
		.pix_in(pixr),
		.hc(hc),
		.vc(vc),
		.pix_out(pix_dither)
		);
		
	always_comb begin
			if (SW[2])
				pix1 = pix_dither;
			else
				pix1 = pixr;
		end
		
	grayscale G(
		.pix_in(pix1),
		.pix_out(pix_gray)
		);
		
	always_comb begin
		if (SW[1])
			pix2 = pix_gray;
		else
			pix2 = pix1;
	end
		
	color_scrambler CS(
		.pix_in(pix2),
		.switch(SW[15:10]),
		.pix_out(pix_scrambler)
		);
		
	/************************* VGA ********************/


	calculator_screen(
		.clk_vga(CLK82MHZ),
		.pixel(pix_scrambler),
		
		.hc_visible(hc),
		.vc_visible(vc),
		.adress(addrb),
		.VGA_HS(VGA_HS),
		.VGA_VS(VGA_VS),
		.VGA_R(VGA_R),
		.VGA_G(VGA_G),
		.VGA_B(VGA_B));
			

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
	input [23:0] pixel,
	output logic [9:0]hc_visible,
	output logic [9:0]vc_visible,
	output logic [17:0]adress,
	output VGA_HS,
	output VGA_VS,
	output [3:0] VGA_R,
	output [3:0] VGA_G,
	output [3:0] VGA_B
	);

	
	// MODIFICAR ESTO PARA HACER LLAMADO POR NOMBRE DE PUERTO, NO POR ORDEN!!!!!
	driver_vga_1024x768 m_driver(
		.clk_vga(clk_vga),
		.hs(VGA_HS),
		.vs(VGA_VS),
		.hc_visible(hc_visible),
		.vc_visible(vc_visible)
		);
	/*************************** VGA DISPLAY ************************/
		
	always_comb begin
	//	if((hc_visible > 0) && (hc_visible <= 512) && (vc_visible > 0) && (vc_visible <= 384)) begin
			adress = (((vc_visible - 'd1) * 'd512) + (hc_visible - 'd1))+ 'd2; //Probar esto
	//	end
	//	else
	//		adress = 'd0;
	end
		
		
	logic [11:0]pix12;
	logic [11:0]VGA_COLOR;
	
	assign pix12 = {pixel[23:20], pixel[15:12], pixel[7:4]};
	
	always@(*)
		if((hc_visible != 0) && (vc_visible != 0))
		begin
			if((hc_visible > 0) && (hc_visible <= 512) && (vc_visible > 0) && (vc_visible <= 384)) begin
				VGA_COLOR = pix12;
			end
			else
				VGA_COLOR = 12'h000;
		end
		else
			VGA_COLOR = 12'h000;//esto es necesario para no poner en riesgo la pantalla.

	assign {VGA_R, VGA_G, VGA_B} = VGA_COLOR;
endmodule


