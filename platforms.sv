//module  platform ( input Reset, frame_clk,
//					input [7:0] keycode,
//               output [9:0]  PlatX, PlatY, PlatS );
//    
//    logic [9:0] Char_X_Pos, Char_X_Motion, Char_Y_Pos, Char_Y_Motion, Char_Size;
//	 
//	 // Character starting point for each screen
//	 // Jump value
//	 
//	 //Character shape
//    parameter [9:0] Char_X_Start=320;  // Center position on the X axis
//    parameter [9:0] Char_Y_Start=240;  // Center position on the Y axis
//	 assign Ball_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
//	 
//    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
//    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
//    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
//    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
//    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
//    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
//   
//    always_ff @ (posedge Reset or posedge frame_clk )
//    begin: Move_Ball
//        if (Reset)  // Asynchronous Reset
//        begin 
//            Char_Y_Motion <= 10'd0; //Ball_Y_Step;
//				Char_X_Motion <= 10'd0; //Ball_X_Step;
//				Char_Y_Pos <= Char_Y_Start; // Brings character to starting Y-position
//				Char_X_Pos <= Char_X_Start; // Brings character to starting X-position
//        end
//           
//        else 
//        begin 
//				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max )  // Character is at the bottom edge, switch to old screen
//					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, switch to new screen
//					  Ball_Y_Motion <= Ball_Y_Step;
//					  
//				 else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max )  // Ball is at the Right edge, BOUNCE!
//					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//					  
//				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min )  // Ball is at the Left edge, BOUNCE!
//					  Ball_X_Motion <= Ball_X_Step;
//				 else 
//					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
//					  
//				 
//				 case (keycode)
//					8'h04 : begin
//										Char_X_Motion <= -;//A
//										Char_Y_Motion<= 0;
//							  end
//					        
//					8'h07 : begin
//										Char_X_Motion <= ;//D
//										Char_Y_Motion <= 0;
//							  end
//
//							  
//					8'h44 : begin
//										Char_Y_Motion <= 1;//Space
//										Char_X_Motion <= 0;
//							 end
//							  
//  
//					default: ;
//			   endcase
//				 
//				 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
//				 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
//			
//			
//	  /**************************************************************************************
//	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
//		 Hidden Question #2/2:
//          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
//          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
//          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
//          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
//      **************************************************************************************/
//      
//			
//		end  
//    end
//       
//    assign BallX = Ball_X_Pos;
//   
//    assign BallY = Ball_Y_Pos;
//   
//    assign BallS = Ball_Size;
//    
//
//endmodule
