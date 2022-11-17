module char_controller(input [7:0] keycode,
							  input CLK,
							  input j_count,
							  output RESET,
							  output logic [9:0] Char_X_Motion, Char_Y_Motion,
							  output logic space_en, jump_en

);

enum logic [2:0] {idle,
						walk_r,
						walk_l,
						crouch,
						jump,
						jump_l,
						jump_r
						}	state, next_state;

always_ff @ (posedge CLK)
	begin
		state <= next_state;
	end
	
always_comb
begin
	unique case (state)
		idle:
			begin
				if (keycode == 8'h44)// if "space" pressed
					next_state = crouch;
				else if (keycode == 8'h04)// if "A" pressed
					next_state = walk_l;
				else if (keycode == 8'h07)// if "D" pressed
					next_state = walk_r;
				else
					next_state = idle;
			end
		walk_r:
			if (keycode == 8'h00)// if nothing pressed
				next_state = idle;
		walk_l:
			if (keycode == 8'h00)// if nothing pressed
				next_state = idle;
		crouch:
			begin
				if (keycode == 8'h44)// if "SPACE" is not released
					next_state = crouch;
				else if (keycode == 8'h00) // if neither "A" or "D" are pressed on release of "SPACE"
					next_state = jump;
				else if (keycode == 8'h04)// if "A" is pressed on release of "SPACE"
					next_state = jump_l;
				else if (keycode == 8'h07) // if "D" is pressed on release of "SPACE'
					next_state = jump_r;
				else	
					next_state = crouch;
			end
		jump:// after jump return to idle
			next_state = idle;
		jump_l:// after jump return to idle
			next_state = idle;
		jump_r:// after jump return to idle
			next_state = idle;
	endcase

unique case (state)
	idle:
		begin
			Char_X_Motion = 0;
			Char_Y_Motion = 0;
			space_en = 0;
			jump_en = 0;
			RESET = 1;
		end
	walk_r:
		begin
			Char_X_Motion = 1;
			Char_Y_Motion = 0;
			space_en = 0;
			jump_en = 0;
		end
	walk_l:
		begin
			Char_X_Motion = -1;
			Char_Y_Motion = 0;
			space_en = 0;
			jump_en = 0;
		end
	crouch:
		begin
			Char_X_Motion = 0;
			Char_Y_Motion = 0;
			space_en = 1;
			jump_en = 0;
		end
	jump:
		begin
			Char_X_Motion = 0;
			Char_Y_Motion = 2 - (1*j_count);
			space_en = 0;
			jump_en = 1;
			RESET = 1;
		end
	jump_l:
		begin
			Char_X_Motion = -1;
			Char_Y_Motion = 2 - (1*j_count);
			space_en = 0;
			jump_en = 1;
			RESET = 1;
		end
	jump_r:
		begin
			Char_X_Motion = 1;
			Char_Y_Motion = 2 - (1*j_count);
			space_en = 0;
			jump_en = 1;
			RESET = 1;
		end
endcase
end
endmodule
														