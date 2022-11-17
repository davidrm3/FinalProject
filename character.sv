module  character ( input Reset, frame_clk, CLK,
					input [7:0] keycode,
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
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Char_Y_Motion <= 10'd0; // Stops charcter motion in Y;
				Char_X_Motion <= 10'd0; // Stops character motion in X;
				Char_Y_Pos <= Char_Y_Start; // Brings character to starting Y-position
				Char_X_Pos <= Char_X_Start; // Brings character to starting X-position
        end
           
        else //collision
        begin 
				//first screen collisions
				if ( (Char_Y_Pos + Char_Size) >= Char_Y_Max )  // Character is at the bottom edge, stop
					  Char_Y_Motion <= 1'b0;
					  
				else if ( (Char_Y_Pos - Char_Size) <= Char_Y_Min )  // Ball is at the top edge, fall
					  Char_Y_Motion <= -1'b0;
			end  
    end
       	//module instantiation
			char_controller state_machine(.keycode(keycode), .Char_X_Motion(Char_X_Motion), .Char_Y_Motion(Char_Y_Motion), .space_en(space_en), .jump_en(jump_en)); //controls character motion based off input
							
			counter space_counter(.RESET(space_reset), .CLK(CLK), .count_en(space_en), .max(50), .count(space_count));
			counter jump_counter(.RESET(jump_reset), .CLK(CLK), .count_en(jump_en), .max(space_count), .count(j_count));
			
    assign CharX = Char_X_Pos;
   
    assign CharY = Char_Y_Pos;
   
    assign CharS = Char_Size;
    

endmodule
