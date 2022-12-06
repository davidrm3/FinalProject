module  character ( input Reset, frame_clk, CLK,
					input [7:0] keycode0, keycode1,
               output [9:0]  CharX, CharY, CharS,
					output [3:0] HEXstate,
					output logic [31:0] space_count,j_count, arc_count);
    
    logic [9:0] Char_X_Pos, Char_X_Motion, Char_Y_Pos, Char_Y_Motion, Char_Size;
	 logic space_reset,space_en,jump_reset,jump_en, arc_reset, arc_en;
	 
	 
	 // Character starting point for each screen
    parameter [9:0] Char_X_Start=320;  // Center position on the X axis
    parameter [9:0] Char_Y_Start=240;  // Center position on the Y axis	 
	 
	 // Jump value
	 
	 //Character shape
	 assign Char_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
    parameter [9:0] Char_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Char_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Char_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Char_Y_Max=300;     // Bottommost point on the Y axis originally 479
	 
	 //Character step size
    parameter [9:0] Char_X_Step=1;      // Step size on the X axis
    parameter [9:0] Char_Y_Step=1;      // Step size on the Y axis
	 
	// Module instantiation
							
	counter space_counter(.RESET(count_reset), .CLK(frame_clk), .enable (space_en), .max(35), .multi(15), .sec(space_count));
	counter jump_counter(.RESET(count_reset), .CLK(frame_clk), .enable(jump_en), .max(35), .multi(15), .sec(j_count));	 
	counter arc(.RESET(count_reset), .CLK(frame_clk), .enable(arc_en), .max(6), .multi(15), .sec(arc_count));	
   
	char_controller state_machine(.keycode0(keycode0),
											.keycode1(keycode1),
											
											.CLK(frame_clk),
											
											.space_count(space_count),
											.j_count(j_count),
											.arc_count(arc_count),
											
											.Char_Y_Min(Char_Y_Min),
											.Char_Y_Max(Char_Y_Max),
											.Char_X_Min(Char_X_Min),
											.Char_X_Max(Char_X_Max),
											
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
