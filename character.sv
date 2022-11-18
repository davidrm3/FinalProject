module  character ( input Reset, frame_clk, CLK,
					input [7:0] keycode0, keycode1,
               output [9:0]  CharX, CharY, CharS );
    
    logic [9:0] Char_X_Pos, Char_X_Motion, Char_Y_Pos, Char_Y_Motion, Char_Size;
	 logic space_reset,space_en,jump_reset,jump_en;
	 logic [31:0] space_count,j_count;
	 
	 // Character starting point for each screen
    parameter [9:0] Char_X_Start=320;  // Center position on the X axis
    parameter [9:0] Char_Y_Start=240;  // Center position on the Y axis	 
	 
	 // Jump value
	 
	 //Character shape
	 assign Char_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
    parameter [9:0] Char_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Char_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Char_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Char_Y_Max=479;     // Bottommost point on the Y axis
	 
	 //Character step size
    parameter [9:0] Char_X_Step=1;      // Step size on the X axis
    parameter [9:0] Char_Y_Step=1;      // Step size on the Y axis
	 
	// Module instantiation
							
	counter space_counter(.RESET(count_reset), .CLK(CLK), .count_en(space_en), .count(space_count));
	counter jump_counter(.RESET(count_reset), .CLK(CLK), .count_en(jump_en), .count(j_count));	 
   
	char_controller state_machine(.keycode0(keycode0),
											.keycode1(keycode1),
											.CLK(frame_clk),
											.space_count(space_count),
											.j_count(j_count),
											.Char_Y_Min(Char_Y_MIN),
											.Char_Y_Max(Char_Y_Max),
											.reset(Reset),
											.Char_Size(Char_Size),
											.count_reset(count_reset),
											.Char_X_Motion(Char_X_Motion), 
											.Char_Y_Motion(Char_Y_Motion),
											.Char_X_Pos(Char_X_Pos),
											.Char_Y_Pos(Char_Y_Pos),
											.space_en(space_en), 
											.jump_en(jump_en), 
											); //controls character motion based off input
								
	assign CharX = Char_X_Pos;

	assign CharY = Char_Y_Pos;

	assign CharS = Char_Size;
 

endmodule
