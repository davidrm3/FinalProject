module char_controller(input [7:0] keycode0, keycode1,
							  input CLK,
							  input [31:0] j_count, space_count, arc_count, fall_count,
							  input left_collide, right_collide, bottom_collide, side_collide, ts_collide, bs_collide,
							  input reset,
							  input Char_Size,
							  output count_reset,
							  output logic [9:0] Char_X_Motion, Char_Y_Motion, Char_X_Pos, Char_Y_Pos,
							  output logic space_en, jump_en, arc_en, fall_en,
							  output [3:0] HEXstate
);

enum logic [3:0] {A, //restart
						B, //idle
						C, //walk_r
						D, //walk_l
						E, //crouch
						F, //jump
						G, //arc
						H, //jump_l
						I, //arc_l
						J, //jump_r
						K, //arc_r
						L, //fall
						M, //fall_r
						N, //fall_l
						O, //
						P //
						}	state, next_state;	
						
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
				Char_Y_Pos <= 410;				
			end
		else if (ts_collide)
			begin
				Char_X_Pos <= Char_X_Pos;
				Char_Y_Pos <= 436;
			end
		else if (bs_collide)
			begin
				Char_X_Pos <= Char_X_Pos;
				Char_Y_Pos <= 40;
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
				else if ((keycode0 == 8'h2C) || 
							((keycode0 == 8'h07) && (keycode1 == 8'h2C)) || 
							((keycode0 == 8'h2C) && (keycode1 == 8'h07)) || 
							((keycode0 == 8'h04) && (keycode1 == 8'h2C)) || 
							((keycode0 == 8'h2C) && (keycode1 == 8'h04)))// if "space" pressed
					next_state = E; //crouch
				else if ((keycode0 == 8'h07) && (!left_collide) && (!bottom_collide)) // if not on platform and going right
					next_state = M; //fall_r
				else if ((keycode0 == 8'h04) && (!left_collide) && (!bottom_collide)) // if not on platform and going left
					next_state = N; //fall_l
				else if ((keycode0 == 8'h04) && (!left_collide) && (bottom_collide))// if "A" pressed
					next_state = D; //walk_l
				else if ((keycode0 == 8'h07) && (!right_collide) && (bottom_collide))// if "D" pressed
					next_state = C; //walk_r
				
				else
					next_state = B; //idle
			end
		C: //walk_r
			begin
				if ((keycode0 == 8'h07) & (!right_collide) && (bottom_collide))
					next_state = C; //walk_r
				else if (((keycode0 == 8'h07) && (keycode1 == 8'h2C))||((keycode0 == 8'h2C) && (keycode1 == 8'h07)))// if "space" pressed
					next_state = E; //crouch
				else if ((keycode0 == 8'h00) || (right_collide))
					next_state = B; //idle
				else if ((keycode0 == 8'h07) && (!left_collide) && (!bottom_collide)) // if not on platform and going right
					next_state = M; //fall_r
			end
		D: //walk_l
			begin
				if ((keycode0 == 8'h04) && (!left_collide) && (bottom_collide))
					next_state = D; //walk_l
				else if (((keycode0 == 8'h04) && (keycode1 == 8'h2C))||((keycode0 == 8'h2C) && (keycode1 == 8'h04)))// if "space" pressed
					next_state = E; //crouch
				else if ((keycode0 == 8'h00) || (left_collide))
					next_state = B; //idle
				else if ((keycode0 == 8'h04) && (!left_collide) && (!bottom_collide)) // if not on platform and going left
					next_state = N; //fall_l
			end
		E: //crouch
			begin
				if (reset)
					next_state = A; //restart
				else if (keycode0 == 8'h2C)// if "SPACE" is not released
					next_state = E;
				else if ((keycode0 == 8'h00) && (keycode1 == 8'h00)) // if neither "A" or "D" are pressed on release of "SPACE"
					next_state = F;
				else if (keycode0 == 8'h04)// if "A" is pressed on release of "SPACE"
					next_state = H; //jump_l
				else if (keycode0 == 8'h07) // if "D" is pressed on release of "SPACE'
					next_state = J;
				else	
					next_state = E;
			end
		F: //jump up
			begin
				if (reset)
					next_state = A; //restart
				else if (j_count >= space_count)
					next_state = G; //arc
			end
		G: //arc to fall
			begin
				if (reset)
					next_state = A; //restart
				else if (bottom_collide) // if character hits floor
					next_state = B; //idle
			end
		H: //jump_l
			begin
				if (reset)
					next_state = A; //restart
				else if (left_collide)// if hit left edge then bounce right
					next_state = J;
				else if (j_count >= space_count)
					next_state = I; //arc_l
			end
		I: //arc_l
			begin
				if (reset)
					next_state = A; //restart
				else if (left_collide) // if hit left edge then bounce right
					next_state = K;
				else if (bottom_collide) // if character hits floor
					next_state = B; //idle
			end
		J: //jump_r
			begin
				if (reset)
					next_state = A; //restart
				else if (right_collide)// if hit right edge then bounce left
					next_state = H;
				else if (j_count >= space_count)
					next_state = K; //peak_r
			end
		K: //arc_r
			begin
				if (reset)
					next_state = A; //restart
				else if (right_collide)// if hit right edge then bounce left
					next_state = I;
				else if (bottom_collide) // if character hits floor
					next_state = B; //idle
			end
		M: //fall_r
			begin
				if (reset)
					next_state = A; //restart
				else if (bottom_collide) // if character hits floor
					next_state = B; //idle
			end
		N: //fall_l
			begin
				if (reset)
					next_state = A; //restart	
				else if (bottom_collide) // if character hits floor
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
				arc_en = 0;
				fall_en = 0;
				count_reset = 1;
				HEXstate = 4'b0000; //0
			end
		B: //idle
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				arc_en = 0;
				fall_en = 0;
				count_reset = 1;
				HEXstate = 4'b0001; //1
			end
		C: //walk_r
			begin
				Char_X_Motion = 2;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				arc_en = 0;
				fall_en = 0;
				count_reset = 1;
				HEXstate = 4'b0010; //2
			end
		D: //walk_l
			begin
				Char_X_Motion = -2;
				Char_Y_Motion = 0;
				space_en = 0;
				jump_en = 0;
				arc_en = 0;
				fall_en = 0;
				count_reset = 1;
				HEXstate = 4'b0011; //3
			end
		E: //crouch
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 0;
				space_en = 1;
				jump_en = 0;
				arc_en = 0;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b0100; //4
			end
		F: //jump
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = -3;
				space_en = 0;
				jump_en = 1;
				arc_en = 0;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b0101; //5
			end
		G: //arc
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = -3 + arc_count;
				space_en = 0;
				jump_en = 0;
				arc_en = 1;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b0110; //6
			end			
		H: //jump_l
			begin
				Char_X_Motion = -1;
				Char_Y_Motion = -3;
				space_en = 0;
				jump_en = 1;
				arc_en = 0;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b0111; //7
			end
		I: //arc_l
			begin
				Char_X_Motion = -1;
				Char_Y_Motion = -3 + arc_count;
				space_en = 0;
				jump_en = 0;
				arc_en = 1;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b1000; //8
			end	
		J: //jump_r
			begin
				Char_X_Motion = 1;
				Char_Y_Motion = -3;
				space_en = 0;
				jump_en = 1;
				arc_en = 0;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b1001; //9
			end
		K: //arc_r
			begin
				Char_X_Motion = 1;
				Char_Y_Motion = -3 + arc_count;
				space_en = 0;
				jump_en = 0;
				arc_en = 1;
				fall_en = 0;
				count_reset = 0;
				HEXstate = 4'b1010; //A
			end	
		L: //fall
			begin
				Char_X_Motion = 0;
				Char_Y_Motion = 1 + fall_count;
				space_en = 0;
				jump_en = 0;
				arc_en = 1;
				fall_en = 1;
				count_reset = 0;
				HEXstate = 4'b1011; //b
			end
		M: //fall_r
			begin
				Char_X_Motion = 1;
				Char_Y_Motion = 1 + fall_count;
				space_en = 0;
				jump_en = 0;
				arc_en = 1;
				fall_en = 1;
				count_reset = 0;
				HEXstate = 4'b1011; //b
			end
		N: //fall_l
			begin
				Char_X_Motion = -1;
				Char_Y_Motion = 1 + fall_count;
				space_en = 0;
				jump_en = 0;
				arc_en = 1;
				fall_en = 1;
				count_reset = 0;
				HEXstate = 4'b1100; //C
			end
	endcase
end
endmodule