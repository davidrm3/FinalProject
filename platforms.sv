//module  platform ( input Reset,frame_clk,
//               output [9:0]  PlatX, PlatY, PlatS 
//					);
//    
//    logic [9:0] Plat_X_Pos, Plat_Y_Pos, Plat_Size;
//	 
//	 // Platform starting point for each screen
//
//	 //Character shape
//    parameter [9:0] Plat_X_Start=320;  // Center position on the X axis
//    parameter [9:0] Plat_Y_Start=100;  // Center position on the Y axis
//	 assign Plat_Size = 4;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
//	 
////    parameter [9:0] Plat_X_Min=100;       // Leftmost point on the X axis
////    parameter [9:0] Plat_X_Max=540;     // Rightmost point on the X axis
////    parameter [9:0] Plat_Y_Min=0;       // Topmost point on the Y axis
////    parameter [9:0] Plat_Y_Max=320;     // Bottommost point on the Y axis
//   // parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
//    //parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
//	 
//	 
//   
//       
//    assign PlatX = Plat_X_Start;
//   
//    assign PlatY = Plat_Y_Start;
//   
//    assign PlatS = Plat_Size;
//    
//
//endmodule
