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
		if ((Char_Y_Pos - Char_Size - 5) <= 3) //character touches top of the screen
			begin
				ts_collide = 1;
			end
		else
			begin
				ts_collide = 0;
			end
	end

always_comb
	begin
		if ((Char_Y_Pos + Char_Size + 5) >= 476) //character touches bottom of the screen
			begin
				bs_collide = 1;
			end
		else
			begin
				bs_collide = 0;
			end
	end

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************** screen 1 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////

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
			((Char_Y_Pos - Char_Size - 5) <= 105) &&
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

always_comb //any collision with a ceiling
	begin
		if (((Char_Y_Pos - Char_Size - 5) <= 130) && //character touches bottom edge of top platform
			((Char_Y_Pos + Char_Size + 5) > 106) &&
			((Char_X_Pos + Char_Size) > 265) &&
			((Char_X_Pos - Char_Size) < 378))
			begin
				top_collide = 1;
			end
		else
			begin
				top_collide = 0;
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

////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************** screen 2 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////


module second_screen(
);
//any collision with a floor
always_comb 
	begin
		if ((((Char_Y_Pos + Char_Size + 5) >= 370) && //character touches top edge of first platform
			((Char_Y_Pos - Char_Size - 5) <= 398)
			((Char_X_Pos + Char_Size) > 375) &&
			((Char_X_Pos - Char_Size) < 473)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 260) && //character touches top edge of second platform
			((Char_Y_Pos - Char_Size - 5) <= 280)
			((Char_X_Pos + Char_Size) > 490) && 
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 260) && //character touches top edge of third platform
			((Char_Y_Pos - Char_Size - 5) <= 280)
			((Char_X_Pos + Char_Size) > 338) && 
			((Char_X_Pos - Char_Size) < 410)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 152) && //character touches top edge of fourth platform
			((Char_Y_Pos - Char_Size - 5) <= 190)
			((Char_X_Pos + Char_Size) > 200) && 
			((Char_X_Pos - Char_Size) < 275)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 128) && //character touches top edge of fifth platform
			((Char_Y_Pos - Char_Size - 5) <= 175) &&
			((Char_X_Pos + Char_Size) > 110) && 
			((Char_X_Pos - Char_Size) < 170)))
			begin
				bottom_collide = 1;
			end
		else
			begin
				bottom_collide = 0;
			end
	end

always_comb //any collision with a ceiling
	begin
		if ((((Char_Y_Pos - Char_Size - 5) <= 406) && //character touches bottom edge of first platform
			((Char_Y_Pos + Char_Size + 5) > 399) &&
			((Char_X_Pos + Char_Size) > 375) &&
			((Char_X_Pos - Char_Size) < 473)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 303) && //character touches bottom edge of second platform
			((Char_Y_Pos + Char_Size + 5) > 281) &&
			((Char_X_Pos + Char_Size) > 490) &&
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 300) && //character touches bottom edge of third platform
			((Char_Y_Pos + Char_Size + 5) > 281) &&
			((Char_X_Pos + Char_Size) > 336) &&
			((Char_X_Pos - Char_Size) < 410)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 227) && //character touches bottom edge of fourth platform
			((Char_Y_Pos + Char_Size + 5) > 191) &&
			((Char_X_Pos + Char_Size) > 200) &&
			((Char_X_Pos - Char_Size) < 275)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 224) && //character touches bottom edge of fifth platform
			((Char_Y_Pos + Char_Size + 5) > 176) &&
			((Char_X_Pos + Char_Size) > 110) &&
			((Char_X_Pos - Char_Size) < 170)))
			begin
				top_collide = 1;
			end
		else
			begin
				top_collide = 0;
			end
	end

//any collision with a right edge
always_comb
	begin
		if (((Char_X_Pos - Char_Size ) <= 110) || // left side of screen
		
			(((Char_X_Pos - Char_Size - 2) <= 406) && //character touches right edge of first platform
			((Char_X_Pos + Char_Size - 2) >= 398) &&
			((Char_Y_Pos + Char_Size) > 375) && 
			((Char_Y_Pos - Char_Size) < 473)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 533) && //character touches right edge of second platform
			((Char_X_Pos + Char_Size - 2) >= 508) &&
			((Char_Y_Pos + Char_Size) > 260) && 
			((Char_Y_Pos - Char_Size) < 303)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 410) && //character touches right edge of third platform
			((Char_X_Pos + Char_Size - 2) >= 377) &&
			((Char_Y_Pos + Char_Size) > 260) && 
			((Char_Y_Pos - Char_Size) < 300)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 275) && //character touches right edge of fourth platform
			((Char_X_Pos + Char_Size - 2) >= 240) &&
			((Char_Y_Pos + Char_Size) > 152) && 
			((Char_Y_Pos - Char_Size) < 227)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 170) && //character touches right edge of fifth platform
			((Char_X_Pos + Char_Size - 2) >= 142) &&
			((Char_Y_Pos + Char_Size) > 128) && 
			((Char_Y_Pos - Char_Size) < 224)))
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
		if (((Char_X_Pos + Char_Size) >= 533) || //right side of screen
		
			(((Char_X_Pos + Char_Size + 2) >= 375) && //character touches left edge of first platform
			((Char_X_Pos - Char_Size + 2) <=423) &&
			((Char_Y_Pos + Char_Size) > 370) && 
			((Char_Y_Pos - Char_Size) < 406)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 490) && //character touches left edge of second platform
			((Char_X_Pos - Char_Size + 2) <=508) &&
			((Char_Y_Pos + Char_Size) > 260) && 
			((Char_Y_Pos - Char_Size) < 303)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 338) && //character touches left edge of third platform
			((Char_X_Pos - Char_Size + 2) <=377) &&
			((Char_Y_Pos + Char_Size) > 260) && 
			((Char_Y_Pos - Char_Size) < 300)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 200) && //character touches left edge of fourth platform
			((Char_X_Pos - Char_Size + 2) <=240) &&
			((Char_Y_Pos + Char_Size) > 152) && 
			((Char_Y_Pos - Char_Size) < 227)))
			 begin
				right_collide = 1;
			 end
		else
			begin
				right_collide = 0;
			end
	end

endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************** screen 3 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////

//module third_screen(
//);
//
//endmodule

////////////////////////////////////////////////////////////////////////////////////////////////////////
//************************************** screen 4 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////

//module fourth_screen(
//);
//
//endmodule