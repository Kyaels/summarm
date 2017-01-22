module drawRocketControl(clock, resetn, moveUp, moveDown, moveLeft, moveRight, readRocket, load, relativeX, relativeY);

	input clock;
	input resetn;
	input moveUp, moveDown, moveLeft, moveRight;
	output reg readRocket;
	output reg load;
	output reg [4:0] relativeX;
	output reg [4:0] relativeY;
	
	reg queueUp, queueDown, queueLeft, queueRight;
	reg [6:0] nextState, currentState;
	
	localparam  READY_TO_DRAW = 7'd0,
					DRAW_ROCKET_1 = 7'd1,
					DRAW_ROCKET_2 = 7'd2,
					DRAW_ROCKET_3 = 7'd3,
					DRAW_ROCKET_4 = 7'd4,
					DRAW_ROCKET_5 = 7'd5,
					DRAW_ROCKET_6 = 7'd6,
					DRAW_ROCKET_7 = 7'd7,
					DRAW_ROCKET_8 = 7'd8,
					DRAW_ROCKET_9 = 7'd9,
					DRAW_ROCKET_10 = 7'd10,
					DRAW_ROCKET_11 = 7'd11,
					DRAW_ROCKET_12 = 7'd12,
					DRAW_ROCKET_13 = 7'd13,
					DRAW_ROCKET_14 = 7'd14,
					DRAW_ROCKET_15 = 7'd15,
					DRAW_ROCKET_16 = 7'd16,
					DRAW_ROCKET_17 = 7'd17,
					DRAW_ROCKET_18 = 7'd18,
					DRAW_ROCKET_19 = 7'd19,
					DRAW_ROCKET_20 = 7'd20,
					DRAW_ROCKET_21 = 7'd21,
					DRAW_ROCKET_22 = 7'd22,
					DRAW_ROCKET_23 = 7'd23,
					DRAW_ROCKET_24 = 7'd24,
					DRAW_ROCKET_25 = 7'd25,
					DRAW_ROCKET_26 = 7'd26,
					DRAW_ROCKET_27 = 7'd27,
					DRAW_ROCKET_28 = 7'd28,
					DRAW_ROCKET_29 = 7'd29,
					DRAW_ROCKET_30 = 7'd30,
					DRAW_ROCKET_31 = 7'd31,
					DRAW_ROCKET_32 = 7'd32,
					DRAW_ROCKET_33 = 7'd33,
					DRAW_ROCKET_34 = 7'd34,
					DRAW_ROCKET_35 = 7'd35,
					DRAW_ROCKET_36 = 7'd36,
					DRAW_ROCKET_37 = 7'd37,
					DRAW_ROCKET_38 = 7'd38,
					DRAW_ROCKET_39 = 7'd39,
					DRAW_ROCKET_40 = 7'd40,
					DRAW_ROCKET_41 = 7'd41,
					DRAW_ROCKET_42 = 7'd42,
					DRAW_ROCKET_43 = 7'd43,
					DRAW_ROCKET_44 = 7'd44,
					DRAW_ROCKET_45 = 7'd45,
					DRAW_ROCKET_46 = 7'd46,
					DRAW_ROCKET_47 = 7'd47,
					DRAW_ROCKET_48 = 7'd48,
					DRAW_ROCKET_49 = 7'd49,
					DRAW_ROCKET_50 = 7'd50,
					DRAW_ROCKET_51 = 7'd51,
					DRAW_ROCKET_52 = 7'd52,
					DRAW_ROCKET_53 = 7'd53,
					DRAW_ROCKET_54 = 7'd54,
					DRAW_ROCKET_55 = 7'd55,
					DRAW_ROCKET_56 = 7'd56,
					DRAW_ROCKET_57 = 7'd57,
					DRAW_ROCKET_58 = 7'd58,
					DRAW_ROCKET_59 = 7'd59,
					DRAW_ROCKET_60 = 7'd60,
					DRAW_ROCKET_61 = 7'd61,
					DRAW_ROCKET_62 = 7'd62,
					DRAW_ROCKET_63 = 7'd63,
					DRAW_ROCKET_64 = 7'd64,
					DRAW_BG_UP_1 = 7'd65,
					DRAW_BG_UP_2 = 7'd66,
					DRAW_BG_UP_3 = 7'd67,
					DRAW_BG_UP_4 = 7'd68,
					DRAW_BG_UP_5 = 7'd69,
					DRAW_BG_UP_6 = 7'd70,
					DRAW_BG_UP_7 = 7'd71,
					DRAW_BG_UP_8 = 7'd72,
					DRAW_BG_DOWN_1 = 7'd73,
					DRAW_BG_DOWN_2 = 7'd74,
					DRAW_BG_DOWN_3 = 7'd75,
					DRAW_BG_DOWN_4 = 7'd76,
					DRAW_BG_DOWN_5 = 7'd77,
					DRAW_BG_DOWN_6 = 7'd78,
					DRAW_BG_DOWN_7 = 7'd79,
					DRAW_BG_DOWN_8 = 7'd80,
					DRAW_BG_RIGHT_1 = 7'd81,
					DRAW_BG_RIGHT_2 = 7'd82,
					DRAW_BG_RIGHT_3 = 7'd83,
					DRAW_BG_RIGHT_4 = 7'd84,
					DRAW_BG_RIGHT_5 = 7'd85,
					DRAW_BG_RIGHT_6 = 7'd86,
					DRAW_BG_RIGHT_7 = 7'd87,
					DRAW_BG_RIGHT_8 = 7'd88,
					DRAW_BG_LEFT_1 = 7'd89,
					DRAW_BG_LEFT_2 = 7'd90,
					DRAW_BG_LEFT_3 = 7'd91,
					DRAW_BG_LEFT_4 = 7'd92,
					DRAW_BG_LEFT_5 = 7'd93,
					DRAW_BG_LEFT_6 = 7'd94,
					DRAW_BG_LEFT_7 = 7'd95,
					DRAW_BG_LEFT_8 = 7'd96;
	
	always @ (posedge clock)
	begin
		case (currentState)
			READY_TO_DRAW:
			begin
				if (queueDown)
				begin
					nextState = DRAW_BG_DOWN_1;
				end
				else if (queueRight)
				begin
					nextState = DRAW_BG_RIGHT_1;
				end
				else if (queueLeft)
				begin
					nextState = DRAW_BG_LEFT_1;
				end
				else if (queueUp)
				begin
					nextState = DRAW_BG_UP_1;
				end
				else
				begin
					nextState = READY_TO_DRAW;
				end
			end
			DRAW_ROCKET_1:
			begin
				nextState = DRAW_ROCKET_2;
			end
			DRAW_ROCKET_2:
			begin
				nextState = DRAW_ROCKET_3;
			end
			DRAW_ROCKET_3:
			begin
				nextState = DRAW_ROCKET_4;
			end
			DRAW_ROCKET_4:
			begin
				nextState = DRAW_ROCKET_5;
			end
			DRAW_ROCKET_5:
			begin
				nextState = DRAW_ROCKET_6;
			end
			DRAW_ROCKET_6:
			begin
				nextState = DRAW_ROCKET_7;
			end
			DRAW_ROCKET_7:
			begin
				nextState = DRAW_ROCKET_8;
			end
			DRAW_ROCKET_8:
			begin
				nextState = DRAW_ROCKET_9;
			end
			DRAW_ROCKET_9:
			begin
				nextState = DRAW_ROCKET_10;
			end
			DRAW_ROCKET_10:
			begin
				nextState = DRAW_ROCKET_11;
			end
			DRAW_ROCKET_11:
			begin
				nextState = DRAW_ROCKET_12;
			end
			DRAW_ROCKET_12:
			begin
				nextState = DRAW_ROCKET_13;
			end
			DRAW_ROCKET_13:
			begin
				nextState = DRAW_ROCKET_14;
			end
			DRAW_ROCKET_14:
			begin
				nextState = DRAW_ROCKET_15;
			end
			DRAW_ROCKET_15:
			begin
				nextState = DRAW_ROCKET_16;
			end
			DRAW_ROCKET_16:
			begin
				nextState = DRAW_ROCKET_17;
			end
			DRAW_ROCKET_17:
			begin
				nextState = DRAW_ROCKET_18;
			end
			DRAW_ROCKET_18:
			begin
				nextState = DRAW_ROCKET_19;
			end
			DRAW_ROCKET_19:
			begin
				nextState = DRAW_ROCKET_20;
			end
			DRAW_ROCKET_20:
			begin
				nextState = DRAW_ROCKET_21;
			end
			DRAW_ROCKET_21:
			begin
				nextState = DRAW_ROCKET_22;
			end
			DRAW_ROCKET_22:
			begin
				nextState = DRAW_ROCKET_23;
			end
			DRAW_ROCKET_23:
			begin
				nextState = DRAW_ROCKET_24;
			end
			DRAW_ROCKET_24:
			begin
				nextState = DRAW_ROCKET_25;
			end
			DRAW_ROCKET_25:
			begin
				nextState = DRAW_ROCKET_26;
			end
			DRAW_ROCKET_26:
			begin
				nextState = DRAW_ROCKET_27;
			end
			DRAW_ROCKET_27:
			begin
				nextState = DRAW_ROCKET_28;
			end
			DRAW_ROCKET_28:
			begin
				nextState = DRAW_ROCKET_29;
			end
			DRAW_ROCKET_29:
			begin
				nextState = DRAW_ROCKET_30;
			end
			DRAW_ROCKET_30:
			begin
				nextState = DRAW_ROCKET_31;
			end
			DRAW_ROCKET_31:
			begin
				nextState = DRAW_ROCKET_32;
			end
			DRAW_ROCKET_32:
			begin
				nextState = DRAW_ROCKET_33;
			end
			DRAW_ROCKET_33:
			begin
				nextState = DRAW_ROCKET_34;
			end
			DRAW_ROCKET_34:
			begin
				nextState = DRAW_ROCKET_35;
			end
			DRAW_ROCKET_35:
			begin
				nextState = DRAW_ROCKET_36;
			end
			DRAW_ROCKET_36:
			begin
				nextState = DRAW_ROCKET_37;
			end
			DRAW_ROCKET_37:
			begin
				nextState = DRAW_ROCKET_38;
			end
			DRAW_ROCKET_38:
			begin
				nextState = DRAW_ROCKET_39;
			end
			DRAW_ROCKET_39:
			begin
				nextState = DRAW_ROCKET_40;
			end
			DRAW_ROCKET_40:
			begin
				nextState = DRAW_ROCKET_41;
			end
			DRAW_ROCKET_41:
			begin
				nextState = DRAW_ROCKET_42;
			end
			DRAW_ROCKET_42:
			begin
				nextState = DRAW_ROCKET_43;
			end
			DRAW_ROCKET_43:
			begin
				nextState = DRAW_ROCKET_44;
			end
			DRAW_ROCKET_44:
			begin
				nextState = DRAW_ROCKET_45;
			end
			DRAW_ROCKET_45:
			begin
				nextState = DRAW_ROCKET_46;
			end
			DRAW_ROCKET_46:
			begin
				nextState = DRAW_ROCKET_47;
			end
			DRAW_ROCKET_47:
			begin
				nextState = DRAW_ROCKET_48;
			end
			DRAW_ROCKET_48:
			begin
				nextState = DRAW_ROCKET_49;
			end
			DRAW_ROCKET_49:
			begin
				nextState = DRAW_ROCKET_50;
			end
			DRAW_ROCKET_50:
			begin
				nextState = DRAW_ROCKET_51;
			end
			DRAW_ROCKET_51:
			begin
				nextState = DRAW_ROCKET_52;
			end
			DRAW_ROCKET_52:
			begin
				nextState = DRAW_ROCKET_53;
			end
			DRAW_ROCKET_53:
			begin
				nextState = DRAW_ROCKET_54;
			end
			DRAW_ROCKET_54:
			begin
				nextState = DRAW_ROCKET_55;
			end
			DRAW_ROCKET_55:
			begin
				nextState = DRAW_ROCKET_56;
			end
			DRAW_ROCKET_56:
			begin
				nextState = DRAW_ROCKET_57;
			end
			DRAW_ROCKET_57:
			begin
				nextState = DRAW_ROCKET_58;
			end
			DRAW_ROCKET_58:
			begin
				nextState = DRAW_ROCKET_59;
			end
			DRAW_ROCKET_59:
			begin
				nextState = DRAW_ROCKET_60;
			end
			DRAW_ROCKET_60:
			begin
				nextState = DRAW_ROCKET_61;
			end
			DRAW_ROCKET_61:
			begin
				nextState = DRAW_ROCKET_62;
			end
			DRAW_ROCKET_62:
			begin
				nextState = DRAW_ROCKET_63;
			end
			DRAW_ROCKET_63:
			begin
				nextState = DRAW_ROCKET_64;
			end
			DRAW_ROCKET_64:
			begin
				nextState = READY_TO_DRAW;
			end
			DRAW_BG_DOWN_1:
			begin
				nextState = DRAW_BG_DOWN_2;
			end
			DRAW_BG_DOWN_2:
			begin
				nextState = DRAW_BG_DOWN_3;
			end
			DRAW_BG_DOWN_3:
			begin
				nextState = DRAW_BG_DOWN_4;
			end
			DRAW_BG_DOWN_4:
			begin
				nextState = DRAW_BG_DOWN_5;
			end
			DRAW_BG_DOWN_5:
			begin
				nextState = DRAW_BG_DOWN_6;
			end
			DRAW_BG_DOWN_6:
			begin
				nextState = DRAW_BG_DOWN_7;
			end
			DRAW_BG_DOWN_7:
			begin
				nextState = DRAW_BG_DOWN_8;
			end
			DRAW_BG_DOWN_8:
			begin
				nextState = DRAW_ROCKET_1;
			end
			DRAW_BG_UP_1:
			begin
				nextState = DRAW_BG_UP_2;
			end
			DRAW_BG_UP_2:
			begin
				nextState = DRAW_BG_UP_3;
			end
			DRAW_BG_UP_3:
			begin
				nextState = DRAW_BG_UP_4;
			end
			DRAW_BG_UP_4:
			begin
				nextState = DRAW_BG_UP_5;
			end
			DRAW_BG_UP_5:
			begin
				nextState = DRAW_BG_UP_6;
			end
			DRAW_BG_UP_6:
			begin
				nextState = DRAW_BG_UP_7;
			end
			DRAW_BG_UP_7:
			begin
				nextState = DRAW_BG_UP_8;
			end
			DRAW_BG_UP_8:
			begin
				nextState = DRAW_ROCKET_1;
			end
			DRAW_BG_LEFT_1:
			begin
				nextState = DRAW_BG_LEFT_2;
			end
			DRAW_BG_LEFT_2:
			begin
				nextState = DRAW_BG_LEFT_3;
			end
			DRAW_BG_LEFT_3:
			begin
				nextState = DRAW_BG_LEFT_4;
			end
			DRAW_BG_LEFT_4:
			begin
				nextState = DRAW_BG_LEFT_5;
			end
			DRAW_BG_LEFT_5:
			begin
				nextState = DRAW_BG_LEFT_6;
			end
			DRAW_BG_LEFT_6:
			begin
				nextState = DRAW_BG_LEFT_7;
			end
			DRAW_BG_LEFT_7:
			begin
				nextState = DRAW_BG_LEFT_8;
			end
			DRAW_BG_LEFT_8:
			begin
				nextState = DRAW_ROCKET_1;
			end
			DRAW_BG_RIGHT_1:
			begin
				nextState = DRAW_BG_RIGHT_2;
			end
			DRAW_BG_RIGHT_2:
			begin
				nextState = DRAW_BG_RIGHT_3;
			end
			DRAW_BG_RIGHT_3:
			begin
				nextState = DRAW_BG_RIGHT_4;
			end
			DRAW_BG_RIGHT_4:
			begin
				nextState = DRAW_BG_RIGHT_5;
			end
			DRAW_BG_RIGHT_5:
			begin
				nextState = DRAW_BG_RIGHT_6;
			end
			DRAW_BG_RIGHT_6:
			begin
				nextState = DRAW_BG_RIGHT_7;
			end
			DRAW_BG_RIGHT_7:
			begin
				nextState = DRAW_BG_RIGHT_8;
			end
			DRAW_BG_RIGHT_8:
			begin
				nextState = DRAW_ROCKET_1;
			end
			default: 
			begin
				nextState = READY_TO_DRAW;
			end
		endcase
	end
	
	always @ (posedge clock)
	begin
		load <= 1'b1;
		relativeX <= 5'b0;
		relativeY <= 5'b0;
		readRocket <= 1'b1;
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
			READY_TO_DRAW:
			begin
				load <= 1'b0;
			end
			DRAW_ROCKET_2:
			begin
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_3:
			begin
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_4:
			begin
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_5:
			begin
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_6:
			begin
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_7:
			begin
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_8:
			begin
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_9:
			begin
				relativeY[3:0] <= 4'd1;
			end
			DRAW_ROCKET_10:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_11:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_12:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_13:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_14:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_15:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_16:
			begin
				relativeY[3:0] <= 4'd1;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_17:
			begin
				relativeY[3:0] <= 4'd2;
			end
			DRAW_ROCKET_18:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_19:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_20:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_21:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_22:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_23:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_24:
			begin
				relativeY[3:0] <= 4'd2;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_25:
			begin
				relativeY[3:0] <= 4'd3;
			end
			DRAW_ROCKET_26:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_27:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_28:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_29:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_30:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_31:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_32:
			begin
				relativeY[3:0] <= 4'd3;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_33:
			begin
				relativeY[3:0] <= 4'd4;
			end
			DRAW_ROCKET_34:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_35:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_36:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_37:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_38:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_39:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_40:
			begin
				relativeY[3:0] <= 4'd4;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_41:
			begin
				relativeY[3:0] <= 4'd5;
			end
			DRAW_ROCKET_42:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_43:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_44:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_45:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_46:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_47:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_48:
			begin
				relativeY[3:0] <= 4'd5;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_49:
			begin
				relativeY[3:0] <= 4'd6;
			end
			DRAW_ROCKET_50:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_51:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_52:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_53:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_54:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_55:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_56:
			begin
				relativeY[3:0] <= 4'd6;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_ROCKET_57:
			begin
				relativeY[3:0] <= 4'd7;
			end
			DRAW_ROCKET_58:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd1;
			end
			DRAW_ROCKET_59:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd2;
			end
			DRAW_ROCKET_60:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd3;
			end
			DRAW_ROCKET_61:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd4;
			end
			DRAW_ROCKET_62:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd5;
			end
			DRAW_ROCKET_63:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd6;
			end
			DRAW_ROCKET_64:
			begin
				relativeY[3:0] <= 4'd7;
				relativeX[3:0] <= 4'd7;
			end
			DRAW_BG_DOWN_1:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_2:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_3:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd2;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_4:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd3;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_5:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd4;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_6:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd5;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_7:
			begin
				relativeY[3:0] <= 4'd6;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd6;
				readRocket <= 1'b0;
			end
			DRAW_BG_DOWN_8:
			begin
				relativeY[3:0] <= 4'd1;
				relativeY[4] <= 1'b1;
				relativeX[3:0] <= 4'd7;
				readRocket <= 1'b0;
				queueDown <= 1'b0;
			end
			DRAW_BG_UP_1:
			begin
				relativeY[3:0] <= 4'd8;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_2:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd1;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_3:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd2;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_4:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd3;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_5:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd4;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_6:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd5;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_7:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd6;
				readRocket <= 1'b0;
			end
			DRAW_BG_UP_8:
			begin
				relativeY[3:0] <= 4'd8;
				relativeX[3:0] <= 4'd7;
				readRocket <= 1'b0;
				queueUp <= 1'b0;
			end
			DRAW_BG_RIGHT_1:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_2:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd1;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_3:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd2;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_4:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd3;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_5:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd4;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_6:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd5;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_7:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd6;
				readRocket <= 1'b0;
			end
			DRAW_BG_RIGHT_8:
			begin
				relativeX[4] <= 1'b1;
				relativeX[3:0] <= 4'd1;
				relativeY[3:0] <= 4'd7;
				readRocket <= 1'b0;
				queueRight <= 1'b0;
			end
			DRAW_BG_LEFT_1:
			begin
				relativeX[3:0] <= 4'd8;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_2:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd1;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_3:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd2;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_4:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd3;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_5:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd4;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_6:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd5;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_7:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd6;
				readRocket <= 1'b0;
			end
			DRAW_BG_LEFT_8:
			begin
				relativeX[3:0] <= 4'd8;
				relativeY[3:0] <= 4'd7;
				readRocket <= 1'b0;
				queueLeft <= 1'b0;
			end
		endcase
	end
	
	always @ (posedge clock)
	begin
		if (resetn)
		begin
			currentState <= READY_TO_DRAW;
		end
		else
		begin
			currentState <= nextState;
		end
	end
	
endmodule
