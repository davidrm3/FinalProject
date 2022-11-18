module char_controller(input [7:0] keycode0, keycode1,
							  input CLK,
							  input j_count, space_count,
							  input [9:0] Char_Y_Min, Char_Y_Max,
							  input reset,
							  input Char_Size,
							  output count_reset,
							  output logic [9:0] Char_X_Motion, Char_Y_Motion, Char_X_Pos, Char_Y_Pos,
							  output logic space_en, jump_en
);

enum logic [3:0] {restart,
						idle,
						walk_r,
						walk_l,
						crouch,
						jump,
						peak,
						fall,
						jump_l,
						peak_l,
						fall_l,
						jump_r,
						peak_r,
						fall_r,
						wind,
						slide
						}	state, next_state;

always_ff @ (posedge CLK)
	begin
		if (reset)
			state <= restart;
		else
			state <= next_state;
	end

always_ff @ (posedge CLK)
	begin
		if (state == restart)
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
		restart:
			next_state = idle;
		idle:
			begin
				if (reset)
					next_state = restart;
				else if (keycode0 == 8'h44)// if "space" pressed
					next_state = jump;
				else if (keycode0 == 8'h04)// if "A" pressed
					next_state = walk_l;
				else if (keycode0 == 8'h07)// if "D" pressed
					next_state = walk_r;
				else if ((Char_Y_Pos + Char_Size) < Char_Y_Max)
					next_state = fall;
				else
					next_state = idle;
			end
		walk_r:
			begin
				if (keycode0 == 8'h07)
					next_state = walk_r;
				else
					next_state = idle;
			end
		walk_l:
			begin
				if (keycode0 == 8'h04)
					next_state = walk_l;
				else if (keycode0 == 8'h00)
					next_state = idle;
			end
//		crouch:
//			begin
//				if (reset)
//					next_state = restart;
//				else if (keycode0 == 8'h44)// if "SPACE" is not released
//					next_state = crouch;
//				else if (keycode0 == 8'h00) // if neither "A" or "D" are pressed on release of "SPACE"
//					next_state = jump;
//				else if ((keycode0 == 8'h00) && (keycode1 == 8'h04))// if "A" is pressed on release of "SPACE"
//					next_state = jump_l;
//				else if ((keycode0 == 8'h00) && (keycode1 == 8'h07)) // if "D" is pressed on release of "SPACE'
//					next_state = jump_r;
//				else	
//					next_state = crouch;
//			end
		jump:// upward jump
			begin
				if (reset)
					next_state = restart;
				else if (keycode0 == 8'h44)
					next_state = jump;
				else if (((Char_Y_Pos + Char_Size) < Char_Y_Max) && (Char_Y_Motion < 0 ))
					next_state = jump;
				else if (((Char_Y_Pos + Char_Size) < Char_Y_Max) && (Char_Y_Motion == 0))
					next_state = peak;
				else if ((Char_Y_Pos + Char_Size) >= Char_Y_Max)
					next_state = idle;
			end
		peak:
			begin
				if (reset)
					next_state = restart;
				else if (((Char_Y_Pos + Char_Size) < Char_Y_Max) && (Char_Y_Motion > 0))
					next_state = fall;
				else if ((Char_Y_Pos + Char_Size) >= Char_Y_Max)
					next_state = idle;
			end
		fall:
			begin
				if (reset)
					next_state = restart;
				else if ((Char_Y_Pos + Char_Size) >= (Char_Y_Max)) // if character hits floor
					next_state = idle;
			end
	endcase

	unique case (state)
		restart:
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
		idle:
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
		walk_r:
			begin
				Char_X_Motion = 1;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				count_reset = 1;
			end
		walk_l:
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
		jump:
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = -3 + j_count;
				space_en = 0;
				jump_en = 1;
				count_reset = 0;
			end
		peak:
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 3;
				space_en = 0;
				jump_en = 0;
				count_reset = 0;
			end			
		fall:
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
														