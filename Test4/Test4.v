module Test4 (KEY, CLOCK_50, VGA_CLK, VGA_HS,	VGA_VS, VGA_BLANK_N,	VGA_SYNC_N,	VGA_R, VGA_G, VGA_B);

	input [3:0] KEY;
	input CLOCK_50;
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	wire start;
	wire go;
	
	assign start = ~KEY[1] | ~KEY[2] | ~KEY[3];
	assign resetn = KEY[0];
	assign go = KEY[1];
	
	wire [2:0] colour;
	wire [8:0] x;
	wire [7:0] y;
	reg writeEn;
	
	assign y = Y[7:0];
	
	vga_adapter VGA(
			.resetn(resetn),
			.clock(CLOCK_50),
			.colour(colour),
			.x(x),
			.y(y),
			.plot(writeEn),
			/* Signals for the DAC to drive the monitor. */
			.VGA_R(VGA_R),
			.VGA_G(VGA_G),
			.VGA_B(VGA_B),
			.VGA_HS(VGA_HS),
			.VGA_VS(VGA_VS),
			.VGA_BLANK(VGA_BLANK_N),
			.VGA_SYNC(VGA_SYNC_N),
			.VGA_CLK(VGA_CLK));
		defparam VGA.RESOLUTION = "320x240";
		defparam VGA.MONOCHROME = "FALSE";
		defparam VGA.BITS_PER_COLOUR_CHANNEL = 1;
		defparam VGA.BACKGROUND_IMAGE = "Title.mif";

		

	reg [16:0] counter;
	wire [16:0] Y;
	
	always @ (posedge CLOCK_50)
	begin
		if (go)
		begin
			counter = 17'd1;
			writeEn = 1'b1;
		end
		else if (counter == 17'd76799)
		begin
			counter = 17'd0;
			writeEn = 1'b0;
		end
		else if (counter != 17'd0)
		begin
			counter = counter + 17'd1;
			writeEn = 1'b1;
		end
	end
	
	adsfk awegaewg(.address(counter),
			 .clock(CLOCK_50),
			 .q(colour)
			 );
			 
	division awefgawegeaw(.denom(9'd320),
				.numer(counter),
				.quotient(Y),
				.remain(x)
				);
	
endmodule

module drawNewBackground(clock, go, resetn, colour, x, y, writeEn);

	input clock;
	input go;
	input resetn;
	output [2:0] colour;
	output [8:0] x;
	output [7:0] y;
	output reg writeEn;
	
	reg [16:0] counter;
	wire [16:0] Y;
	
	assign y = Y[7:0];
	
	always @ (posedge clock)
	begin
		if (!resetn)
		begin
			counter = 17'd0;
			writeEn = 1'b0;
		end
		else if (go)
		begin
			counter = 17'd1;
			writeEn = 1'b1;
		end
		else if (counter == 17'd76799)
		begin
			counter = 17'd0;
			writeEn = 1'b0;
		end
		else if (counter != 17'd0)
		begin
			counter = counter + 17'd1;
			writeEn = 1'b1;
		end
	end
	
	adsfk awegaewg(.address(counter),
			 .clock(clock),
			 .q(colour)
			 );
			 
//	division awefgawegeaw(.denom(9'd320),
//				.numer(counter),
//				.quotient(Y),
//				.remain(x)
//				);
	
endmodule
