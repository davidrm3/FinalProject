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


module second_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
						  output logic top_collide, bottom_collide, right_collide, left_collide
);

//any collision with a floor
always_comb 
	begin
		if ((((Char_Y_Pos + Char_Size + 5) >= 370) && //character touches top edge of first platform
			((Char_Y_Pos - Char_Size - 5) <= 398) &&
			((Char_X_Pos + Char_Size) > 375) &&
			((Char_X_Pos - Char_Size) < 473)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 260) && //character touches top edge of second platform
			((Char_Y_Pos - Char_Size - 5) <= 280) &&
			((Char_X_Pos + Char_Size) > 490) && 
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 260) && //character touches top edge of third platform
			((Char_Y_Pos - Char_Size - 5) <= 280) &&
			((Char_X_Pos + Char_Size) > 338) && 
			((Char_X_Pos - Char_Size) < 410)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 152) && //character touches top edge of fourth platform
			((Char_Y_Pos - Char_Size - 5) <= 190) &&
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

module third_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
						  output logic top_collide, bottom_collide, right_collide, left_collide
);
//any collision with a floor
always_comb 
	begin
		if ((((Char_Y_Pos + Char_Size + 5) >= 380) && //character touches top edge of first platform
			((Char_Y_Pos - Char_Size - 5) <= 390) &&
			((Char_X_Pos + Char_Size) > 290) &&
			((Char_X_Pos - Char_Size) < 335)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 380) && //character touches top edge of second platform
			((Char_Y_Pos - Char_Size - 5) <= 390) &&
			((Char_X_Pos + Char_Size) > 403) && 
			((Char_X_Pos - Char_Size) < 457)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 330) && //character touches top edge of third platform
			((Char_Y_Pos - Char_Size - 5) <= 335) &&
			((Char_X_Pos + Char_Size) > 504) && 
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 266) && //character touches top edge of fourth platform
			((Char_Y_Pos - Char_Size - 5) <= 295) &&
			((Char_X_Pos + Char_Size) > 370) && 
			((Char_X_Pos - Char_Size) < 415)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 289) && //character touches top edge of fifth platform
			((Char_Y_Pos - Char_Size - 5) <= 306) &&
			((Char_X_Pos + Char_Size) > 270) && 
			((Char_X_Pos - Char_Size) < 370)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 170) && //character touches top edge of sixth platform
			((Char_Y_Pos - Char_Size - 5) <= 197) &&
			((Char_X_Pos + Char_Size) > 240) && 
			((Char_X_Pos - Char_Size) < 298)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 148) && //character touches top edge of seventh platform
			((Char_Y_Pos - Char_Size - 5) <= 168) &&
			((Char_X_Pos + Char_Size) > 110) && 
			((Char_X_Pos - Char_Size) < 148)))
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
		if ((((Char_Y_Pos - Char_Size - 5) <= 398) && //character touches bottom edge of first platform
			((Char_Y_Pos + Char_Size + 5) > 290) &&
			((Char_X_Pos + Char_Size) > 290) &&
			((Char_X_Pos - Char_Size) < 225)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 398) && //character touches bottom edge of second platform
			((Char_Y_Pos + Char_Size + 5) > 290) &&
			((Char_X_Pos + Char_Size) > 403) &&
			((Char_X_Pos - Char_Size) < 457)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 342) && //character touches bottom edge of third platform
			((Char_Y_Pos + Char_Size + 5) > 336) &&
			((Char_X_Pos + Char_Size) > 504) &&
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 324) && //character touches bottom edge of fourth platform
			((Char_Y_Pos + Char_Size + 5) > 306) &&
			((Char_X_Pos + Char_Size) > 270) &&
			((Char_X_Pos - Char_Size) < 324)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 225) && //character touches bottom edge of fifth platform
			((Char_Y_Pos + Char_Size + 5) > 198) &&
			((Char_X_Pos + Char_Size) > 240) &&
			((Char_X_Pos - Char_Size) < 298)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 168) && //character touches bottom edge of sixth platform
			((Char_Y_Pos + Char_Size + 5) > 158) &&
			((Char_X_Pos + Char_Size) > 110) &&
			((Char_X_Pos - Char_Size) < 151)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 56) && //character touches bottom edge of seventh platform
			((Char_Y_Pos + Char_Size + 5) > 0) &&
			((Char_X_Pos + Char_Size) > 210) &&
			((Char_X_Pos - Char_Size) < 288)))
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
		
			(((Char_X_Pos - Char_Size - 2) <= 335) && //character touches right edge of first platform
			((Char_X_Pos + Char_Size - 2) >= 312) &&
			((Char_Y_Pos + Char_Size) > 380) && 
			((Char_Y_Pos - Char_Size) < 398)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 457) && //character touches right edge of second platform
			((Char_X_Pos + Char_Size - 2) >= 430) &&
			((Char_Y_Pos + Char_Size) > 380) && 
			((Char_Y_Pos - Char_Size) < 398)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 415) && //character touches right edge of third platform
			((Char_X_Pos + Char_Size - 2) >= 390) &&
			((Char_Y_Pos + Char_Size) > 266) && 
			((Char_Y_Pos - Char_Size) < 324)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 298) && //character touches right edge of fourth platform
			((Char_X_Pos + Char_Size - 2) >= 269) &&
			((Char_Y_Pos + Char_Size) > 170) && 
			((Char_Y_Pos - Char_Size) < 225)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 151) && //character touches right edge of fifth platform
			((Char_X_Pos + Char_Size - 2) >= 110) &&
			((Char_Y_Pos + Char_Size) > 148) && 
			((Char_Y_Pos - Char_Size) < 168)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 288) && //character touches right edge of sixth platform
			((Char_X_Pos + Char_Size - 2) >= 253) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 56)))
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
		
			(((Char_X_Pos + Char_Size + 2) >= 290) && //character touches left edge of first platform
			((Char_X_Pos - Char_Size + 2) <= 312) &&
			((Char_Y_Pos + Char_Size) > 380) && 
			((Char_Y_Pos - Char_Size) < 398)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 403) && //character touches left edge of second platform
			((Char_X_Pos - Char_Size + 2) <= 430) &&
			((Char_Y_Pos + Char_Size) > 380) && 
			((Char_Y_Pos - Char_Size) < 398)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 504) && //character touches left edge of third platform
			((Char_X_Pos - Char_Size + 2) <= 533) &&
			((Char_Y_Pos + Char_Size) > 330) && 
			((Char_Y_Pos - Char_Size) < 342)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 365) && //character touches left edge of fourth platform
			((Char_X_Pos - Char_Size + 2) <= 390) &&
			((Char_Y_Pos + Char_Size) > 266) && 
			((Char_Y_Pos - Char_Size) < 289)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 270) && //character touches left edge of fifth platform
			((Char_X_Pos - Char_Size + 2) <= 320) &&
			((Char_Y_Pos + Char_Size) > 289) && 
			((Char_Y_Pos - Char_Size) < 324)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 240) && //character touches left edge of sixth platform
			((Char_X_Pos - Char_Size + 2) <= 269) &&
			((Char_Y_Pos + Char_Size) > 170) && 
			((Char_Y_Pos - Char_Size) < 225)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 218) && //character touches left edge of seventh platform
			((Char_X_Pos - Char_Size + 2) <= 253) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 56)))
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
//************************************** screen 4 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////

module fourth_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
						  output logic top_collide, bottom_collide, right_collide, left_collide
);

//any collision with a floor
always_comb 
	begin
		if ((((Char_Y_Pos + Char_Size + 5) >= 400) && //character touches top edge of first platform
			((Char_Y_Pos - Char_Size - 5) <= 480) &&
			((Char_X_Pos + Char_Size) > 215) &&
			((Char_X_Pos - Char_Size) < 288)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 280) && //character touches top edge of second platform
			((Char_Y_Pos - Char_Size - 5) <= 295) &&
			((Char_X_Pos + Char_Size) > 110) && 
			((Char_X_Pos - Char_Size) < 170)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 280) && //character touches top edge of third platform
			((Char_Y_Pos - Char_Size - 5) <= 295) &&
			((Char_X_Pos + Char_Size) > 220) && 
			((Char_X_Pos - Char_Size) < 300)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 200) && //character touches top edge of fourth platform
			((Char_Y_Pos - Char_Size - 5) <= 245) &&
			((Char_X_Pos + Char_Size) > 380) && 
			((Char_X_Pos - Char_Size) < 410)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 150) && //character touches top edge of fifth platform
			((Char_Y_Pos - Char_Size - 5) <= 220) &&
			((Char_X_Pos + Char_Size) > 410) && 
			((Char_X_Pos - Char_Size) < 430)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 130) && //character touches top edge of sixth platform
			((Char_Y_Pos - Char_Size - 5) <= 178) &&
			((Char_X_Pos + Char_Size) > 240) && 
			((Char_X_Pos - Char_Size) < 270)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 180) && //character touches top edge of seventh platform
			((Char_Y_Pos - Char_Size - 5) <= 190) &&
			((Char_X_Pos + Char_Size) > 500) && 
			((Char_X_Pos - Char_Size) < 533)))
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
		if ((((Char_Y_Pos - Char_Size - 5) <= 310) && //character touches bottom edge of first platform
			((Char_Y_Pos + Char_Size + 5) > 245) &&
			((Char_X_Pos + Char_Size) > 110) &&
			((Char_X_Pos - Char_Size) < 170)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 310) && //character touches bottom edge of second platform
			((Char_Y_Pos + Char_Size + 5) > 245) &&
			((Char_X_Pos + Char_Size) > 220) &&
			((Char_X_Pos - Char_Size) < 300)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 290) && //character touches bottom edge of third platform
			((Char_Y_Pos + Char_Size + 5) > 245) &&
			((Char_X_Pos + Char_Size) > 380) &&
			((Char_X_Pos - Char_Size) < 290)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 227) && //character touches bottom edge of fourth platform
			((Char_Y_Pos + Char_Size + 5) > 178) &&
			((Char_X_Pos + Char_Size) > 220) &&
			((Char_X_Pos - Char_Size) < 240)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 200) && //character touches bottom edge of fifth platform
			((Char_Y_Pos + Char_Size + 5) > 190) &&
			((Char_X_Pos + Char_Size) > 500) &&
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 80) && //character touches bottom edge of sixth platform
			((Char_Y_Pos + Char_Size + 5) > 32) &&
			((Char_X_Pos + Char_Size) > 410) &&
			((Char_X_Pos - Char_Size) < 430)))
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
		
			(((Char_X_Pos - Char_Size - 2) <= 288) && //character touches right edge of first platform
			((Char_X_Pos + Char_Size - 2) >= 251) &&
			((Char_Y_Pos + Char_Size) > 400) && 
			((Char_Y_Pos - Char_Size) < 480)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 170) && //character touches right edge of second platform
			((Char_X_Pos + Char_Size - 2) >= 110) &&
			((Char_Y_Pos + Char_Size) > 280) && 
			((Char_Y_Pos - Char_Size) < 310)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 300) && //character touches right edge of third platform
			((Char_X_Pos + Char_Size - 2) >= 260) &&
			((Char_Y_Pos + Char_Size) > 280) && 
			((Char_Y_Pos - Char_Size) < 310)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 430) && //character touches right edge of fourth platform
			((Char_X_Pos + Char_Size - 2) >= 420) &&
			((Char_Y_Pos + Char_Size) > 150) && 
			((Char_Y_Pos - Char_Size) < 298)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 270) && //character touches right edge of fifth platform
			((Char_X_Pos + Char_Size - 2) >= 255) &&
			((Char_Y_Pos + Char_Size) > 130) && 
			((Char_Y_Pos - Char_Size) < 227)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 240) && //character touches right edge of sixth platform
			((Char_X_Pos + Char_Size - 2) >= 230) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 227)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 430) && //character touches right edge of seventh platform
			((Char_X_Pos + Char_Size - 2) >= 420) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 80)))
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
		
			(((Char_X_Pos + Char_Size + 2) >= 215) && //character touches left edge of first platform
			((Char_X_Pos - Char_Size + 2) <=503) &&
			((Char_Y_Pos + Char_Size) > 400) && 
			((Char_Y_Pos - Char_Size) < 480)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 220) && //character touches left edge of second platform
			((Char_X_Pos - Char_Size + 2) <=260) &&
			((Char_Y_Pos + Char_Size) > 280) && 
			((Char_Y_Pos - Char_Size) < 310)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 380) && //character touches left edge of third platform
			((Char_X_Pos - Char_Size + 2) <=395) &&
			((Char_Y_Pos + Char_Size) > 200) && 
			((Char_Y_Pos - Char_Size) < 290)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 410) && //character touches left edge of fourth platform
			((Char_X_Pos - Char_Size + 2) <=420) &&
			((Char_Y_Pos + Char_Size) > 150) && 
			((Char_Y_Pos - Char_Size) < 290)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 220) && //character touches left edge of fifth platform
			((Char_X_Pos - Char_Size + 2) <=230) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 227)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 410) && //character touches left edge of sixth platform
			((Char_X_Pos - Char_Size + 2) <=420) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 80)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 500) && //character touches left edge of seventh platform
			((Char_X_Pos - Char_Size + 2) <=533) &&
			((Char_Y_Pos + Char_Size) > 180) && 
			((Char_Y_Pos - Char_Size) < 200)))
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
//************************************** screen 5 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////

module fifth_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
						  output logic top_collide, bottom_collide, right_collide, left_collide
);

//any collision with a floor
always_comb 
	begin
		if ((((Char_Y_Pos + Char_Size + 5) >= 390) && //character touches top edge of first platform
			((Char_Y_Pos - Char_Size - 5) <= 480) &&
			((Char_X_Pos + Char_Size) > 200) &&
			((Char_X_Pos - Char_Size) < 240)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 390) && //character touches top edge of second platform
			((Char_Y_Pos - Char_Size - 5) <= 480) &&
			((Char_X_Pos + Char_Size) > 410) && 
			((Char_X_Pos - Char_Size) < 450)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 310) && //character touches top edge of third platform
			((Char_Y_Pos - Char_Size - 5) <= 320) &&
			((Char_X_Pos + Char_Size) > 410) && 
			((Char_X_Pos - Char_Size) < 450)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 330) && //character touches top edge of fourth platform
			((Char_Y_Pos - Char_Size - 5) <= 345) &&
			((Char_X_Pos + Char_Size) > 110) && 
			((Char_X_Pos - Char_Size) < 140)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 220) && //character touches top edge of fifth platform
			((Char_Y_Pos - Char_Size - 5) <= 235) &&
			((Char_X_Pos + Char_Size) > 513) && 
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 133) && //character touches top edge of sixth platform
			((Char_Y_Pos - Char_Size - 5) <= 148) &&
			((Char_X_Pos + Char_Size) > 373) && 
			((Char_X_Pos - Char_Size) < 406)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 112) && //character touches top edge of seventh platform
			((Char_Y_Pos - Char_Size - 5) <= 127) &&
			((Char_X_Pos + Char_Size) > 303) && 
			((Char_X_Pos - Char_Size) < 336)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 100) && //character touches top edge of eighth platform
			((Char_Y_Pos - Char_Size - 5) <= 115) &&
			((Char_X_Pos + Char_Size) > 242) && 
			((Char_X_Pos - Char_Size) < 275)) ||
			
			(((Char_Y_Pos + Char_Size + 5) >= 130) && //character touches top edge of ninth platform
			((Char_Y_Pos - Char_Size - 5) <= 145) &&
			((Char_X_Pos + Char_Size) > 120) && 
			((Char_X_Pos - Char_Size) < 160)))
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
		if ((((Char_Y_Pos - Char_Size - 5) <= 330) && //character touches bottom edge of first platform
			((Char_Y_Pos + Char_Size + 5) > 320) &&
			((Char_X_Pos + Char_Size) > 410) &&
			((Char_X_Pos - Char_Size) < 450)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 360) && //character touches bottom edge of second platform
			((Char_Y_Pos + Char_Size + 5) > 345) &&
			((Char_X_Pos + Char_Size) > 110) &&
			((Char_X_Pos - Char_Size) < 140)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 250) && //character touches bottom edge of third platform
			((Char_Y_Pos + Char_Size + 5) > 235) &&
			((Char_X_Pos + Char_Size) > 513) &&
			((Char_X_Pos - Char_Size) < 533)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 163) && //character touches bottom edge of fourth platform
			((Char_Y_Pos + Char_Size + 5) > 148) &&
			((Char_X_Pos + Char_Size) > 373) &&
			((Char_X_Pos - Char_Size) < 406)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 142) && //character touches bottom edge of fifth platform
			((Char_Y_Pos + Char_Size + 5) > 127) &&
			((Char_X_Pos + Char_Size) > 303) &&
			((Char_X_Pos - Char_Size) < 336)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 130) && //character touches bottom edge of sixth platform
			((Char_Y_Pos + Char_Size + 5) > 115) &&
			((Char_X_Pos + Char_Size) > 242) &&
			((Char_X_Pos - Char_Size) < 275)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 160) && //character touches bottom edge of seventh platform
			((Char_Y_Pos + Char_Size + 5) > 145) &&
			((Char_X_Pos + Char_Size) > 120) &&
			((Char_X_Pos - Char_Size) < 160)) ||
			
			(((Char_Y_Pos - Char_Size - 5) <= 56) && //character touches bottom edge of eighth platform
			((Char_Y_Pos + Char_Size + 5) > 32) &&
			((Char_X_Pos + Char_Size) > 230) &&
			((Char_X_Pos - Char_Size) < 440)))
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
		
			(((Char_X_Pos - Char_Size - 2) <= 240) && //character touches right edge of first platform
			((Char_X_Pos + Char_Size - 2) >= 220) &&
			((Char_Y_Pos + Char_Size) > 390) && 
			((Char_Y_Pos - Char_Size) < 480)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 450) && //character touches right edge of second platform
			((Char_X_Pos + Char_Size - 2) >= 430) &&
			((Char_Y_Pos + Char_Size) > 390) && 
			((Char_Y_Pos - Char_Size) < 480)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 310) && //character touches right edge of third platform
			((Char_X_Pos + Char_Size - 2) >= 430) &&
			((Char_Y_Pos + Char_Size) > 310) && 
			((Char_Y_Pos - Char_Size) < 330)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 406) && //character touches right edge of fourth platform
			((Char_X_Pos + Char_Size - 2) >= 390) &&
			((Char_Y_Pos + Char_Size) > 133) && 
			((Char_Y_Pos - Char_Size) < 163)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 336) && //character touches right edge of fifth platform
			((Char_X_Pos + Char_Size - 2) >= 320) &&
			((Char_Y_Pos + Char_Size) > 112) && 
			((Char_Y_Pos - Char_Size) < 142)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 275) && //character touches right edge of sixth platform
			((Char_X_Pos + Char_Size - 2) >= 259) &&
			((Char_Y_Pos + Char_Size) > 100) && 
			((Char_Y_Pos - Char_Size) < 130)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 160) && //character touches right edge of seventh platform
			((Char_X_Pos + Char_Size - 2) >= 140) &&
			((Char_Y_Pos + Char_Size) > 130) && 
			((Char_Y_Pos - Char_Size) < 160)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 140) && //character touches right edge of eighth platform
			((Char_X_Pos + Char_Size - 2) >= 125) &&
			((Char_Y_Pos + Char_Size) > 330) && 
			((Char_Y_Pos - Char_Size) < 360)) ||
			
			(((Char_X_Pos - Char_Size - 2) <= 440) && //character touches right edge of ninth platform
			((Char_X_Pos + Char_Size - 2) >= 335) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 56)))
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
		
			(((Char_X_Pos + Char_Size + 2) >= 200) && //character touches left edge of first platform
			((Char_X_Pos - Char_Size + 2) <=220) &&
			((Char_Y_Pos + Char_Size) > 390) && 
			((Char_Y_Pos - Char_Size) < 480)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 410) && //character touches left edge of second platform
			((Char_X_Pos - Char_Size + 2) <=430) &&
			((Char_Y_Pos + Char_Size) > 390) && 
			((Char_Y_Pos - Char_Size) < 480)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 410) && //character touches left edge of third platform
			((Char_X_Pos - Char_Size + 2) <=430) &&
			((Char_Y_Pos + Char_Size) > 310) && 
			((Char_Y_Pos - Char_Size) < 330)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 513) && //character touches left edge of fourth platform
			((Char_X_Pos - Char_Size + 2) <=533) &&
			((Char_Y_Pos + Char_Size) > 220) && 
			((Char_Y_Pos - Char_Size) < 250)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 373) && //character touches left edge of fifth platform
			((Char_X_Pos - Char_Size + 2) <=389) &&
			((Char_Y_Pos + Char_Size) > 133) && 
			((Char_Y_Pos - Char_Size) < 163)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 303) && //character touches left edge of sixth platform
			((Char_X_Pos - Char_Size + 2) <=319) &&
			((Char_Y_Pos + Char_Size) > 112) && 
			((Char_Y_Pos - Char_Size) < 142)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 242) && //character touches left edge of seventh platform
			((Char_X_Pos - Char_Size + 2) <=258) &&
			((Char_Y_Pos + Char_Size) > 100) && 
			((Char_Y_Pos - Char_Size) < 130)) ||
			
			(((Char_X_Pos + Char_Size + 2) >= 120) && //character touches left edge of eighth platform
			((Char_X_Pos - Char_Size + 2) <=140) &&
			((Char_Y_Pos + Char_Size) > 130) && 
			((Char_Y_Pos - Char_Size) < 160)) || 
			
			(((Char_X_Pos + Char_Size + 2) >= 230) && //character touches left edge of eighth platform
			((Char_X_Pos - Char_Size + 2) <=335) &&
			((Char_Y_Pos + Char_Size) > 32) && 
			((Char_Y_Pos - Char_Size) < 56)))
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
//************************************** screen 6 ****************************************************//
////////////////////////////////////////////////////////////////////////////////////////////////////////

module sixth_screen(input logic [9:0] Char_X_Pos, Char_Y_Pos, Char_Size, Char_X_Motion, Char_Y_Motion,
						  output logic top_collide, bottom_collide, right_collide, left_collide
);

//any collision with a floor
always_comb 
	begin
		if ((((Char_Y_Pos + Char_Size + 5) >= 420) && //character touches top edge of first platform
			((Char_Y_Pos - Char_Size - 5) <= 480) &&
			((Char_X_Pos + Char_Size) > 230) &&
			((Char_X_Pos - Char_Size) < 400)))
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
		if (((Char_X_Pos - Char_Size ) <= 110) || // left side of screen
		
			(((Char_X_Pos - Char_Size - 2) <= 400) && //character touches right edge of first platform
			((Char_X_Pos + Char_Size - 2) >= 315) &&
			((Char_Y_Pos + Char_Size) > 420) && 
			((Char_Y_Pos - Char_Size) < 480)))
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
		
			(((Char_X_Pos + Char_Size + 2) >= 230) && //character touches left edge of first platform
			((Char_X_Pos - Char_Size + 2) <=315) &&
			((Char_Y_Pos + Char_Size) > 420) && 
			((Char_Y_Pos - Char_Size) < 480)))
			 begin
				right_collide = 1;
			 end
		else
			begin
				right_collide = 0;
			end
	end

endmodule 