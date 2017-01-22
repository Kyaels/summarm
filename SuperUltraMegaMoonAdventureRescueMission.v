
module SuperUltraMegaMoonAdventureRescueMission (SW, KEY, CLOCK_50, VGA_CLK, VGA_HS,	VGA_VS, VGA_BLANK_N,	VGA_SYNC_N,	VGA_R, VGA_G, VGA_B);

	input [3:0] KEY;
	input CLOCK_50;
	input [3:0] SW;
	output			VGA_CLK;   				//	VGA Clock
	output			VGA_HS;					//	VGA H_SYNC
	output			VGA_VS;					//	VGA V_SYNC
	output			VGA_BLANK_N;				//	VGA BLANK
	output			VGA_SYNC_N;				//	VGA SYNC
	output	[9:0]	VGA_R;   				//	VGA Red[9:0]
	output	[9:0]	VGA_G;	 				//	VGA Green[9:0]
	output	[9:0]	VGA_B;   				//	VGA Blue[9:0]
	
	wire resetn;
	assign resetn = KEY[0];
	
	reg [2:0] colour;
	reg [8:0] x;
	reg [7:0] y;
	wire writeEn;
	
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
		defparam VGA.BACKGROUND_IMAGE = "Background.mif";
		
	wire [25:0] speedXOut;
	wire [25:0] speedYOut;
	wire moveUp;
	wire moveDown;
	wire moveRight;
	wire moveLeft;
	wire [16:0] rocketLocation;
	wire data;
	wire [19:0] pointsScored;
	wire crashed;
	wire edgeValues;
	wire win;
	
	always @ (*)
	begin
		if (crashed == 1'b1)
		begin
		end
		else if (pointsScored != 20'd0)
		begin
		end
	end
	
	speedX xDirection(.clock(CLOCK_50), 
							.acceleration1(~KEY[1]), 
							.acceleration2(~KEY[3]), 
							.speedXOut(speedXOut)
							);
					  
					  
	speedY yDirection(.clock(CLOCK_50), 
							.acceleration(~KEY[2]),
							.speedYOut(speedYOut)
							);
							
	edgeValueFSM edgeFSM(.clock(CLOCK_50),
								.resetn(resetn),
								.rocketLocation(rocketLocation),
								.edgeValue(edgeValues)
								);
	
	changePosition changeXPosition(.clock(CLOCK_50),
											 .speed(speedXOut),
											 .crashed(crashed),
											 .win(win),
											 .movePositive(moveRight),
											 .moveNegative(moveLeft)
											 );
											 
	changePosition changeYPosition(.clock(CLOCK_50),
											 .speed(speedYOut),
											 .crashed(crashed),
											 .win(win),
											 .movePositive(moveUp),
											 .moveNegative(moveDown)
											 );
	
	rocketPositionLogic rocketPosition(.clock(CLOCK_50),
												  .resetn(resetn),
												  .crashed(crashed),
												  .win(win),
												  .moveUp(moveUp),
												  .moveDown(moveDown),
												  .moveLeft(moveLeft),
												  .moveRight(moveRight),
												  .currentAddress(rocketLocation)
												  );
												  
	rocketBehaviour rocket(.rocketLocation(rocketLocation),
								  .resetn(resetn),
								  .speedXOut(speedXOut),
								  .speedYOut(speedYOut),
								  .edgeValues(edgeValues),
								  .pointsScored(pointsScored),
								  .crashed(crashed),
								  .win(win)
								  );
					
	
	wire [4:0] relativeX;
	wire [4:0] relativeY;
	wire [7:0] RelativeY;
	wire [8:0] RelativeX;
	wire [8:0] rocketX;
	wire [16:0] rocketY;
	wire [5:0] rocketMapAddress;
	wire [2:0] rocketColour;
	wire [2:0] backgroundColour;
	wire [2:0] explosionColour;
	wire readRocket;
	reg [16:0] backgroundMapAddress;
	reg [16:0] backgroundCounter;
	reg [16:0] inputToVGA;
	reg queuereset;

	
	always @ (posedge CLOCK_50)
	begin
		if (!resetn)
		begin
			queuereset <= 1'b1;
			backgroundCounter <= 17'd0;
		end
		else if (backgroundCounter == 17'd76799)
		begin
			queuereset <= 1'b0;
			backgroundCounter <= 17'd0;
		end
		else if (queuereset)
		begin
			backgroundCounter <= backgroundCounter + 17'd1;
		end
		else
		begin
			queuereset <= 1'b0;
			backgroundCounter <= 17'd0;
		end
	end
	
	always @ (posedge CLOCK_50)
	begin
		if (queuereset)
		begin
			inputToVGA <= backgroundMapAddress;
		end
		else
		begin
			inputToVGA <= rocketLocation;
		end
	end
	
	always @ (posedge CLOCK_50)
	begin
		if (queuereset)
		begin
			colour = backgroundColour;
		end
		else if (crashed)
		begin
			colour = explosionColour;
		end
		else if (readRocket)
			colour = rocketColour;
		else
			colour = backgroundColour;
	end
	
	assign RelativeY[3:0] = relativeY[3:0];
	assign RelativeY[7:4] = 4'b0;
	assign RelativeX[3:0] = relativeX[3:0];
	assign RelativeX[8:4] = 5'b0;
	
	always @ (posedge CLOCK_50)
	begin
		if (queuereset)
		begin
			x <= rocketX;
			y <= rocketY[7:0];
		end
		else
		begin
			if (relativeX[4] == 1'b1)
			begin
				x <= rocketX - RelativeX;
			end
			else
			begin
				x <= rocketX + RelativeX;
			end
			if (relativeY[4] == 1'b1)
			begin
				y <= rocketY[7:0] - RelativeY;
			end
			else
			begin
				y <= rocketY[7:0] + RelativeY;
			end
		end
	end
	
	always @ (posedge CLOCK_50)
	begin
		if (queuereset)
		begin
			backgroundMapAddress <= backgroundCounter;
		end
		if (relativeX[4] == 1'b1)
		begin
			if (relativeY[4] == 1'b1)
			begin
				backgroundMapAddress <= rocketLocation - (9'd320 * relativeY[3:0]) - relativeX[3:0];
			end
			else
			begin
				backgroundMapAddress <= rocketLocation + (9'd320 * relativeY[3:0]) - relativeX[3:0];
			end
		end
		else
		begin
			if (relativeY[4] == 1'b1)
			begin
				backgroundMapAddress <= rocketLocation - (9'd320 * relativeY[3:0]) + relativeX[3:0];
			end
			else
			begin
				backgroundMapAddress <= rocketLocation + (9'd320 * relativeY[3:0]) + relativeX[3:0];
			end
		end
	end
	
	assign rocketMapAddress = (4'd8 * relativeY[2:0]) + relativeX[2:0];
	
	drawRocketControl DRC(.clock(CLOCK_50),
								 .resetn(resetn),
								 .load(writeEn),
								 .moveUp(moveUp),
								 .moveLeft(moveLeft),
								 .moveRight(moveRight),
								 .moveDown(moveDown),
								 .readRocket(readRocket),
								 .relativeX(relativeX),
								 .relativeY(relativeY)
								 );
	
	division rocketXandY(.denom(9'd320),
								.numer(inputToVGA),
								.quotient(rocketY),
								.remain(rocketX)
								);
								
	ISpitFire explosion(.address(rocketMapAddress),
							  .clock(CLOCK_50),
							  .q(explosionColour)
							  );
								
	rocket rocketColours(.address(rocketMapAddress),
								.clock(CLOCK_50),
								.q(rocketColour)
								);
								
	backgroundMap BGcolours(.address(backgroundMapAddress),
									.clock(CLOCK_50),
									.q(backgroundColour)
									);

endmodule

module speedX (clock, acceleration1, acceleration2, speedXOut);

	input clock;
	input acceleration1, acceleration2;
	output reg [25:0] speedXOut;
	
	reg [25:0] accelerationCounter1;
	reg [25:0] accelerationCounter2;
	reg accelerateRight;
	reg accelerateLeft;
	
	always @ (posedge clock)
	begin
		if (acceleration1 == 1'b1 && acceleration2 == 1'b1)
		begin
			accelerateRight = 1'b0;
			accelerateLeft = 1'b0;
		end
		else if (acceleration1 == 1'b1)
		begin
			accelerateLeft = 1'b0;
			if (accelerationCounter1 == 26'd50000000)
			begin
				accelerationCounter1 = 26'd0;
				accelerateRight = 1'b1;
			end
			else
			begin
				accelerationCounter1 = accelerationCounter1 + 26'd1;
				accelerateRight = 1'b0;
			end
		end
		else if (acceleration2 == 1'b1)
		begin
			accelerateRight = 1'b0;
			if (accelerationCounter2 == 26'd50000000)
			begin
				accelerationCounter2 = 26'd0;
				accelerateLeft = 1'b1;
			end
			else
			begin
				accelerationCounter2 = accelerationCounter2 + 26'd1;
				accelerateLeft = 1'b0;
			end
		end
	end
	
	always @ (posedge clock)
	begin
		// accelerating to the right
		if (accelerateRight == 1'b1)
		begin
			// speedY is lowest possible negative speed
			if (speedXOut == 26'b11011111010111100001000000)
			begin
				// speedY becomes 0
				speedXOut = 26'b0;
			end
			// speedY is not moving
			else if (speedXOut == 26'b0)
			begin
				// speedY becomes lowest positive speed
				speedXOut = 26'b01011111010111100001000000;
			end
			// speedY is highest possible speed
			else if (speedXOut == 26'b00010011000100101101000000)
			begin
				// maintain speed to prevent overflow
			end
			// speedY is going in the negative direction
			else if (speedXOut[25] == 1'b1)
			begin
				// speedY slows down in negative direction
				speedXOut = speedXOut + 26'd5000000;
			end
			// speedY is going in the positive direction
			else if (speedXOut[25] == 1'b0)
			begin
				// speedY speeds up in positive direction
				speedXOut = speedXOut - 26'd5000000;
			end
		end
		// accelerating downwards
		if (accelerateLeft == 1'b1) 
		begin
			// speedY is the lowest positive speed
			if (speedXOut == 26'b01011111010111100001000000)
			begin
				// makes it stop moving
				speedXOut = 26'd0;
			end
			// speedY is 0
			else if (speedXOut == 26'b0)
			begin
				// makes it start moving down
				speedXOut = 26'b11011111010111100001000000;
			end
			// speedY is highest negative speed
			else if (speedXOut == 26'b10010011000100101101000000)
			begin
				// maintain speed to prevent overflow
			end
			// speedY is negative
			else if (speedXOut[25] == 1'b1)
			begin
				// speed up in the negative direction
				speedXOut = speedXOut - 26'd5000000;
			end
			// speedY is positive
			else if (speedXOut[25] == 1'b0)
			begin
				// slow down in the positive direction
				speedXOut = speedXOut + 26'd5000000;
			end
		end
	end
	
	
endmodule

module speedY (clock, acceleration, speedYOut);

	input clock;
	input acceleration;
	output reg [25:0] speedYOut;
	
	reg [25:0] accelerationCounterUp;
	reg [25:0] accelerationCounterDown;
	reg accelerateUp;
	reg accelerateDown;

	always @ (posedge clock)
	begin
		if (acceleration == 1'b1)
		begin
			accelerateDown = 1'b0;
			if (accelerationCounterUp == 26'd50000000)
			begin
				accelerationCounterUp = 26'd0;
				accelerateUp = 1'b1;
			end
			else
			begin
				accelerationCounterUp = accelerationCounterUp + 26'd1;
				accelerateUp = 1'b0;
			end
		end
		else
		begin
			accelerateUp = 1'b0;
			if (accelerationCounterDown == 26'd50000000)
			begin
				accelerationCounterDown = 26'd0;
				accelerateDown = 1'b1;
			end
			else
			begin
				accelerationCounterDown = accelerationCounterDown + 26'd1;
				accelerateDown = 1'b0;
			end
		end
	end
	
	always @ (posedge clock)
	begin
		// accelerating to the right
		if (accelerateUp == 1'b1)
		begin
			// speedY is lowest possible negative speed
			if (speedYOut == 26'b11011111010111100001000000)
			begin
				// speedY becomes 0
				speedYOut = 26'b0;
			end
			// speedY is not moving
			else if (speedYOut == 26'b0)
			begin
				// speedY becomes lowest positive speed
				speedYOut = 26'b01011111010111100001000000;
			end
			// speedY is highest possible speed
			else if (speedYOut == 26'b00010011000100101101000000)
			begin
				// maintain speed to prevent overflow
			end
			// speedY is going in the negative direction
			else if (speedYOut[25] == 1'b1)
			begin
				// speedY slows down in negative direction
				speedYOut = speedYOut + 26'd5000000;
			end
			// speedY is going in the positive direction
			else if (speedYOut[25] == 1'b0)
			begin
				// speedY speeds up in positive direction
				speedYOut = speedYOut - 26'd5000000;
			end
		end
		// accelerating downwards
		if (accelerateDown == 1'b1) 
		begin
			// speedY is the lowest positive speed
			if (speedYOut == 26'b01011111010111100001000000)
			begin
				// makes it stop moving
				speedYOut = 26'd0;
			end
			// speedY is 0
			else if (speedYOut == 26'b0)
			begin
				// makes it start moving down
				speedYOut = 26'b11011111010111100001000000;
			end
			// speedY is highest negative speed
			else if (speedYOut == 26'b10010011000100101101000000)
			begin
				// maintain speed to prevent overflow
			end
			// speedY is negative
			else if (speedYOut[25] == 1'b1)
			begin
				// speed up in the negative direction
				speedYOut = speedYOut - 26'd5000000;
			end
			// speedY is positive
			else if (speedYOut[25] == 1'b0)
			begin
				// slow down in the positive direction
				speedYOut = speedYOut + 26'd5000000;
			end
		end
	end
endmodule

module changePosition (clock, speed, crashed, win, movePositive, moveNegative);

	input clock;
	input [25:0] speed;
	input crashed;
	input win;
	output reg movePositive;
	output reg moveNegative;
	
	reg [24:0] speedCounter;
	
	always @ (posedge clock)
	begin
		if (crashed || win)
		begin
			moveNegative = 1'b0;
			movePositive = 1'b0;
		end
		else
		begin
			if (speed == 26'b0)
			begin
				moveNegative = 1'b0;
				movePositive = 1'b0;
			end
			else if (speedCounter >= speed[24:0])	
			begin
				speedCounter = 25'b0;
				if (speed[25] == 1)
					moveNegative = 1'b1;
				else
					movePositive = 1'b1;
			end
			else
			begin
				movePositive <= 1'b0;
				moveNegative <= 1'b0;
				speedCounter = speedCounter + 25'd1;
			end
		end
	end
	
endmodule

module rocketPositionLogic (clock, resetn, crashed, win, moveUp, moveDown, moveLeft, moveRight, currentAddress);

	input clock;
	input crashed;
	input win;
	input moveUp;
	input moveDown;
	input moveLeft;
	input moveRight;
	input resetn;
	output [16:0] currentAddress;
	
	reg [16:0] rocketLocation;
	
	assign currentAddress = rocketLocation;
	
	always @ (posedge clock)
	begin
		if (!resetn)
		begin
			rocketLocation = 17'd5148;
		end
		else if (crashed || win)
		begin
		end
		else
		begin
			if (moveUp)
			begin
				rocketLocation = rocketLocation - 17'd320;
			end
			else if (moveDown)
			begin
				rocketLocation = rocketLocation + 17'd320;
			end
			if (moveLeft)
			begin
				rocketLocation = rocketLocation - 17'd1;
			end
			else if (moveRight)
			begin
				rocketLocation = rocketLocation + 17'd1;
			end
		end
	end

endmodule

module rocketBehaviour (rocketLocation, resetn, speedXOut, speedYOut, edgeValues, pointsScored, crashed, win);

	input [16:0] rocketLocation;
	input resetn;
	input [25:0] speedXOut;
	input [25:0] speedYOut;
	input edgeValues;
	output reg [19:0] pointsScored;
	output reg crashed;
	output reg win;
	
	wire [24:0] absoluteValueX;
	wire [24:0] absoluteValueY;
	
	assign absoluteValueX = speedXOut[24:0];
	assign absoluteValueY = speedYOut[24:0];
	
	always @ (*)
	begin
		if (!resetn)
		begin
			pointsScored = 20'd0;
			crashed = 1'b0;
		end
		if (edgeValues == 1'b1)
		begin
			pointsScored = 20'd0;
			crashed = 1'b1;
		end
		else if (rocketLocation == 17'd37472 || rocketLocation == 17'd37473)
		begin
			if (crashed)
			begin
				crashed = 1'b1;
			end
			else if (absoluteValueX == 25'd0 && (absoluteValueY > 25'd20000000 || absoluteValueX == 25'd0))
			begin
				pointsScored = 20'd500000;
				crashed = 1'b0;
			end
			else
			begin
				pointsScored = 20'd0;
				crashed = 1'b1;
			end
		end
		else if (rocketLocation == 17'd41984 || rocketLocation == 17'd41985)
		begin
			if (crashed)
			begin
				crashed = 1'b1;
			end
			else if (absoluteValueX == 25'd0 && (absoluteValueY >= 25'd20000000 || absoluteValueX == 25'd0))
			begin
				pointsScored = 20'd1000000;
				crashed = 1'b0;
			end
			else
			begin
				pointsScored = 20'd0;
				crashed = 1'b1;
			end
		end
		else if (rocketLocation == 17'd52957 || rocketLocation == 17'd52958)
		begin
			if (crashed)
			begin
				crashed = 1'b1;
			end
			else if (absoluteValueX == 25'd0 && (absoluteValueY >= 25'd20000000 || absoluteValueX == 25'd0))
			begin
				pointsScored = 20'd15000000;
				crashed = 1'b0;
			end
			else
			begin
				pointsScored = 20'd0;
				crashed = 1'b1;
			end
		end
		else if (rocketLocation == 17'd45989 || rocketLocation == 17'd45990)
		begin
			if (crashed)
			begin
				crashed = 1'b1;
			end
			else if (absoluteValueX == 25'd0 && (absoluteValueY >= 25'd20000000 || absoluteValueX == 25'd0))
			begin
				pointsScored = 20'd1000000;
				crashed = 1'b0;
			end
			else
			begin
				pointsScored = 20'd0;
				crashed = 1'b1;
			end
		end
		else if (rocketLocation == 17'd55598 || rocketLocation == 17'd55599)
		begin
			if (crashed)
			begin
				crashed = 1'b1;
			end
			else if (absoluteValueX == 25'd0 && (absoluteValueY >= 25'd20000000 || absoluteValueX == 25'd0)) 
			begin
				pointsScored = 20'd2500000;
				crashed = 1'b0;
			end
			else
			begin
				pointsScored = 20'd0;
				crashed = 1'b1;
			end
		end
		else
		begin
			pointsScored = 20'd0;
			crashed = 1'b0;
		end
	end
	
	always @ (*)
	begin
		if (pointsScored != 20'd0)
		begin
			win <= 1'b1;
		end
		else
		begin
			win <= 1'b0; 
		end
	end

endmodule

module edgeValueFSM (clock, resetn, rocketLocation, edgeValue);

	input clock;
	input resetn;
	input [16:0] rocketLocation;
	output edgeValue;
	
	reg [16:0] address;
	wire ld_edgeValue;
	wire ld_readAddress;
	wire [5:0] relativePositionValue;
	
	always @ (posedge clock)
	begin
		address = rocketLocation + relativePositionValue;
	end
	
	edgeValueControl EVC(.clock(clock),
								.resetn(resetn),
								.ld_edgeValue(ld_edgeValue),
								.ld_read_Address(ld_readAddress),
								.relativePositionValue(relativePositionValue)
								);
	
	TerrainMap terrain(.address(address),
							 .clock(clock),
							 .q(edgeValue)
							 );
endmodule

module drawRocket(clock, resetn, crashed, moveDown, moveLeft, moveUp, moveRight, rocketLocation, load, colour, x, y);

	input clock;
	input resetn;
	input crashed;
	input [16:0] rocketLocation;
	input moveDown, moveLeft, moveUp, moveRight;
	output load;
	output reg [2:0] colour;
	output reg [8:0] x;
	output reg [7:0] y;
	
	wire [4:0] relativeX;
	wire [4:0] relativeY;
	wire [7:0] RelativeY;
	wire [8:0] RelativeX;
	wire [8:0] rocketX;
	wire [16:0] rocketY;
	wire [5:0] rocketMapAddress;
	wire [2:0] rocketColour;
	wire [2:0] backgroundColour;
	wire [2:0] explosionColour;
	wire readRocket;
	reg [16:0] backgroundMapAddress;
	reg [16:0] backgroundCounter;
	reg [16:0] inputToVGA;
	reg queuereset;

	
	always @ (posedge clock)
	begin
		if (!resetn)
		begin
			queuereset <= 1'b1;
			backgroundCounter <= 17'd0;
		end
		else if (backgroundCounter == 17'd76799)
		begin
			queuereset <= 1'b0;
			backgroundCounter <= 17'd0;
		end
		else if (queuereset)
		begin
			backgroundCounter <= backgroundCounter + 17'd1;
		end
		else
		begin
			queuereset <= 1'b0;
			backgroundCounter <= 17'd0;
		end
	end
	
	always @ (posedge clock)
	begin
		if (queuereset)
		begin
			inputToVGA <= backgroundMapAddress;
		end
		else
		begin
			inputToVGA <= rocketLocation;
		end
	end
	
	always @ (posedge clock)
	begin
		if (queuereset)
		begin
			colour = backgroundColour;
		end
		else if (crashed)
		begin
			colour = explosionColour;
		end
		else if (readRocket)
			colour = rocketColour;
		else
			colour = backgroundColour;
	end
	
	assign RelativeY[3:0] = relativeY[3:0];
	assign RelativeY[7:4] = 4'b0;
	assign RelativeX[3:0] = relativeX[3:0];
	assign RelativeX[8:4] = 5'b0;
	
	always @ (posedge clock)
	begin
		if (queuereset)
		begin
			x <= rocketX;
			y <= rocketY[7:0];
		end
		else
		begin
			if (relativeX[4] == 1'b1)
			begin
				x <= rocketX - RelativeX;
			end
			else
			begin
				x <= rocketX + RelativeX;
			end
			if (relativeY[4] == 1'b1)
			begin
				y <= rocketY[7:0] - RelativeY;
			end
			else
			begin
				y <= rocketY[7:0] + RelativeY;
			end
		end
	end
	
	always @ (posedge clock)
	begin
		if (queuereset)
		begin
			backgroundMapAddress <= backgroundCounter;
		end
		if (relativeX[4] == 1'b1)
		begin
			if (relativeY[4] == 1'b1)
			begin
				backgroundMapAddress <= rocketLocation - (9'd320 * relativeY[3:0]) - relativeX[3:0];
			end
			else
			begin
				backgroundMapAddress <= rocketLocation + (9'd320 * relativeY[3:0]) - relativeX[3:0];
			end
		end
		else
		begin
			if (relativeY[4] == 1'b1)
			begin
				backgroundMapAddress <= rocketLocation - (9'd320 * relativeY[3:0]) + relativeX[3:0];
			end
			else
			begin
				backgroundMapAddress <= rocketLocation + (9'd320 * relativeY[3:0]) + relativeX[3:0];
			end
		end
	end
	
	assign rocketMapAddress = (4'd8 * relativeY[2:0]) + relativeX[2:0];
	
	drawRocketControl DRC(.clock(clock),
								 .resetn(resetn),
								 .load(load),
								 .moveUp(moveUp),
								 .moveLeft(moveLeft),
								 .moveRight(moveRight),
								 .moveDown(moveDown),
								 .readRocket(readRocket),
								 .relativeX(relativeX),
								 .relativeY(relativeY)
								 );
	
	division rocketXandY(.denom(9'd320),
								.numer(inputToVGA),
								.quotient(rocketY),
								.remain(rocketX)
								);
								
	ISpitFire explosion(.address(rocketMapAddress),
							  .clock(clock),
							  .q(explosionColour)
							  );
								
	rocket rocketColours(.address(rocketMapAddress),
								.clock(clock),
								.q(rocketColour)
								);
								
	backgroundMap BGcolours(.address(backgroundMapAddress),
									.clock(clock),
									.q(backgroundColour)
									);
	
endmodule

