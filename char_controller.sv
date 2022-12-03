module char_controller(input [7:0] keycode0, keycode1,
							  input CLK,
							  input j_count, space_count,
							  input [9:0] Char_Y_Min, Char_Y_Max,
							  input reset,
							  input Char_Size,
							  output count_reset,
							  output logic [9:0] Char_X_Motion, Char_Y_Motion, Char_X_Pos, Char_Y_Pos,
							  output logic space_en, jump_en,
							  output [3:0] HEXstate
);

enum logic [3:0] {A, //restart
						B, //idle
						C, //walk_r
						D, //walk_l
						E, //crouch
						F, //jump
						G, //peak
						H, //fall
						I, //jump_l
						J, //peak_l
						K, //fall_l
						L, //jump_r
						M, //peak_r
						N, //fall_r
						O, //wind
						P //slide
						}	state, next_state;	
	
assign HEXstate = state;	
						
always_ff @ (posedge CLK)
	begin
		if (reset)
			state <= A; //restart
		else
			state <= next_state;
	end

always_ff @ (posedge CLK)
	begin
		if (state == A)
			begin
				Char_X_Pos <= 320;
				Char_Y_Pos <= 240;				
			end
		else
			begin
				Char_X_Pos <= (Char_X_Pos + Char_X_Motion);
				Char_Y_Pos <= (Char_Y_Pos + Char_Y_Motion);				
			end
	end
	
always_comb
begin
next_state = state;

Char_X_Motion = 0;
Char_Y_Motion = 0;
space_en = 0;
jump_en = 0;
count_reset = 0;

	unique case (state)
		A: //restart
			next_state = B; //idle
		B: //idle
			begin
				if (reset)
					next_state = A; //restart
				else if (keycode0 == 8'h44)// if "space" pressed
					next_state = F; //jump
				else if (keycode0 == 8'h04)// if "A" pressed
					next_state = D; //walk_l
				else if (keycode0 == 8'h07)// if "D" pressed
					next_state = C; //walk_r
				else if ((Char_Y_Pos + Char_Size) < Char_Y_Max)
					next_state = H; //fall
				else
					next_state = B; //idle
			end
		C: //walk_r
			begin
				if (keycode0 == 8'h07)
					next_state = C; //walk_r
				else
					next_state = B; //idle
			end
		D: //walk_l
			begin
				if (keycode0 == 8'h04)
					next_state = D; //walk_l
				else if (keycode0 == 8'h00)
					next_state = B; //idle
			end
//		crouch:
//			begin
//				if (reset)
//					next_state = restart;
//				else if (keycode0 == 8'h44)// if "SPACE" is not released
//					next_state = crouch;
//				else if (keycode0 == 8'hA) // if neither "A" or "D" are pressed on release of "SPACE"
//					next_state = jump;
//				else if ((keycode0 == 8'hA) && (keycode1 == 8'hE))// if "A" is pressed on release of "SPACE"
//					next_state = jump_l;
//				else if ((keycode0 == 8'hA) && (keycode1 == 8'hH)) // if "D" is pressed on release of "SPACE'
//					next_state = jump_r;
//				else	
//					next_state = crouch;
//			end
		F: //jump
			begin
				if (reset)
					next_state = A; //restart
				else if (keycode0 == 8'h44)
					next_state = F; //jump
				else if (keycode0 == 8'h00)
					next_state = N; //fall
//				else if (((Char_Y_Pos + Char_Size) < Char_Y_Max) && (Char_Y_Motion < 0 ))
//					next_state = jump;
//				else if (((Char_Y_Pos + Char_Size) < Char_Y_Max) && (Char_Y_Motion == 0))
//					next_state = peak;
//				else if ((Char_Y_Pos + Char_Size) >= Char_Y_Max)
//					next_state = idle;
			end
		G: //peak
			begin
				if (reset)
					next_state = A; //restart
				else if (((Char_Y_Pos + Char_Size) < Char_Y_Max) && (Char_Y_Motion > 0))
					next_state = H; //fall
				else if ((Char_Y_Pos + Char_Size) >= Char_Y_Max)
					next_state = B; //idle
			end
		H: //fall
			begin
				if (reset)
					next_state = A; //restart
				else if ((Char_Y_Pos + Char_Size) >= (Char_Y_Max)) // if character hits floor
					next_state = B; //idle
			end
	endcase

	unique case (state)
		A: //restart
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
		B: //idle
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
		C: //walk_r
			begin
				Char_X_Motion = 1;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
		D: //walk_l
			begin
				Char_X_Motion = -1;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
//		crouch:
//			begin
//				Char_X_Motion = 0;
//				Char_Y_Motion = 0;
//				space_en = 1;
//				jump_en = 0;
//				count_reset = 0;
//			end
		F: //jump
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = -3;
				space_en = 0;
				jump_en = 1;
				count_reset = 0;
			end
		G: //peak
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 3;
				space_en = 0;
				jump_en = 0;
				count_reset = 0;
			end			
		H: //fall
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 3;
				space_en = 0;
				jump_en = 0;
				count_reset = 0;
			end
	endcase
end
endmodule
														