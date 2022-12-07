module  character ( input Reset, frame_clk, CLK,
					input [7:0] keycode0, keycode1,
               output [9:0]  CharX, CharY, CharS,
					output [3:0] HEXstate,test,
					output logic [31:0] space_count,j_count, arc_count);
    
    logic [9:0] Char_X_Pos, Char_X_Motion, Char_Y_Pos, Char_Y_Motion, Char_Size;
	 logic space_reset,space_en,jump_reset,jump_en, arc_reset, arc_en;
	 logic right_collide , left_collide, top_collide, bottom_collide, diagonal_collide;
	 logic [3:0] screen_tracker;
	 
	 // Character starting point for each screen
    parameter [9:0] Char_X_Start=320;  // Center position on the X axis
    parameter [9:0] Char_Y_Start=410;  // Center position on the Y axis	 
	 
	 // Jump value
	 
	 //Character shape
	 assign Char_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
    parameter [9:0] Char_X_Min=110;       // Leftmost point on the X axis
    parameter [9:0] Char_X_Max=432;     // Rightmost point on the X axis
    parameter [9:0] Char_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Char_Y_Max=479;     // Bottommost point on the Y axis originally 479
	 
	 //Character step size
    parameter [9:0] Char_X_Step=1;      // Step size on the X axis
    parameter [9:0] Char_Y_Step=1;      // Step size on the Y axis
	 
	//Various counters						
	counter space_counter(.RESET(count_reset), .CLK(frame_clk), .enable (space_en), .max(15), .multi(3), .sec(space_count));
	counter jump_counter(.RESET(count_reset), .CLK(frame_clk), .enable(jump_en), .max(15), .multi(1), .sec(j_count));	 
	counter arc(.RESET(count_reset), .CLK(frame_clk), .enable(arc_en), .max(6), .multi(15), .sec(arc_count));
//	counter wind_counter(.RESET(), .CLK(), .enable(), .max(5), .multi(60), .sec(wind_count))
   
	//screen change mechanic
//	always_comb
//		begin
//			if //character touches top of screen
//				begin
//					screen_tracker = screen_tracker + 1;
//				end
//			if else //character touches bottom of screen
//				begin
//					screen_tracker = screen_tracker - 1;
//				end
//			else //character in the middle of the screen
//				begin
//					screen_tracker = screen_tracker;
//				end
//		end
	
	first_screen screen1(.Char_X_Pos(Char_X_Pos),
								.Char_Y_Pos(Char_Y_Pos),
								.Char_Size(Char_Size),
								
								.left_collide(left_collide),
								.right_collide(right_collide),
								.bottom_collide(bottom_collide),);
	
	//collsion calculation
//	 always_comb
//	 begin
//		if ((left_collide1 && (screen_tracker == 1)) //checks to see if char touches left side 
//			begin
//			left_collide = 1;
//			right_collide = 0;
//			bottom_collide = 0;
//			top_collide = 0;
//			test = 4'b0001;
//			end
//		else if ((Char_X_Pos + Char_Size) >= Char_X_Max) //checks to see if char touches right side
//			begin
//			left_collide = 0;
//			right_collide = 1;
//			bottom_collide = 0;
//			top_collide = 0;
//			test = 4'b0010;				
//			end
//		else if ((Char_Y_Pos + Char_Size) >= (Char_Y_Max)) //checks to see if char touches the bottom 
//			begin
//			left_collide = 0;
//			right_collide = 0;
//			bottom_collide = 1;
//			top_collide = 0;
//			test = 4'b0000;
//			end
//		else if ((Char_Y_Pos - Char_Size) <= Char_Y_Min ) //checks to see if char touches the top
//			begin
//			left_collide = 0;
//			right_collide = 0;
//			bottom_collide = 0;
//			top_collide = 1;
//			test = 4'b0010;
//			end
//		else
//			begin
//			left_collide = 0;
//			right_collide = 0;
//			bottom_collide = 0;
//			top_collide = 0;
//			test = 4'b0000;
//			end
//	 end
	
	char_controller state_machine(.keycode0(keycode0),
											.keycode1(keycode1),
											
											.CLK(frame_clk),
											
											.space_count(space_count),
											.j_count(j_count),
											.arc_count(arc_count),
											
											.left_collide(left_collide),
											.right_collide(right_collide),
											.bottom_collide(bottom_collide),
													
											.reset(Reset),
											.Char_Size(Char_Size),
											.count_reset(count_reset),
											
											.Char_X_Motion(Char_X_Motion), 
											.Char_Y_Motion(Char_Y_Motion),
											.Char_X_Pos(Char_X_Pos),
											.Char_Y_Pos(Char_Y_Pos),
											
											.space_en(space_en), 
											.jump_en(jump_en),
											.arc_en(arc_en),
										
											.HEXstate(HEXstate),
											); //controls character motion based off input
								
	assign CharX = Char_X_Pos;

	assign CharY = Char_Y_Pos;

	assign CharS = Char_Size;
 

endmodule
