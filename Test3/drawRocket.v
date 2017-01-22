
module drawRocket(clock, resetn, moveDown, moveLeft, moveUp, moveRight, rocketLocation, load, colour, x, y);

	input clock;
	input resetn;
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
	wire readRocket;
	reg [16:0] backgroundMapAddress;
	
	always @ (posedge clock)
	begin
		if (readRocket)
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
	
	always @ (posedge clock)
	begin
		if (relativeX[4] == 1'b1)
		begin
			if (relativeY[4] == 1'b1)
			begin
				backgroundMapAddress = rocketLocation - (9'd320 * relativeY[3:0]) - relativeX[3:0];
			end
			else
			begin
				backgroundMapAddress = rocketLocation + (9'd320 * relativeY[3:0]) - relativeX[3:0];
			end
		end
		else
		begin
			if (relativeY[4] == 1'b1)
			begin
				backgroundMapAddress = rocketLocation - (9'd320 * relativeY[3:0]) + relativeX[3:0];
			end
			else
			begin
				backgroundMapAddress = rocketLocation + (9'd320 * relativeY[3:0]) + relativeX[3:0];
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
								.numer(rocketLocation),
								.quotient(rocketY),
								.remain(rocketX)
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
