module  character ( input Reset, frame_clk, CLK,
					input [7:0] keycode0, keycode1,
					output ts_collide, bs_collide,
               output [9:0]  CharX, CharY, CharS,
					output [3:0] test0, test1, test2, test3);
    
	 logic [31:0] space_count,j_count, arc_count, fall_count;
    logic [9:0] Char_X_Pos, Char_X_Motion, Char_Y_Pos, Char_Y_Motion, Char_Size;
	 logic space_reset,space_en,jump_reset,jump_en, arc_reset, arc_en, fall_en;
	 logic right_collide , left_collide, top_collide, bottom_collide, diagonal_collide;
	 logic [3:0] screen_tracker, HEXstate;
	 
	 // Character starting point for each screen
    parameter [9:0] Char_X_Start=320;  // Center position on the X axis
    parameter [9:0] Char_Y_Start=410;  // Center position on the Y axis	 
	 
	 // Jump value
	 
	 //Character shape
	 assign Char_Size = 15;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
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
	counter fall_arc(.RESET(count_reset), .CLK(frame_clk), .enable(fall_en), .max(3), .multi(15), .sec(fall_count));
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
					
								.Char_X_Motion(Char_X_Motion), 
								.Char_Y_Motion(Char_Y_Motion),
								
								.left_collide(left_collide),
								.right_collide(right_collide),
								.bottom_collide(bottom_collide),);
								
	touch_tb edges(.Char_X_Pos(Char_X_Pos),
						.Char_Y_Pos(Char_Y_Pos),
						.Char_Size(Char_Size),
			
						.Char_X_Motion(Char_X_Motion), 
						.Char_Y_Motion(Char_Y_Motion),
						
						.ts_collide(ts_collide),
						.bs_collide(bs_collide)
						);
	always_comb
	begin
		test0 <= left_collide;
		test1 <= right_collide;
		test2 <= bottom_collide;
		test3 <= HEXstate;
	end
	
	char_controller state_machine(.keycode0(keycode0),
											.keycode1(keycode1),
											
											.CLK(frame_clk),
											
											.space_count(space_count),
											.j_count(j_count),
											.arc_count(arc_count),
											.fall_count(fall_count),
											
											.left_collide(left_collide),
											.right_collide(right_collide),
											.bottom_collide(bottom_collide),
											.ts_collide(ts_collide),
											.bs_collide(bs_collide),
													
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
											.fall_en(fall_en),
										
											.HEXstate(HEXstate),
											); //controls character motion based off input
								
	assign CharX = Char_X_Pos;

	assign CharY = Char_Y_Pos;

	assign CharS = Char_Size;
 

endmodule
