module SpeedAndAccelerationTest (CLOCK_50, KEY, moveUp, moveDown, moveLeft, moveRight);

	input CLOCK_50;
	input [3:0] KEY;
	output moveUp, moveDown, moveLeft, moveRight;
	
	wire [4:0] speedXOut;
	wire [4:0] speedYOut;
	wire resetn;
	
	assign resetn = KEY[0];
	
	speedX xDirection(.clock(CLOCK_50), 
							.resetn(resetn),
							.acceleration1(KEY[1]), 
							.acceleration2(KEY[3]), 
							.speedXOut(speedXOut)
							);
					  
					  
	speedY yDirection(.clock(CLOCK_50),
							.resetn(resetn),
							.acceleration(KEY[2]),
							.speedYOut(speedYOut)
							);
	
	changePosition changeXPosition(.clock(CLOCK_50),
											 .resetn(resetn),
											 .speed(speedXOut),
											 .movePositive(moveRight),
											 .moveNegative(moveLeft)
											 );
											 
	changePosition changeYPosition(.clock(CLOCK_50),
											 .resetn(resetn),
											 .speed(speedYOut),
											 .movePositive(moveUp),
											 .moveNegative(moveDown)
											 );
	
endmodule


module speedX (clock, resetn, acceleration1, acceleration2, speedXOut);

	input clock;
	input acceleration1, acceleration2;
	input resetn;
	output reg [2:0] speedXOut;
	
	reg [1:0] accelerationCounter1;
	reg [1:0] accelerationCounter2;
	reg accelerateRight;
	reg accelerateLeft;
	
	
	always @ (posedge clock)
	begin
		if (resetn)
		begin
			accelerateLeft = 1'b0;
			accelerateRight = 1'b0;
			accelerationCounter1 = 2'b0;
			accelerationCounter2 = 2'b0;
		end
		else
		begin
			if (acceleration1 == 1'b1 && acceleration2 == 1'b1)
			begin
				accelerateRight = 1'b0;
				accelerateLeft = 1'b0;
			end
			else if (acceleration1 == 1'b1)
			begin
				accelerateLeft = 1'b0;
				if (accelerationCounter1 == 2'b11)
				begin
					accelerationCounter1 = 2'b00;
					accelerateRight = 1'b1;
				end
				else
				begin
					accelerationCounter1 = accelerationCounter1 + 2'b01;
					accelerateRight = 1'b0;
				end
			end
			if (acceleration2 == 1'b1)
			begin
				accelerateRight = 1'b0;
				if (accelerationCounter2 == 2'b11)
				begin
					accelerationCounter2 = 2'b00;
					accelerateLeft = 1'b1;
				end
				else
				begin
					accelerationCounter2 = accelerationCounter2 + 2'b01;
					accelerateLeft = 1'b0;
				end
			end
		end
	end
	
	always @ (posedge clock)
	begin
		if (resetn)
		begin
			speedXOut = 3'b0;
		end
		else
		begin
			// accelerating to the left
			if (accelerateLeft == 1'b1)
			begin
				// speedX is the lowest positive speed
				if (speedXOut == 3'b011)
				begin
					// makes it stop moving
					speedXOut = 3'b000;
				end
				// speedx is 0
				else if (speedXOut == 3'b000)
				begin
					// makes it start moving to the left
					speedXOut = 3'b111;
				end
				// speedx is highest negative speed
				else if (speedXOut == 3'b101)
				begin
					// maintain speed to prevent overflow
				end
				// speedx is negative
				else if (speedXOut[2] == 1)
				begin
					// speed up in the negative direction
					speedXOut = speedXOut - 3'b001;
				end
				// speedx is positive
				else if (speedXOut[2] == 0)
				begin
					// slow down in the positive direction
					speedXOut = speedXOut + 3'b001;
				end
			end
			// accelerating to the right
			else if (accelerateRight == 1'b1)
			begin
				// speedX is lowest possible negative speed
				if (speedXOut == 3'b111)
				begin
					// speedX becomes 0
					speedXOut = 3'b000;
				end
				// speedX is not moving
				else if (speedXOut == 3'b000)
				begin
					// speedX becomes lowest positive speed
					speedXOut = 3'b011;
				end
				// speedX is highest possible speed
				else if (speedXOut == 3'b001)
				begin
					// maintain speed to prevent overflow
				end
				// speedX is going in the negative direction
				else if (speedXOut[2] == 1)
				begin
					// speedX slows down in negative direction
					speedXOut = speedXOut + 3'b001;
				end
				// speedX is going in the positive direction
				else if (speedXOut[2] == 0)
				begin
					// speedX speeds up in positive direction
					speedXOut = speedXOut - 3'b001;
				end
			end
		end
	end
	
endmodule

module speedY (clock, resetn, acceleration, speedYOut);

	input clock;
	input acceleration;
	input resetn;
	output reg [2:0] speedYOut;
	
	reg [1:0] accelerationCounterUp;
	reg [1:0] accelerationCounterDown;
	reg accelerateUp;
	reg accelerateDown;

	always @ (posedge clock)
	begin
		if (resetn)
		begin
			accelerateDown = 1'b0;
			accelerateUp = 1'b0;
			accelerationCounterUp = 2'b0;
			accelerationCounterDown = 2'b0;
		end
		else
		begin
			if (acceleration == 1'b1)
			begin
				accelerateDown = 1'b0;
				if (accelerationCounterUp == 2'b11)
				begin
					accelerationCounterUp = 2'b00;
					accelerateUp = 1'b1;
				end
				else
				begin
					accelerationCounterUp = accelerationCounterUp + 2'b01;
					accelerateUp = 1'b0;
				end
			end
			else
			begin
				accelerateUp = 1'b0;
				if (accelerationCounterDown == 2'b11)
				begin
					accelerationCounterDown = 2'b00;
					accelerateDown = 1'b1;
				end
				else
				begin
					accelerationCounterDown = accelerationCounterDown + 2'b01;
					accelerateDown = 1'b0;
				end
			end
		end
	end
	
	always @ (posedge clock)
	begin
		if (resetn)
		begin
			speedYOut = 3'b000;
		end
		else
			begin
			// accelerating to the right
			if (accelerateUp == 1'b1)
			begin
				// speedY is lowest possible negative speed
				if (speedYOut == 3'b111)
				begin
					// speedY becomes 0
					speedYOut = 3'b000;
				end
				// speedY is not moving
				else if (speedYOut == 3'b000)
				begin
					// speedY becomes lowest positive speed
					speedYOut = 3'b011;
				end
				// speedY is highest possible speed
				else if (speedYOut == 3'b001)
				begin
					// maintain speed to prevent overflow
				end
				// speedY is going in the negative direction
				else if (speedYOut[2] == 1)
				begin
					// speedY slows down in negative direction
					speedYOut = speedYOut + 3'b001;
				end
				// speedY is going in the positive direction
				else if (speedYOut[2] == 0)
				begin
					// speedY speeds up in positive direction
					speedYOut = speedYOut - 3'b001;
				end
			end
			// accelerating downwards
			if (accelerateDown == 1'b1) 
			begin
				// speedY is the lowest positive speed
				if (speedYOut == 3'b011)
				begin
					// makes it stop moving
					speedYOut = 3'b000;
				end
				// speedY is 0
				else if (speedYOut == 3'b000)
				begin
					// makes it start moving down
					speedYOut = 3'b111;
				end
				// speedY is highest negative speed
				else if (speedYOut == 3'b101)
				begin
					// maintain speed to prevent overflow
				end
				// speedY is negative
				else if (speedYOut[2] == 1)
				begin
					// speed up in the negative direction
					speedYOut = speedYOut - 3'b001;
				end
				// speedY is positive
				else if (speedYOut[2] == 0)
				begin
					// slow down in the positive direction
					speedYOut = speedYOut + 3'b001;
				end
			end
		end
	end
endmodule

module changePosition (clock, resetn, speed, movePositive, moveNegative);

	input clock;
	input [2:0] speed;
	input resetn;
	output reg movePositive;
	output reg moveNegative;
	
	reg [1:0] speedCounter;
	
	always @ (posedge clock)
	begin
		if (resetn)
		begin
			speedCounter = 2'b0;
			movePositive = 1'b0;
			moveNegative = 1'b0;
		end
		else
		begin
			if (speed == 2'b00)
			begin
			end
			else
			begin
				if (speedCounter >= speed[1:0])
				begin
					speedCounter[1:0] <= 2'b00;
					if (speed[2] == 1)
						moveNegative <= 1'b1;
					else
						movePositive <= 1'b1;
				end
				else
				begin
					movePositive <= 1'b0;
					moveNegative <= 1'b0;
					speedCounter <= speedCounter + 2'b01;
				end
			end
		end
	end
	
endmodule
