
module rocketPositionLogic (clock, resetn, moveUp, moveDown, moveLeft, moveRight, check, address, outQ); // more stuff, maybe outputs?

	input clock;
	input moveUp;
	input moveDown;
	input moveLeft;
	input moveRight;
	input check;
	input resetn;
	output [1:0] outQ;
	output [16:0] address;
	
	reg [16:0] rocketLocation;
	wire writeEnable;
	wire q;
	wire [12:0] relativePositionValue;
	
	
	always @ (posedge clock)
	begin
		if (resetn)
		begin
			rocketLocation = 17'd5148;
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
	
	control c1(.clock(clock),
				  .check(check),
				  .resetn(resetn),
				  .moveUp(moveUp),
				  .moveDown(moveDown),
				  .moveLeft(moveLeft),
				  .moveRight(moveRight),
				  .writeEnable(writeEnable),
				  .q(q),
				  .relativePositionValue(relativePositionValue)
				  );
	
	datapath d1(.resetn(resetn),
					.clock(clock), 
					.writeEnable(writeEnable), 
					.q(q), 
					.relativePositionValue(relativePositionValue), 
					.currentAddress(rocketLocation), 
					.outQ(outQ),
					.blahAddress(address)
					);
	
	
endmodule

module control (clock, check, resetn, moveUp, moveDown, moveLeft, moveRight, writeEnable, q, relativePositionValue);

	input clock;
	input resetn;
	input moveUp;
	input moveDown;
	input moveLeft;
	input moveRight;
	input check;
	output reg writeEnable;
	output reg q;
	output reg [12:0] relativePositionValue;
	reg queueUp;
	reg queueDown;
	reg queueLeft;
	reg queueRight;

	
	reg [7:0] currentState, nextState;
	
	localparam WAIT_FOR_SIGNAL = 7'd0,
				  MOVE_UP = 7'd1,
				  MOVE_LEFT = 7'd2,
				  MOVE_RIGHT = 7'd3,
				  MOVE_DOWN = 7'd4,
				  UP_P1 = 7'd5,
				  UP_P2 = 7'd6,
				  UP_P3 = 7'd7,
				  UP_P4 = 7'd8,
				  UP_P5 = 7'd9,
				  UP_P6 = 7'd10,
				  UP_P7 = 7'd11,
				  UP_P8 = 7'd12,
				  UP_P9 = 7'd13,
				  UP_P10 = 7'd14,
				  UP_P11 = 7'd15,
				  UP_P12 = 7'd16,
				  UP_P13 = 7'd17,
				  UP_P14 = 7'd18,
				  UP_P15 = 7'd19,
				  UP_P16 = 7'd20,
				  LEFT_P1 = 7'd21,
				  LEFT_P2 = 7'd22,
				  LEFT_P3 = 7'd23,
				  LEFT_P4 = 7'd24,
				  LEFT_P5 = 7'd25,
				  LEFT_P6 = 7'd26,
				  LEFT_P7 = 7'd27,
				  LEFT_P8 = 7'd28,
				  LEFT_P9 = 7'd29,
				  LEFT_P10 = 7'd30,
				  LEFT_P11 = 7'd31,
				  LEFT_P12 = 7'd32,
				  LEFT_P13 = 7'd33,
				  LEFT_P14 = 7'd34,
				  LEFT_P15 = 7'd35,
				  LEFT_P16 = 7'd36,
				  DOWN_P1 = 7'd37,
				  DOWN_P2 = 7'd38,
				  DOWN_P3 = 7'd39,
				  DOWN_P4 = 7'd40,
				  DOWN_P5 = 7'd41,
				  DOWN_P6 = 7'd42,
				  DOWN_P7 = 7'd43,
				  DOWN_P8 = 7'd44,
				  DOWN_P9 = 7'd45,
				  DOWN_P10 = 7'd46,
				  DOWN_P11 = 7'd47,
				  DOWN_P12 = 7'd48,
				  DOWN_P13 = 7'd49,
				  DOWN_P14 = 7'd50,
				  DOWN_P15 = 7'd51,
				  DOWN_P16 = 7'd52,
				  RIGHT_P1 = 7'd53,
				  RIGHT_P2 = 7'd54,
				  RIGHT_P3 = 7'd55,
				  RIGHT_P4 = 7'd56,
				  RIGHT_P5 = 7'd57,
				  RIGHT_P6 = 7'd58,
				  RIGHT_P7 = 7'd59,
				  RIGHT_P8 = 7'd60,
				  RIGHT_P9 = 7'd61,
				  RIGHT_P10 = 7'd62,
				  RIGHT_P11 = 7'd63,
				  RIGHT_P12 = 7'd64,
				  RIGHT_P13 = 7'd65,
				  RIGHT_P14 = 7'd66,
				  RIGHT_P15 = 7'd67,
				  RIGHT_P16 = 7'd68,
				  CHECK_1 = 7'd69,
				  CHECK_2 = 7'd70,
				  CHECK_3 = 7'd71,
				  CHECK_4 = 7'd72,
				  CHECK_5 = 7'd73,
				  CHECK_6 = 7'd76,
				  CHECK_7 = 7'd77,
				  CHECK_8 = 7'd78,
				  DOWN_PAUSE = 7'd79,
				  DOWN_END = 7'd80;
				  
	always @ (posedge clock)
	begin
		case (currentState)
			WAIT_FOR_SIGNAL:
			begin
				if (queueDown)
				begin
					nextState <= MOVE_DOWN;
				end
				else if (queueRight)
				begin
					nextState <= MOVE_RIGHT;
				end
				else if (queueLeft)
				begin
					nextState <= MOVE_LEFT;
				end
				else if (queueUp)
				begin
					nextState <= MOVE_UP;
				end
				else if (check)
				begin
					nextState <= CHECK_1;
				end
				else
				begin
					nextState <= WAIT_FOR_SIGNAL;
				end
			end
			MOVE_DOWN:
			begin
				nextState = DOWN_P1;
			end
			MOVE_UP:
			begin
				nextState = UP_P1;
			end
			MOVE_RIGHT:
			begin
				nextState = RIGHT_P1;
			end
			MOVE_LEFT:
			begin
				nextState = LEFT_P1;
			end
			DOWN_P1:
			begin
				nextState = DOWN_P2;
			end
			DOWN_P2:
			begin
				nextState = DOWN_P3;
			end
			DOWN_P3:
			begin
				nextState = DOWN_P4;
			end
			DOWN_P4:
			begin
				nextState = DOWN_P5;
			end
			DOWN_P5:
			begin
				nextState = DOWN_P6;
			end
			DOWN_P6:
			begin
				nextState = DOWN_P7;
			end
			DOWN_P7:
			begin
				nextState = DOWN_P8;
			end
			DOWN_P8:
			begin
				nextState = DOWN_PAUSE;
			end
			DOWN_PAUSE:
			begin
				nextState = DOWN_P9;
			end
			DOWN_P9:
			begin
				nextState = DOWN_P10;
			end
			DOWN_P10:
			begin
				nextState = DOWN_P11;
			end
			DOWN_P11:
			begin
				nextState = DOWN_P12;
			end
			DOWN_P12:
			begin
				nextState = DOWN_P13;
			end
			DOWN_P13:
			begin
				nextState = DOWN_P14;
			end
			DOWN_P14:
			begin
				nextState = DOWN_P15;
			end
			DOWN_P15:
			begin
				nextState = DOWN_P16;
			end
			DOWN_P16:
			begin
				nextState = DOWN_END;
			end
			DOWN_END:
			begin
				nextState = WAIT_FOR_SIGNAL;
			end
			UP_P1:
			begin
				nextState = UP_P2;
			end
			UP_P2:
			begin
				nextState = UP_P3;
			end
			UP_P3:
			begin
				nextState = UP_P4;
			end
			UP_P4:
			begin
				nextState = UP_P5;
			end
			UP_P5:
			begin
				nextState = UP_P6;
			end
			UP_P6:
			begin
				nextState = UP_P7;
			end
			UP_P7:
			begin
				nextState = UP_P8;
			end
			UP_P8:
			begin
				nextState = UP_P9;
			end
			UP_P9:
			begin
				nextState = UP_P10;
			end
			UP_P10:
			begin
				nextState = UP_P11;
			end
			UP_P11:
			begin
				nextState = UP_P12;
			end
			UP_P12:
			begin
				nextState = UP_P13;
			end
			UP_P13:
			begin
				nextState = UP_P14;
			end
			UP_P14:
			begin
				nextState = UP_P15;
			end
			UP_P15:
			begin
				nextState = UP_P16;
			end
			UP_P16:
			begin
				nextState = WAIT_FOR_SIGNAL;
			end
			RIGHT_P1:
			begin
				nextState = RIGHT_P2;
			end
			RIGHT_P2:
			begin
				nextState = RIGHT_P3;
			end
			RIGHT_P3:
			begin
				nextState = RIGHT_P4;
			end
			RIGHT_P4:
			begin
				nextState = RIGHT_P5;
			end
			RIGHT_P5:
			begin
				nextState = RIGHT_P6;
			end
			RIGHT_P6:
			begin
				nextState = RIGHT_P7;
			end
			RIGHT_P7:
			begin
				nextState = RIGHT_P8;
			end
			RIGHT_P8:
			begin
				nextState = RIGHT_P9;
			end
			RIGHT_P9:
			begin
				nextState = RIGHT_P10;
			end
			RIGHT_P10:
			begin
				nextState = RIGHT_P11;
			end
			RIGHT_P11:
			begin
				nextState = RIGHT_P12;
			end
			RIGHT_P12:
			begin
				nextState = RIGHT_P13;
			end
			RIGHT_P13:
			begin
				nextState = RIGHT_P14;
			end
			RIGHT_P14:
			begin
				nextState = RIGHT_P15;
			end
			RIGHT_P15:
			begin
				nextState = RIGHT_P16;
			end
			RIGHT_P16:
			begin
				nextState = WAIT_FOR_SIGNAL;
			end
			LEFT_P1:
			begin
				nextState = LEFT_P2;
			end
			LEFT_P2:
			begin
				nextState = LEFT_P3;
			end
			LEFT_P3:
			begin
				nextState = LEFT_P4;
			end
			LEFT_P4:
			begin
				nextState = LEFT_P5;
			end
			LEFT_P5:
			begin
				nextState = LEFT_P6;
			end
			LEFT_P6:
			begin
				nextState = LEFT_P7;
			end
			LEFT_P7:
			begin
				nextState = LEFT_P8;
			end
			LEFT_P8:
			begin
				nextState = LEFT_P9;
			end
			LEFT_P9:
			begin
				nextState = LEFT_P10;
			end
			LEFT_P10:
			begin
				nextState = LEFT_P11;
			end
			LEFT_P11:
			begin
				nextState = LEFT_P12;
			end
			LEFT_P12:
			begin
				nextState = LEFT_P13;
			end
			LEFT_P13:
			begin
				nextState = LEFT_P14;
			end
			LEFT_P14:
			begin
				nextState = LEFT_P15;
			end
			LEFT_P15:
			begin
				nextState = LEFT_P16;
			end
			LEFT_P16:
			begin
				nextState = WAIT_FOR_SIGNAL;
			end
			CHECK_1:
			begin
				nextState = CHECK_2;
			end
			CHECK_2:
			begin
				nextState = CHECK_3;
			end
			CHECK_3:
			begin
				nextState = CHECK_4;
			end
			CHECK_4:
			begin
				nextState = CHECK_5;
			end
			CHECK_5:
			begin
				nextState = CHECK_6;
			end
			CHECK_6:
			begin
				nextState = CHECK_7;
			end
			CHECK_7:
			begin
				nextState = CHECK_8;
			end
			CHECK_8:
			begin
				nextState = WAIT_FOR_SIGNAL;
			end
			default: nextState = WAIT_FOR_SIGNAL;
		endcase
	end
	
	always @ (posedge clock)
	begin
		writeEnable <= 1'b0;
		q <= 1'b0;
		relativePositionValue <= 12'd0;
		if (moveUp)
		begin
			queueUp <= 1'b1;
		end
		if (moveDown)
		begin
			queueDown <= 1'b1;
		end
		if (moveRight)
		begin
			queueRight <= 1'b1;
		end
		if (moveLeft)
		begin
			queueLeft <= 1'b1;
		end
		case (currentState)
			DOWN_P1:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd320;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P2:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd319;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P3:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd318;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P4:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd317;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P5:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd316;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P6:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd315;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P7:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd314;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_P8:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd313;
				relativePositionValue [12] <= 1'b1;
			end
			DOWN_PAUSE:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
			end
			DOWN_P9:
			begin
				relativePositionValue [11:0] <= 12'd2240;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_P10:
			begin
				relativePositionValue [11:0] <= 12'd2241;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;	
			end
			DOWN_P11:
			begin
				relativePositionValue [11:0] <= 12'd2242;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_P12:
			begin
				relativePositionValue [11:0] <= 12'd2243;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_P13:
			begin
				relativePositionValue [11:0] <= 12'd2244;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_P14:
			begin
				relativePositionValue [11:0] <= 12'd2245;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_P15:
			begin
				relativePositionValue [11:0] <= 12'd2246;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_P16:
			begin
				queueDown <= 1'b0;
				relativePositionValue [11:0] <= 12'd2247;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b1;
				writeEnable <= 1'b1;
			end
			DOWN_END:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd0;
				relativePositionValue [12] <= 1'b0;
				q <= 1'b0;
			end
			UP_P1:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2560;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P2:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2561;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P3:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2562;
				relativePositionValue [12] <= 1'b0;			
			end
			UP_P4:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2563;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P5:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2564;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P6:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2565;
				relativePositionValue [12] <= 1'b0;	
			end
			UP_P7:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2566;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P8:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2567;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P9:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd0;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P10:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P11:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd2;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P12:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd3;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P13:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd4;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P14:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd5;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P15:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd6;
				relativePositionValue [12] <= 1'b0;
			end
			UP_P16:
			begin
				queueUp <= 1'b0;
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd7;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P1:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1;
				relativePositionValue [12] <= 1'b1;
			end
			RIGHT_P2:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd319;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P3:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd639;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P4:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd959;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P5:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1279;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P6:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1599;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P7:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1919;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P8:
			begin	
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2239;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P9:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd7;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P10:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd327;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P11:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd647;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P12:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd967;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P13:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1287;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P14:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1607;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P15:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1927;
				relativePositionValue [12] <= 1'b0;
			end
			RIGHT_P16:
			begin
				queueRight <= 1'b0;
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd2247;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P1:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd8;
				relativePositionValue [12] <= 1'b0;				
			end
			LEFT_P2:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd328;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P3:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd648;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P4:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd968;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P5:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1288;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P6:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1608;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P7:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd1928;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P8:
			begin
				writeEnable <= 1'b1;
				relativePositionValue [11:0] <= 12'd2248;
				relativePositionValue [12] <= 1'b0;			
			end
			LEFT_P9:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd0;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P10:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd320;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P11:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd640;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P12:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd960;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P13:
			begin	
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1280;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P14:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1600;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P15:
			begin
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd1920;
				relativePositionValue [12] <= 1'b0;
			end
			LEFT_P16:
			begin
				queueLeft <= 1'b0;
				writeEnable <= 1'b1;
				q <= 1'b1;
				relativePositionValue [11:0] <= 12'd2240;
				relativePositionValue [12] <= 1'b0;
			end
			CHECK_1:
			begin
				relativePositionValue [11:0] <= 12'd0;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_2:
			begin
				relativePositionValue [11:0] <= 12'd1;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_3:
			begin
				relativePositionValue [11:0] <= 12'd2;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_4:
			begin
				relativePositionValue [11:0] <= 12'd3;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_5:
			begin
				relativePositionValue [11:0] <= 12'd4;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_6:
			begin
				relativePositionValue [11:0] <= 12'd5;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_7:
			begin
				relativePositionValue [11:0] <= 12'd6;
				relativePositionValue [12] <= 1'd0;
			end
			CHECK_8:
			begin
				relativePositionValue [11:0] <= 12'd2240;
				relativePositionValue [12] <= 1'd0;
			end
		endcase
	end
	
	always @ (posedge clock)
	begin
	if (resetn)
		currentState <= WAIT_FOR_SIGNAL;
	else
		currentState <= nextState;
	end
	
endmodule

module datapath (resetn, clock, writeEnable, q, relativePositionValue, currentAddress, outQ, blahAddress);

	input resetn;
	input clock;
	input writeEnable;
	input q;
	input [12:0] relativePositionValue;
	input [16:0] currentAddress;
	output [1:0] outQ;
	output [16:0] blahAddress;
	
	wire [1:0] data;
	reg [16:0] theAddress;
	
	always @ (*)
	begin
		if (relativePositionValue[12] == 1'b1)
		begin
			theAddress = currentAddress - relativePositionValue;
		end
		else
		begin
			theAddress = currentAddress + relativePositionValue;
		end
	end
	
	assign data[1] = q;
	assign data[0] = outQ[0];
	assign blahAddress = theAddress;
	
	Yes bmap(.address(theAddress),
						.clock(clock),
						.data(data),
						.wren(writeEnable),
						.q(outQ)
						);

endmodule
