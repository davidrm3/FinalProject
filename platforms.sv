//reference

//((Char_X_Pos + Char_Size) >= Char_X_Max) //checks to see if char touches right side
//((Char_X_Pos - Char_Size) <= Char_X_Min) //checks to see if char touches left side 
//((Char_Y_Pos + Char_Size) >= (Char_Y_Max)) //checks to see if char touches the bottom
//((Char_Y_Pos - Char_Size) <= Char_Y_Min ) //checks to see if char touches the top

module touch_tb(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
					 output logic ts_collide, bs_collide
);

always_comb
	begin
		if (Char_Y_Pos - Char_Size - 5) <= 5) //character touches top of the screen
			begin
				ts_collide = 1;
			end
		else
			begin
				ts_collide = 0;
			end
	end
end

always_comb
	begin
		if (Char_Y_Pos + Char_Size + 5) >= 470) //character touches bottom of the screen
			begin
				bs_collide = 1;
			end
		else
			begin
				bs_collide = 0;
			end
	end
end

endmodule



module first_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
						  output logic top_collide, bottom_collide, right_collide, left_collide
);
//any collision with a floor
always_comb 
	begin
		if (((Char_Y_Pos + Char_Size + 5) >= 407) || //touching top edge of bottom platform
		
			(((Char_Y_Pos + Char_Size + 5) >= 240) && //character touches top edge of left platform
			((Char_X_Pos + Char_Size) > 110) &&
			((Char_X_Pos - Char_Size) < 210)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 240) && //character touches top edge of right platform
			((Char_X_Pos + Char_Size) > 432) && 
			((Char_X_Pos - Char_Size) < 532)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 80) && //character touches top edge of top platform
			((Char_Y_Pos - Char_Size - 5) <= 130) &&
			((Char_X_Pos + Char_Size) > 265) && 
			((Char_X_Pos - Char_Size) < 378)))
			begin
				bottom_collide = 1;
			end
		else
			begin
				bottom_collide = 0;
			end
	end

//any collision with a right edge
always_comb
	begin
		if (((Char_X_Pos - Char_Size -2) <= 210) && 
			((Char_Y_Pos + Char_Size) > 240) && 
			((Char_Y_Pos - Char_Size) < 407) ||
			
			((Char_X_Pos - Char_Size ) <= 110) ||
			
			((Char_X_Pos - Char_Size - 2) <= 378) && 
			((Char_X_Pos + Char_Size - 2) >= 321) &&
			((Char_Y_Pos + Char_Size) > 80) && 
			((Char_Y_Pos - Char_Size) < 130))
			 begin
				left_collide = 1;
			 end
		else
			begin
				left_collide = 0;
			end
	end
	
//any collision with a left edge
always_comb 
	begin
		if (((Char_X_Pos + Char_Size + 2) >= 432) && 
			((Char_Y_Pos + Char_Size) > 240) && 
			((Char_Y_Pos - Char_Size) < 407)||
			
			((Char_X_Pos + Char_Size) >= 533) ||
			
			((Char_X_Pos + Char_Size + 2) >= 265) && 
			((Char_X_Pos - Char_Size + 2) <=320) &&
			((Char_Y_Pos + Char_Size) > 80) && 
			((Char_Y_Pos - Char_Size) < 130))
			 begin
				right_collide = 1;
			 end
		else
			begin
				right_collide = 0;
			end
	end

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