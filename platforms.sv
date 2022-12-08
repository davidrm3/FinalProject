//reference

//((Char_X_Pos + Char_Size) >= Char_X_Max) //checks to see if char touches right side
//((Char_X_Pos - Char_Size) <= Char_X_Min) //checks to see if char touches left side 
//((Char_Y_Pos + Char_Size) >= (Char_Y_Max)) //checks to see if char touches the bottom
//((Char_Y_Pos - Char_Size) <= Char_Y_Min ) //checks to see if char touches the top

module first_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size,
						  output top_collide, bottom_collide, right_collide, left_collide
);

//bottom_platform
always_comb //touching top edge of bottom platform
	begin
		if ((Char_Y_Pos + Char_Size) >= 407) 
			begin
				bottom_collide = 1;
			end
		else
			begin
				bottom_collide = 0;
			end
	end

//left_platform
always_comb //character touches right edge of left platform
	begin
		if (((Char_X_Pos - Char_Size) <= 210) && 
			((Char_Y_Pos + Char_Size) > 240) && 
			((Char_Y_Pos - Char_Size) < 407))
			 begin
				left_collide = 1;
			 end
		else
			begin
				left_collide = 0;
			end
	end
always_comb
	begin //character touches top edge of left platform
		if (((Char_Y_Pos + Char_Size) >= 240) &&
			((Char_X_Pos + Char_Size) > 110) &&
			((Char_X_Pos - Char_Size) < 210))
			begin
				top_collide = 1;
			end
		else
			begin
				top_collide = 1;
			end
	end
	
//right_platform
always_comb //character touches left edge of right platform
	begin
		if (((Char_X_Pos + Char_Size) >= 432) && 
			((Char_Y_Pos + Char_Size) > 240) && 
			((Char_Y_Pos - Char_Size) < 407))
			 begin
				right_collide = 1;
			 end
		else
			begin
				right_collide = 0;
			end
	end
always_comb
	begin //character touches top edge of right platform
		if (((Char_Y_Pos + Char_Size) >= 240) &&
			((Char_X_Pos + Char_Size) > 432) &&
			((Char_X_Pos - Char_Size) < 533))
			begin
				top_collide = 1;
			end
		else
			begin
				top_collide = 1;
			end
	end

//floating_platform
	
endmodule

//module second_screen(
//);
//
//endmodule
//
//module third_screen(
//);
//
//endmodule
//
//module fourth_screen(
//);
//
//endmodule