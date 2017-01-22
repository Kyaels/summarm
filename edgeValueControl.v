module edgeValueControl (clock, resetn, ld_edgeValue, ld_read_Address, relativePositionValue);

	input clock;
	input resetn;
	output reg [5:0] relativePositionValue;
	output reg ld_edgeValue;
	output reg ld_read_Address;
	
	reg [5:0] currentState, nextState;
	
	localparam READ_ADDRESS_1 = 6'd1,
				  EDGE_VALUE_1 = 6'd2,
				  READ_ADDRESS_2 = 6'd3,
				  EDGE_VALUE_2 = 6'd4,
				  READ_ADDRESS_3 = 6'd5,
				  EDGE_VALUE_3 = 6'd6,
				  READ_ADDRESS_4 = 6'd7,
				  EDGE_VALUE_4 = 6'd8,
				  READ_ADDRESS_5 = 6'd9,
				  EDGE_VALUE_5 = 6'd10,
				  READ_ADDRESS_6 = 6'd11,
				  EDGE_VALUE_6 = 6'd12,
				  READ_ADDRESS_7 = 6'd13,
				  EDGE_VALUE_7 = 6'd14,
				  READ_ADDRESS_8 = 6'd15,
				  EDGE_VALUE_8 = 6'd16,
				  READ_ADDRESS_9 = 6'd17,
				  EDGE_VALUE_9 = 6'd18,
				  READ_ADDRESS_10 = 6'd19,
				  EDGE_VALUE_10 = 6'd20,
				  READ_ADDRESS_11 = 6'd21,
				  EDGE_VALUE_11 = 6'd22,
				  READ_ADDRESS_12 = 6'd23,
				  EDGE_VALUE_12 = 6'd24,
				  READ_ADDRESS_13 = 6'd25,
				  EDGE_VALUE_13 = 6'd26,
				  READ_ADDRESS_14 = 6'd27,
				  EDGE_VALUE_14 = 6'd28,
				  READ_ADDRESS_15 = 6'd29,
				  EDGE_VALUE_15 = 6'd30,
				  READ_ADDRESS_16 = 6'd31,
				  EDGE_VALUE_16 = 6'd32,
				  READ_ADDRESS_17 = 6'd33,
				  EDGE_VALUE_17 = 6'd34,
				  READ_ADDRESS_18 = 6'd35,
				  EDGE_VALUE_18 = 6'd36,
				  READ_ADDRESS_19 = 6'd37,
				  EDGE_VALUE_19 = 6'd38,
				  READ_ADDRESS_20 = 6'd39,
				  EDGE_VALUE_20 = 6'd40,
				  READ_ADDRESS_21 = 6'd41,
				  EDGE_VALUE_21 = 6'd42,
				  READ_ADDRESS_22 = 6'd43,
				  EDGE_VALUE_22 = 6'd44,
				  READ_ADDRESS_23 = 6'd45,
				  EDGE_VALUE_23 = 6'd46,
				  READ_ADDRESS_24 = 6'd47,
				  EDGE_VALUE_24 = 6'd48,
				  READ_ADDRESS_25 = 6'd49,
				  EDGE_VALUE_25 = 6'd50,
				  READ_ADDRESS_26 = 6'd51,
				  EDGE_VALUE_26 = 6'd52,
				  READ_ADDRESS_27 = 6'd53,
				  EDGE_VALUE_27 = 6'd54,
				  READ_ADDRESS_28 = 6'd55,
				  EDGE_VALUE_28 = 6'd56;
	
	always @ (posedge clock)
	begin
		case (currentState)
			READ_ADDRESS_1:
			begin
				nextState = EDGE_VALUE_1;
			end
			EDGE_VALUE_1:
			begin
				nextState = READ_ADDRESS_2;
			end
			READ_ADDRESS_2:
			begin
				nextState = EDGE_VALUE_2;
			end
			EDGE_VALUE_2:
			begin
				nextState = READ_ADDRESS_3;
			end
			READ_ADDRESS_3:
			begin
				nextState = EDGE_VALUE_3;
			end
			EDGE_VALUE_3:
			begin
				nextState = READ_ADDRESS_4;
			end
			READ_ADDRESS_4:
			begin
				nextState = EDGE_VALUE_4;
			end
			EDGE_VALUE_4:
			begin
				nextState = READ_ADDRESS_5;
			end
			READ_ADDRESS_5:
			begin
				nextState = EDGE_VALUE_5;
			end
			EDGE_VALUE_5:
			begin
				nextState = READ_ADDRESS_6;
			end
			READ_ADDRESS_6:
			begin
				nextState = EDGE_VALUE_6;
			end
			EDGE_VALUE_6:
			begin
				nextState = READ_ADDRESS_7;
			end
			READ_ADDRESS_7:
			begin
				nextState = EDGE_VALUE_7;
			end
			EDGE_VALUE_7:
			begin
				nextState = READ_ADDRESS_8;
			end
			READ_ADDRESS_8:
			begin
				nextState = EDGE_VALUE_8;
			end
			EDGE_VALUE_8:
			begin
				nextState = READ_ADDRESS_9;
			end
			READ_ADDRESS_9:
			begin
				nextState = EDGE_VALUE_9;
			end
			EDGE_VALUE_9:
			begin
				nextState = READ_ADDRESS_10;
			end
			READ_ADDRESS_10:
			begin
				nextState = EDGE_VALUE_10;
			end
			EDGE_VALUE_10:
			begin
				nextState = READ_ADDRESS_11;
			end
			READ_ADDRESS_11:
			begin
				nextState = EDGE_VALUE_11;
			end
			EDGE_VALUE_11:
			begin
				nextState = READ_ADDRESS_12;
			end
			READ_ADDRESS_12:
			begin
				nextState = EDGE_VALUE_12;
			end
			EDGE_VALUE_12:
			begin
				nextState = READ_ADDRESS_13;
			end
			READ_ADDRESS_13:
			begin
				nextState = EDGE_VALUE_13;
			end
			EDGE_VALUE_13:
			begin
				nextState = READ_ADDRESS_14;
			end
			READ_ADDRESS_14:
			begin
				nextState = EDGE_VALUE_14;
			end
			EDGE_VALUE_14:
			begin
				nextState = READ_ADDRESS_15;
			end
			READ_ADDRESS_15:
			begin
				nextState = EDGE_VALUE_15;
			end
			EDGE_VALUE_15:
			begin
				nextState = READ_ADDRESS_16;
			end
			READ_ADDRESS_16:
			begin
				nextState = EDGE_VALUE_16;
			end
			EDGE_VALUE_16:
			begin
				nextState = READ_ADDRESS_17;
			end
			READ_ADDRESS_17:
			begin
				nextState = EDGE_VALUE_17;
			end
			EDGE_VALUE_17:
			begin
				nextState = READ_ADDRESS_18;
			end
			READ_ADDRESS_18:
			begin
				nextState = EDGE_VALUE_18;
			end
			EDGE_VALUE_18:
			begin
				nextState = READ_ADDRESS_19;
			end
			READ_ADDRESS_19:
			begin
				nextState = EDGE_VALUE_19;
			end
			EDGE_VALUE_19:
			begin
				nextState = READ_ADDRESS_20;
			end
			READ_ADDRESS_20:
			begin
				nextState = EDGE_VALUE_20;
			end
			EDGE_VALUE_20:
			begin
				nextState = READ_ADDRESS_21;
			end
			READ_ADDRESS_21:
			begin
				nextState = EDGE_VALUE_21;
			end
			EDGE_VALUE_21:
			begin
				nextState = READ_ADDRESS_22;
			end
			READ_ADDRESS_22:
			begin
				nextState = EDGE_VALUE_22;
			end
			EDGE_VALUE_22:
			begin
				nextState = READ_ADDRESS_23;
			end
			READ_ADDRESS_23:
			begin
				nextState = EDGE_VALUE_23;
			end
			EDGE_VALUE_23:
			begin
				nextState = READ_ADDRESS_24;
			end
			READ_ADDRESS_24:
			begin
				nextState = EDGE_VALUE_24;
			end
			EDGE_VALUE_24:
			begin
				nextState = READ_ADDRESS_25;
			end
			READ_ADDRESS_25:
			begin
				nextState = EDGE_VALUE_25;
			end
			EDGE_VALUE_25:
			begin
				nextState = READ_ADDRESS_26;
			end
			READ_ADDRESS_26:
			begin
				nextState = EDGE_VALUE_26;
			end
			EDGE_VALUE_26:
			begin
				nextState = READ_ADDRESS_27;
			end
			READ_ADDRESS_27:
			begin
				nextState = EDGE_VALUE_27;
			end
			EDGE_VALUE_27:
			begin
				nextState = READ_ADDRESS_28;
			end
			READ_ADDRESS_28:
			begin
				nextState = EDGE_VALUE_28;
			end
			EDGE_VALUE_28:
			begin
				nextState = READ_ADDRESS_1;
			end
			default:
			begin
				nextState = READ_ADDRESS_1;
			end
		endcase
	end
	
	always @ (posedge clock)
	begin
		ld_edgeValue <= 1'b0;
		ld_read_Address <= 1'b0;
		relativePositionValue <= 6'd0;
		case (currentState)
			READ_ADDRESS_1:
			begin
				ld_read_Address <= 1'b1;
			end
			EDGE_VALUE_1:
			begin
				ld_edgeValue <= 1'b1;
			end
			READ_ADDRESS_2:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1;
			end
			EDGE_VALUE_2:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1;
			end
			READ_ADDRESS_3:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2;
			end
			EDGE_VALUE_3:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2;
			end
			READ_ADDRESS_4:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd3;
			end
			EDGE_VALUE_4:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd3;
			end
			READ_ADDRESS_5:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd4;
			end
			EDGE_VALUE_5:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd4;
			end
			READ_ADDRESS_6:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd5;
			end
			EDGE_VALUE_6:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd5;
			end
			READ_ADDRESS_7:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd6;
			end
			EDGE_VALUE_7:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd6;
			end
			READ_ADDRESS_8:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd7;
			end
			EDGE_VALUE_8:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd7;
			end
			READ_ADDRESS_9:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd320;
			end
			EDGE_VALUE_9:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd320;
			end
			READ_ADDRESS_10:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd327;
			end
			EDGE_VALUE_10:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd327;
			end
			READ_ADDRESS_11:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd640;
			end
			EDGE_VALUE_11:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd640;
			end
			READ_ADDRESS_12:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd647;
			end
			EDGE_VALUE_12:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd647;
			end
			READ_ADDRESS_13:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd960;
			end
			EDGE_VALUE_13:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd960;
			end
			READ_ADDRESS_14:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd967;
			end
			EDGE_VALUE_14:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd967;
			end
			READ_ADDRESS_15:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1280;
			end
			EDGE_VALUE_15:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1280;
			end
			READ_ADDRESS_16:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1287;
			end
			EDGE_VALUE_16:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1287;
			end
			READ_ADDRESS_17:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1600;
			end
			EDGE_VALUE_17:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1600;
			end
			READ_ADDRESS_18:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1607;
			end
			EDGE_VALUE_18:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1607;
			end
			READ_ADDRESS_19:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1920;
			end
			EDGE_VALUE_19:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1920;
			end
			READ_ADDRESS_20:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd1927;
			end
			EDGE_VALUE_20:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd1927;
			end
			READ_ADDRESS_21:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2240;
			end
			EDGE_VALUE_21:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2240;
			end
			READ_ADDRESS_22:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2241;
			end
			EDGE_VALUE_22:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2241;
			end
			READ_ADDRESS_23:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2242;
			end
			EDGE_VALUE_23:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2242;
			end
			READ_ADDRESS_24:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2243;
			end
			EDGE_VALUE_24:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2243;
			end
			READ_ADDRESS_25:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2244;
			end
			EDGE_VALUE_25:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2244;
			end
			READ_ADDRESS_26:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2245;
			end
			EDGE_VALUE_26:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2245;
			end
			READ_ADDRESS_27:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2246;
			end
			EDGE_VALUE_27:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2246;
			end
			READ_ADDRESS_28:
			begin
				ld_read_Address <= 1'b1;
				relativePositionValue <= 6'd2247;
			end
			EDGE_VALUE_28:
			begin
				ld_edgeValue <= 1'b1;
				relativePositionValue <= 6'd2247;
			end
		endcase
	end
	
	always @ (posedge clock)
	begin
		if (!resetn)
		begin
			currentState <= READ_ADDRESS_1;
		end
		else
		begin	
			currentState <= nextState;
		end
	end
endmodule
