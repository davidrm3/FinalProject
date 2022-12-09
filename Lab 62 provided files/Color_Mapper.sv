//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size,
								input logic blank,
								input logic pixel_clk, //25Mhz clock
								input logic [10:0] background_number,
                       output logic [7:0]  Red, Green, Blue,
							  output logic collision, 
							  output logic [3:0] Default1,BallDebug,PlatformDebug, BackgroundDebug,
							  output logic [8:0] platX, platY, Plat_size);
    
    logic ball_on;
	 logic platform_on;
	 logic background_on;
		
	 
	 logic [3:0] defaultColor, balldebug,platdebug, backgrounddebug; 
	 assign Default1 = defaultColor;
	 assign BallDebug = balldebug;
	 assign PlatformDebug = platdebug;
	 assign BackgroundDebug = backgrounddebug; 
	
	 
	 
	 
//logic for background bound signals being set to high




//drawing line
//top screen
		logic topline_on;
		
		logic [10:00] topline_x = 110;
		logic [10:00] topline_size_x = 423;
		logic [10:00] topline_y = 32;
		logic [10:00] topline_size_y = 10;
		
		assign topline = DrawX >= topline_x && DrawX < topline_x + topline_size_x && 
		DrawY >= topline_y && DrawY < topline_y + topline_size_y;
		
		 always_comb
		 begin:topline_on_proc
			  if ((topline)) 
					topline_on = 1'b1;
			  else 
					topline_on = 1'b0;
		  end 
//top screen end

//bottom screen
		logic botline_on;
		
		logic [10:00] botline_x = 110;
		logic [10:00] botline_size_x = 423;
		logic [10:00] botline_y = 475;
		logic [10:00] botline_size_y = 10;
		
		assign botline = DrawX >= botline_x && DrawX < botline_x + botline_size_x && 
		DrawY >= botline_y && DrawY < botline_y + botline_size_y;
		
		 always_comb
		 begin:botline_on_proc
			  if ((botline)) 
					botline_on = 1'b1;
			  else 
					botline_on = 1'b0;
		  end 
//bottom screen end	


	  

	 
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
    int DistX, DistY, Size;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	 
/////////////////////////////////////////////////////////////////////////////Green1!	 
//	 //orginal platform coordinates
//	logic [10:0] shape_x = 270;
//	logic [10:0] shape_size_x = 100;
//	logic [10:0] shape_y = 300;
//	logic [10:0] shape_size_y = 16;	
//	
//	assign platform = DrawX >= shape_x && DrawX < shape_x + shape_size_x && 
//	DrawY >= shape_y && DrawY < shape_y + shape_size_y;
//	
//	
//	
//	//green level 1 map shapes
//	
//		//plat left 1 start
//		logic G_platLeft_on;
//		
//		logic [10:00] G_platLeft_x = 110;
//		logic [10:00] G_platLeft_size_x = 100;
//		logic [10:00] G_platLeft_y = 240;
//		logic [10:00] G_platLeft_size_y = 167;
//		
//		assign G_platLeft = DrawX >= G_platLeft_x && DrawX < G_platLeft_x + G_platLeft_size_x && 
//		DrawY >= G_platLeft_y && DrawY < G_platLeft_y + G_platLeft_size_y;
//		
//		 always_comb
//		 begin:G_PlatformLeft_on_proc
//			  if ((G_platLeft)) 
//					G_platLeft_on = 1'b1;
//			  else 
//					G_platLeft_on = 1'b0;
//		  end 
//		 //plat left 1 end 
//		 
//		 
///////////////////////////
//////////////////////////
//			
//		//plat right 1 start
//		logic G_platRight_on;
//		
//		logic [10:00] G_platRight_x = 432;
//		logic [10:00] G_platRight_size_x = 101;
//		logic [10:00] G_platRight_y = 240;
//		logic [10:00] G_platRight_size_y = 167;
//		
//		assign G_platRight = DrawX >= G_platRight_x && DrawX < G_platRight_x + G_platRight_size_x && 
//		DrawY >= G_platRight_y && DrawY < G_platRight_y + G_platRight_size_y;
//		
//		 always_comb
//		 begin:G_PlatformRight_on_proc
//			  if ((G_platRight)) 
//					G_platRight_on = 1'b1;
//			  else 
//					G_platRight_on = 1'b0;
//		  end 
//		  //plat right 1 end
//		  
//		  
////////////////////////
////////////////////////
//
//
//		//plat bottom 1 start
//		logic G_platBottom_on;
//		
//		logic [10:00] G_platBottom_x = 110;
//		logic [10:00] G_platBottom_size_x = 423;
//		logic [10:00] G_platBottom_y = 407;
//		logic [10:00] G_platBottom_size_y = 50;
//		
//		assign G_platBottom = DrawX >= G_platBottom_x && DrawX < G_platBottom_x + G_platBottom_size_x && 
//		DrawY >= G_platBottom_y && DrawY < G_platBottom_y + G_platBottom_size_y;
//		
//		 always_comb
//		 begin:G_PlatformBottom_on_proc
//			  if ((G_platBottom)) 
//					G_platBottom_on = 1'b1;
//			  else 
//					G_platBottom_on = 1'b0;
//		  end 
//		  //plat bottom 1 end	
//	
//
//
//////////////////////////
//////////////////////////	
//
//		//plat float 1 start
//		logic G_platFloat_on;
//		
//		logic [10:00] G_platFloat_x = 265;
//		logic [10:00] G_platFloat_size_x = 113;
//		logic [10:00] G_platFloat_y = 80;
//		logic [10:00] G_platFloat_size_y = 50;
//		
//		assign G_platFloat = DrawX >= G_platFloat_x && DrawX < G_platFloat_x + G_platFloat_size_x && 
//		DrawY >= G_platFloat_y && DrawY < G_platFloat_y + G_platFloat_size_y;
//		
//		 always_comb
//		 begin:G_PlatformFloat_on_proc
//			  if ((G_platFloat)) 
//					G_platFloat_on = 1'b1;
//			  else 
//					G_platFloat_on = 1'b0;
//		  end 
//		  //plat bottom 1 end	
//		  
//		  
////////////////////////////////////////Green1 ^		  

//////////////////////////////////////Green2!

////green level 2 map shapes
//	
////plat 1 start
//		logic G2_plat1_on;
//		
//		logic [10:00] G2_plat1_x = 375;
//		logic [10:00] G2_plat1_size_x = 98;
//		logic [10:00] G2_plat1_y = 370;
//		logic [10:00] G2_plat1_size_y = 36;
//		
//		assign G2_plat1 = DrawX >= G2_plat1_x && DrawX < G2_plat1_x + G2_plat1_size_x && 
//		DrawY >= G2_plat1_y && DrawY < G2_plat1_y + G2_plat1_size_y;
//		
//		 always_comb
//		 begin:G2_Platform1_on_proc
//			  if ((G2_plat1)) 
//					G2_plat1_on = 1'b1;
//			  else 
//					G2_plat1_on = 1'b0;
//		  end 
////plat left 1 end 
//		 
////plat 2 start
//		logic G2_plat2_on;
//		
//		logic [10:00] G2_plat2_x = 490;
//		logic [10:00] G2_plat2_size_x = 43;
//		logic [10:00] G2_plat2_y = 260;
//		logic [10:00] G2_plat2_size_y = 43;
//		
//		assign G2_plat2 = DrawX >= G2_plat2_x && DrawX < G2_plat2_x + G2_plat2_size_x && 
//		DrawY >= G2_plat2_y && DrawY < G2_plat2_y + G2_plat2_size_y;
//		
//		 always_comb
//		 begin:G2_Platform2_on_proc
//			  if ((G2_plat2)) 
//					G2_plat2_on = 1'b1;
//			  else 
//					G2_plat2_on = 1'b0;
//		  end 
////plat 2 end 
//
////plat 3 start
//		logic G2_plat3_on;
//		
//		logic [10:00] G2_plat3_x = 338;
//		logic [10:00] G2_plat3_size_x = 72;
//		logic [10:00] G2_plat3_y = 260;
//		logic [10:00] G2_plat3_size_y = 40;
//		
//		assign G2_plat3 = DrawX >= G2_plat3_x && DrawX < G2_plat3_x + G2_plat3_size_x && 
//		DrawY >= G2_plat3_y && DrawY < G2_plat3_y + G2_plat3_size_y;
//		
//		 always_comb
//		 begin:G2_Platform3_on_proc
//			  if ((G2_plat3)) 
//					G2_plat3_on = 1'b1;
//			  else 
//					G2_plat3_on = 1'b0;
//		  end 
////plat 3 end 
//		 
//		 
////plat 4 start
//		logic G2_plat4_on;
//		
//		logic [10:00] G2_plat4_x = 200;
//		logic [10:00] G2_plat4_size_x = 75;
//		logic [10:00] G2_plat4_y = 152;
//		logic [10:00] G2_plat4_size_y = 75;
//		
//		assign G2_plat4 = DrawX >= G2_plat4_x && DrawX < G2_plat4_x + G2_plat4_size_x && 
//		DrawY >= G2_plat4_y && DrawY < G2_plat4_y + G2_plat4_size_y;
//		
//		 always_comb
//		 begin:G2_Platform4_on_proc
//			  if ((G2_plat4)) 
//					G2_plat4_on = 1'b1;
//			  else 
//					G2_plat4_on = 1'b0;
//		  end 
////plat 4 end 
//		 
////plat 5 start
//		logic G2_plat5_on;
//		
//		logic [10:00] G2_plat5_x = 110;
//		logic [10:00] G2_plat5_size_x = 60;
//		logic [10:00] G2_plat5_y = 128;
//		logic [10:00] G2_plat5_size_y = 96;//104
//		
//		assign G2_plat5 = DrawX >= G2_plat5_x && DrawX < G2_plat5_x + G2_plat5_size_x && 
//		DrawY >= G2_plat5_y && DrawY < G2_plat5_y + G2_plat5_size_y;
//		
//		 always_comb
//		 begin:G2_Platform5_on_proc
//			  if ((G2_plat5)) 
//					G2_plat5_on = 1'b1;
//			  else 
//					G2_plat5_on = 1'b0;
//		  end 
////plat 5 end 
	
///////////////////////////////////////////////////////////////////////Green2 ^	


///////////////////////////////////////////////////////////////////////Green3!
////green level 2 map shapes
//	
////plat 1 start
//		logic G3_plat1_on;
//		
//		logic [10:00] G3_plat1_x = 290;
//		logic [10:00] G3_plat1_size_x = 45;
//		logic [10:00] G3_plat1_y = 380;
//		logic [10:00] G3_plat1_size_y = 18;
//		
//		assign G3_plat1 = DrawX >= G3_plat1_x && DrawX < G3_plat1_x + G3_plat1_size_x && 
//		DrawY >= G3_plat1_y && DrawY < G3_plat1_y + G3_plat1_size_y;
//		
//		 always_comb
//		 begin:G3_Platform1_on_proc
//			  if ((G3_plat1)) 
//					G3_plat1_on = 1'b1;
//			  else 
//					G3_plat1_on = 1'b0;
//		  end 
////plat left 1 end 
//		 
////plat 2 start
//		logic G3_plat2_on;
//		
//		logic [10:00] G3_plat2_x = 403;
//		logic [10:00] G3_plat2_size_x = 54;
//		logic [10:00] G3_plat2_y = 380;
//		logic [10:00] G3_plat2_size_y = 18;
//		
//		assign G3_plat2 = DrawX >= G3_plat2_x && DrawX < G3_plat2_x + G3_plat2_size_x && 
//		DrawY >= G3_plat2_y && DrawY < G3_plat2_y + G3_plat2_size_y;
//		
//		 always_comb
//		 begin:G3_Platform2_on_proc
//			  if ((G3_plat2)) 
//					G3_plat2_on = 1'b1;
//			  else 
//					G3_plat2_on = 1'b0;
//		  end 
////plat 2 end 
//
////plat 3 start
//		logic G3_plat3_on;
//		
//		logic [10:00] G3_plat3_x = 504;
//		logic [10:00] G3_plat3_size_x = 29;
//		logic [10:00] G3_plat3_y = 330;
//		logic [10:00] G3_plat3_size_y = 12;
//		
//		assign G3_plat3 = DrawX >= G3_plat3_x && DrawX < G3_plat3_x + G3_plat3_size_x && 
//		DrawY >= G3_plat3_y && DrawY < G3_plat3_y + G3_plat3_size_y;
//		
//		 always_comb
//		 begin:G3_Platform3_on_proc
//			  if ((G3_plat3)) 
//					G3_plat3_on = 1'b1;
//			  else 
//					G3_plat3_on = 1'b0;
//		  end 
////plat 3 end 
//		 
//		 
////plat 4 start
//		logic G3_plat4_on;
//		
//		logic [10:00] G3_plat4_x = 270;
//		logic [10:00] G3_plat4_size_x = 100;
//		logic [10:00] G3_plat4_y = 289;
//		logic [10:00] G3_plat4_size_y = 35;
//		
//		assign G3_plat4 = DrawX >= G3_plat4_x && DrawX < G3_plat4_x + G3_plat4_size_x && 
//		DrawY >= G3_plat4_y && DrawY < G3_plat4_y + G3_plat4_size_y;
//		
//		 always_comb
//		 begin:G3_Platform4_on_proc
//			  if ((G3_plat4)) 
//					G3_plat4_on = 1'b1;
//			  else 
//					G3_plat4_on = 1'b0;
//		  end 
////plat 4 end 
//		 
////plat 5 start
//		logic G3_plat5_on;
//		
//		logic [10:00] G3_plat5_x = 365;
//		logic [10:00] G3_plat5_size_x = 50;
//		logic [10:00] G3_plat5_y = 266;
//		logic [10:00] G3_plat5_size_y = 58;//104
//		
//		assign G3_plat5 = DrawX >= G3_plat5_x && DrawX < G3_plat5_x + G3_plat5_size_x && 
//		DrawY >= G3_plat5_y && DrawY < G3_plat5_y + G3_plat5_size_y;
//		
//		 always_comb
//		 begin:G3_Platform5_on_proc
//			  if ((G3_plat5)) 
//					G3_plat5_on = 1'b1;
//			  else 
//					G3_plat5_on = 1'b0;
//		  end 
////plat 5 end 
//
////plat 6 start
//		logic G3_plat6_on;
//		
//		logic [10:00] G3_plat6_x = 240;
//		logic [10:00] G3_plat6_size_x = 58;
//		logic [10:00] G3_plat6_y = 170;
//		logic [10:00] G3_plat6_size_y = 55;//104
//		
//		assign G3_plat6 = DrawX >= G3_plat6_x && DrawX < G3_plat6_x + G3_plat6_size_x && 
//		DrawY >= G3_plat6_y && DrawY < G3_plat6_y + G3_plat6_size_y;
//		
//		 always_comb
//		 begin:G3_Platform6_on_proc
//			  if ((G3_plat6)) 
//					G3_plat6_on = 1'b1;
//			  else 
//					G3_plat6_on = 1'b0;
//		  end 
////plat 6 end 
//
//
////plat 7 start
//		logic G3_plat7_on;
//		
//		logic [10:00] G3_plat7_x = 110;
//		logic [10:00] G3_plat7_size_x = 41;
//		logic [10:00] G3_plat7_y = 148;
//		logic [10:00] G3_plat7_size_y = 20;//104
//		
//		assign G3_plat7 = DrawX >= G3_plat7_x && DrawX < G3_plat7_x + G3_plat7_size_x && 
//		DrawY >= G3_plat7_y && DrawY < G3_plat7_y + G3_plat7_size_y;
//		
//		 always_comb
//		 begin:G3_Platform7_on_proc
//			  if ((G3_plat7)) 
//					G3_plat7_on = 1'b1;
//			  else 
//					G3_plat7_on = 1'b0;
//		  end 
////plat 7 end 
//
//
////plat 8 start
//		logic G3_plat8_on;
//		
//		logic [10:00] G3_plat8_x = 218;
//		logic [10:00] G3_plat8_size_x = 70;
//		logic [10:00] G3_plat8_y = 32;
//		logic [10:00] G3_plat8_size_y = 24;//104
//		
//		assign G3_plat8 = DrawX >= G3_plat8_x && DrawX < G3_plat8_x + G3_plat8_size_x && 
//		DrawY >= G3_plat8_y && DrawY < G3_plat8_y + G3_plat8_size_y;
//		
//		 always_comb
//		 begin:G3_Platform8_on_proc
//			  if ((G3_plat8)) 
//					G3_plat8_on = 1'b1;
//			  else 
//					G3_plat8_on = 1'b0;
//		  end 
////plat 8 end 
//////////////////////////////////////////Green3 ^


/////////////////////////////////////////Leaf1 !
////leaf level 1 map shapes
//	
////plat 1 start
//		logic L1_plat1_on;
//		
//		logic [10:00] L1_plat1_x = 215;
//		logic [10:00] L1_plat1_size_x = 72;
//		logic [10:00] L1_plat1_y = 400;
//		logic [10:00] L1_plat1_size_y = 80;
//		
//		assign L1_plat1 = DrawX >= L1_plat1_x && DrawX < L1_plat1_x + L1_plat1_size_x && 
//		DrawY >= L1_plat1_y && DrawY < L1_plat1_y + L1_plat1_size_y;
//		
//		 always_comb
//		 begin:L1_Platform1_on_proc
//			  if ((L1_plat1)) 
//					L1_plat1_on = 1'b1;
//			  else 
//					L1_plat1_on = 1'b0;
//		  end 
////plat left 1 end 
//		 
////plat 2 start
//		logic L1_plat2_on;
//		
//		logic [10:00] L1_plat2_x = 110;
//		logic [10:00] L1_plat2_size_x = 60;
//		logic [10:00] L1_plat2_y = 280;
//		logic [10:00] L1_plat2_size_y = 30;
//		
//		assign L1_plat2 = DrawX >= L1_plat2_x && DrawX < L1_plat2_x + L1_plat2_size_x && 
//		DrawY >= L1_plat2_y && DrawY < L1_plat2_y + L1_plat2_size_y;
//		
//		 always_comb
//		 begin:L1_Platform2_on_proc
//			  if ((L1_plat2)) 
//					L1_plat2_on = 1'b1;
//			  else 
//					L1_plat2_on = 1'b0;
//		  end 
////plat 2 end 
//
////plat 3 start
//		logic L1_plat3_on;
//		
//		logic [10:00] L1_plat3_x = 220;
//		logic [10:00] L1_plat3_size_x = 80;
//		logic [10:00] L1_plat3_y = 280;
//		logic [10:00] L1_plat3_size_y = 30;
//		
//		assign L1_plat3 = DrawX >= L1_plat3_x && DrawX < L1_plat3_x + L1_plat3_size_x && 
//		DrawY >= L1_plat3_y && DrawY < L1_plat3_y + L1_plat3_size_y;
//		
//		 always_comb
//		 begin:L1_Platform3_on_proc
//			  if ((L1_plat3)) 
//					L1_plat3_on = 1'b1;
//			  else 
//					L1_plat3_on = 1'b0;
//		  end 
////plat 3 end 
//		 
//		 
////plat 4 start
//		logic L1_plat4_on;
//		
//		logic [10:00] L1_plat4_x = 380;
//		logic [10:00] L1_plat4_size_x = 30;
//		logic [10:00] L1_plat4_y = 200;
//		logic [10:00] L1_plat4_size_y = 90;
//		
//		assign L1_plat4 = DrawX >= L1_plat4_x && DrawX < L1_plat4_x + L1_plat4_size_x && 
//		DrawY >= L1_plat4_y && DrawY < L1_plat4_y + L1_plat4_size_y;
//		
//		 always_comb
//		 begin:L1_Platform4_on_proc
//			  if ((L1_plat4)) 
//					L1_plat4_on = 1'b1;
//			  else 
//					L1_plat4_on = 1'b0;
//		  end 
////plat 4 end 
//		 
////plat 5 start
//		logic L1_plat5_on;
//		
//		logic [10:00] L1_plat5_x = 410;
//		logic [10:00] L1_plat5_size_x = 20;
//		logic [10:00] L1_plat5_y = 150;
//		logic [10:00] L1_plat5_size_y = 140;//104
//		
//		assign L1_plat5 = DrawX >= L1_plat5_x && DrawX < L1_plat5_x + L1_plat5_size_x && 
//		DrawY >= L1_plat5_y && DrawY < L1_plat5_y + L1_plat5_size_y;
//		
//		 always_comb
//		 begin:L1_Platform5_on_proc
//			  if ((L1_plat5)) 
//					L1_plat5_on = 1'b1;
//			  else 
//					L1_plat5_on = 1'b0;
//		  end 
////plat 5 end 
//
////plat 6 start
//		logic L1_plat6_on;
//		
//		logic [10:00] L1_plat6_x = 240;
//		logic [10:00] L1_plat6_size_x = 30;
//		logic [10:00] L1_plat6_y = 130;
//		logic [10:00] L1_plat6_size_y = 97;//104
//		
//		assign L1_plat6 = DrawX >= L1_plat6_x && DrawX < L1_plat6_x + L1_plat6_size_x && 
//		DrawY >= L1_plat6_y && DrawY < L1_plat6_y + L1_plat6_size_y;
//		
//		 always_comb
//		 begin:L1_Platform6_on_proc
//			  if ((L1_plat6)) 
//					L1_plat6_on = 1'b1;
//			  else 
//					L1_plat6_on = 1'b0;
//		  end 
////plat 6 end 
//
//
////plat 7 start
//		logic L1_plat7_on;
//		
//		logic [10:00] L1_plat7_x = 220;
//		logic [10:00] L1_plat7_size_x = 20;
//		logic [10:00] L1_plat7_y = 32;
//		logic [10:00] L1_plat7_size_y = 195;//104
//		
//		assign L1_plat7 = DrawX >= L1_plat7_x && DrawX < L1_plat7_x + L1_plat7_size_x && 
//		DrawY >= L1_plat7_y && DrawY < L1_plat7_y + L1_plat7_size_y;
//		
//		 always_comb
//		 begin:L1_Platform7_on_proc
//			  if ((L1_plat7)) 
//					L1_plat7_on = 1'b1;
//			  else 
//					L1_plat7_on = 1'b0;
//		  end 
////plat 7 end 
//
//
////plat 8 start
//		logic L1_plat8_on;
//		
//		logic [10:00] L1_plat8_x = 410;
//		logic [10:00] L1_plat8_size_x = 20;
//		logic [10:00] L1_plat8_y = 32;
//		logic [10:00] L1_plat8_size_y = 48;//104
//		
//		assign L1_plat8 = DrawX >= L1_plat8_x && DrawX < L1_plat8_x + L1_plat8_size_x && 
//		DrawY >= L1_plat8_y && DrawY < L1_plat8_y + L1_plat8_size_y;
//		
//		 always_comb
//		 begin:L1_Platform8_on_proc
//			  if ((L1_plat8)) 
//					L1_plat8_on = 1'b1;
//			  else 
//					L1_plat8_on = 1'b0;
//		  end 
////plat 8 end 
//
////plat 9 start
//		logic L1_plat9_on;
//		
//		logic [10:00] L1_plat9_x = 500;
//		logic [10:00] L1_plat9_size_x = 33;
//		logic [10:00] L1_plat9_y = 180;
//		logic [10:00] L1_plat9_size_y = 20;//104
//		
//		assign L1_plat9 = DrawX >= L1_plat9_x && DrawX < L1_plat9_x + L1_plat9_size_x && 
//		DrawY >= L1_plat9_y && DrawY < L1_plat9_y + L1_plat9_size_y;
//		
//		 always_comb
//		 begin:L1_Platform9_on_proc
//			  if ((L1_plat9)) 
//					L1_plat9_on = 1'b1;
//			  else 
//					L1_plat9_on = 1'b0;
//		  end 
////plat 9 end 


//////////////////////////////////////////Leaf1 ^


/////////////////////////////////////////Leaf2 !
//leaf level 2 map shapes

	
//plat 1 start
		//leaf level 1 map shapes
	
////plat 1 start
//		logic L2_plat1_on;
//		
//		logic [10:00] L2_plat1_x = 200;
//		logic [10:00] L2_plat1_size_x = 40;
//		logic [10:00] L2_plat1_y = 390;
//		logic [10:00] L2_plat1_size_y = 90;
//		
//		assign L2_plat1 = DrawX >= L2_plat1_x && DrawX < L2_plat1_x + L2_plat1_size_x && 
//		DrawY >= L2_plat1_y && DrawY < L2_plat1_y + L2_plat1_size_y;
//		
//		 always_comb
//		 begin:L2_Platform1_on_proc
//			  if ((L2_plat1)) 
//					L2_plat1_on = 1'b1;
//			  else 
//					L2_plat1_on = 1'b0;
//		  end 
////plat left 1 end 
//		 
////plat 2 start
//		logic L2_plat2_on;
//		
//		logic [10:00] L2_plat2_x = 410;
//		logic [10:00] L2_plat2_size_x = 40;
//		logic [10:00] L2_plat2_y = 390;
//		logic [10:00] L2_plat2_size_y = 80;
//		
//		assign L2_plat2 = DrawX >= L2_plat2_x && DrawX < L2_plat2_x + L2_plat2_size_x && 
//		DrawY >= L2_plat2_y && DrawY < L2_plat2_y + L2_plat2_size_y;
//		
//		 always_comb
//		 begin:L2_Platform2_on_proc
//			  if ((L2_plat2)) 
//					L2_plat2_on = 1'b1;
//			  else 
//					L2_plat2_on = 1'b0;
//		  end 
////plat 2 end 
//
////plat 3 start
//		logic L2_plat3_on;
//		
//		logic [10:00] L2_plat3_x = 410;
//		logic [10:00] L2_plat3_size_x = 40;
//		logic [10:00] L2_plat3_y = 310;
//		logic [10:00] L2_plat3_size_y = 20;
//		
//		assign L2_plat3 = DrawX >= L2_plat3_x && DrawX < L2_plat3_x + L2_plat3_size_x && 
//		DrawY >= L2_plat3_y && DrawY < L2_plat3_y + L2_plat3_size_y;
//		
//		 always_comb
//		 begin:L2_Platform3_on_proc
//			  if ((L2_plat3)) 
//					L2_plat3_on = 1'b1;
//			  else 
//					L2_plat3_on = 1'b0;
//		  end 
////plat 3 end 
//		 
//		 
////plat 4 start
//		logic L2_plat4_on;
//		
//		logic [10:00] L2_plat4_x = 513;
//		logic [10:00] L2_plat4_size_x = 20;
//		logic [10:00] L2_plat4_y = 220;
//		logic [10:00] L2_plat4_size_y = 30;
//		
//		assign L2_plat4 = DrawX >= L2_plat4_x && DrawX < L2_plat4_x + L2_plat4_size_x && 
//		DrawY >= L2_plat4_y && DrawY < L2_plat4_y + L2_plat4_size_y;
//		
//		 always_comb
//		 begin:L2_Platform4_on_proc
//			  if ((L2_plat4)) 
//					L2_plat4_on = 1'b1;
//			  else 
//					L2_plat4_on = 1'b0;
//		  end 
////plat 4 end 
//		 
////plat 5 start
//		logic L2_plat5_on;
//		
//		logic [10:00] L2_plat5_x = 373;
//		logic [10:00] L2_plat5_size_x = 33;
//		logic [10:00] L2_plat5_y = 133;
//		logic [10:00] L2_plat5_size_y = 30;//104
//		
//		assign L2_plat5 = DrawX >= L2_plat5_x && DrawX < L2_plat5_x + L2_plat5_size_x && 
//		DrawY >= L2_plat5_y && DrawY < L2_plat5_y + L2_plat5_size_y;
//		
//		 always_comb
//		 begin:L2_Platform5_on_proc
//			  if ((L2_plat5)) 
//					L2_plat5_on = 1'b1;
//			  else 
//					L2_plat5_on = 1'b0;
//		  end 
////plat 5 end 
//
////plat 6 start
//		logic L2_plat6_on;
//		
//		logic [10:00] L2_plat6_x = 303;
//		logic [10:00] L2_plat6_size_x = 33;
//		logic [10:00] L2_plat6_y = 112;
//		logic [10:00] L2_plat6_size_y = 30;//104
//		
//		assign L2_plat6 = DrawX >= L2_plat6_x && DrawX < L2_plat6_x + L2_plat6_size_x && 
//		DrawY >= L2_plat6_y && DrawY < L2_plat6_y + L2_plat6_size_y;
//		
//		 always_comb
//		 begin:L2_Platform6_on_proc
//			  if ((L2_plat6)) 
//					L2_plat6_on = 1'b1;
//			  else 
//					L2_plat6_on = 1'b0;
//		  end 
////plat 6 end 
//
//
////plat 7 start
//		logic L2_plat7_on;
//		
//		logic [10:00] L2_plat7_x = 242;
//		logic [10:00] L2_plat7_size_x = 33;
//		logic [10:00] L2_plat7_y = 100;
//		logic [10:00] L2_plat7_size_y = 30;//104
//		
//		assign L2_plat7 = DrawX >= L2_plat7_x && DrawX < L2_plat7_x + L2_plat7_size_x && 
//		DrawY >= L2_plat7_y && DrawY < L2_plat7_y + L2_plat7_size_y;
//		
//		 always_comb
//		 begin:L2_Platform7_on_proc
//			  if ((L2_plat7)) 
//					L2_plat7_on = 1'b1;
//			  else 
//					L2_plat7_on = 1'b0;
//		  end 
////plat 7 end 
//
//
////plat 8 start
//		logic L2_plat8_on;
//		
//		logic [10:00] L2_plat8_x = 120;
//		logic [10:00] L2_plat8_size_x = 40;
//		logic [10:00] L2_plat8_y = 130;
//		logic [10:00] L2_plat8_size_y = 30;//104
//		
//		assign L2_plat8 = DrawX >= L2_plat8_x && DrawX < L2_plat8_x + L2_plat8_size_x && 
//		DrawY >= L2_plat8_y && DrawY < L2_plat8_y + L2_plat8_size_y;
//		
//		 always_comb
//		 begin:L2_Platform8_on_proc
//			  if ((L2_plat8)) 
//					L2_plat8_on = 1'b1;
//			  else 
//					L2_plat8_on = 1'b0;
//		  end 
////plat 8 end 
//
////plat 9 start
//		logic L2_plat9_on;
//		
//		logic [10:00] L2_plat9_x = 110;
//		logic [10:00] L2_plat9_size_x = 30;
//		logic [10:00] L2_plat9_y = 330;
//		logic [10:00] L2_plat9_size_y = 30;//104
//		
//		assign L2_plat9 = DrawX >= L2_plat9_x && DrawX < L2_plat9_x + L2_plat9_size_x && 
//		DrawY >= L2_plat9_y && DrawY < L2_plat9_y + L2_plat9_size_y;
//		
//		 always_comb
//		 begin:L2_Platform9_on_proc
//			  if ((L2_plat9)) 
//					L2_plat9_on = 1'b1;
//			  else 
//					L2_plat9_on = 1'b0;
//		  end 
////plat 9 end 
//
//
////plat 10 start
//		logic L2_plat10_on;
//		
//		logic [10:00] L2_plat10_x = 230;
//		logic [10:00] L2_plat10_size_x = 210;
//		logic [10:00] L2_plat10_y = 32;
//		logic [10:00] L2_plat10_size_y = 24;//104
//		
//		assign L2_plat10 = DrawX >= L2_plat10_x && DrawX < L2_plat10_x + L2_plat10_size_x && 
//		DrawY >= L2_plat10_y && DrawY < L2_plat10_y + L2_plat10_size_y;
//		
//		 always_comb
//		 begin:L2_Platform10_on_proc
//			  if ((L2_plat10)) 
//					L2_plat10_on = 1'b1;
//			  else 
//					L2_plat10_on = 1'b0;
//		  end 
//plat 10 end 

/////////////////////////////////////////Leaf2 ^


////////////////////////////////////////Leaf3!

//leaf level 1 map shapes
	
//plat 1 start
		logic L3_plat1_on;
		
		logic [10:00] L3_plat1_x = 230;
		logic [10:00] L3_plat1_size_x = 170;
		logic [10:00] L3_plat1_y = 420;
		logic [10:00] L3_plat1_size_y = 60;
		
		assign L3_plat1 = DrawX >= L3_plat1_x && DrawX < L3_plat1_x + L3_plat1_size_x && 
		DrawY >= L3_plat1_y && DrawY < L3_plat1_y + L3_plat1_size_y;
		
		 always_comb
		 begin:L3_Platform1_on_proc
			  if ((L3_plat1)) 
					L3_plat1_on = 1'b1;
			  else 
					L3_plat1_on = 1'b0;
		  end 
//plat left 1 end 

////////////////////////////////////////Leaf3 ^



//more		  
	
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//background assignments	
	
	assign background = DrawX >=110 && DrawX <= 532 && DrawY >= 0 && DrawY <= 480;
	
	logic StartScreen_on, Green1_on, Green2_on, Gutter1_on, Gutter2_on, Gutter3_on, Snow1_on, Snow2_on, Snow3_on, EndScreen_on;
	
//procs for backgrounds	and ball

	 
	//define collision
	//always comb 
	//not this method, bad to use these two define collision
	//logic collision;
	//assign collision = ball_on && platform_on;
	//assign Platcollision = collision;
	  
    always_comb
    begin:Ball_on_proc
        if ( ( DistX*DistX + DistY*DistY) <= (Size * Size) ) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
     end 
	  
	  
//	 always_comb
//    begin:Platform_on_proc
//        if ((platform)) 
//            platform_on = 1'b1;
//        else 
//            platform_on = 1'b0;
//     end  

//background signal
	 always_comb
    begin:Background_on_proc
        if ((background)) 
			begin
            background_on = 1'b1;
				defaultColor = 4'b1001; //nine
			end	
        else 
			begin	
            background_on = 1'b0;
				defaultColor = 4'b0001; //one
			end	
     end   
	  
	  
//collision signal attempt 	  
	 always_comb
    begin:collision_func
        if ((ball_on || platform_on)) 
				begin
            collision = 1'b1;
				//Globalcollision = collision;
				end
        else 
			begin
            collision = 1'b0;
				//Globalcollision = collision;
				end
				
     end  
	   
/////////////////////////////////////////////////////////////////////////////////////////	  
/////////////////////////////////////////////////////////////////////////RGB drawing here !
    always_ff @ (posedge pixel_clk)
    begin:RGB_Display
	 //brown
		  if(~blank)
		  begin
            Red <= 8'h55;
            Green <= 8'h33;
            Blue <= 8'h33;				
		  end
	 //Orange: the ball color
		  else if ((ball_on == 1'b1)) 
        begin 
            Red <= 8'hff;
            Green <= 8'h55;
            Blue <= 8'h00;
			//	balldebug = 4'b0001; //1
        end
///////////////////////////////////////////////////Green1 color dec		  
//		//platform color of lime green  
//		  else if((platform_on == 1'b1))
//				begin
//					Red <= 8'hcc;
//					Green <= 8'hbb;
//					Blue <= 8'hbb;
//				//	platdebug =  4'b0010; //2
//					
//				end
//				
//		//plat left 1 pink
//			else if(G_platLeft_on == 1'b1 )
//			  begin          
//					
//					Red <= 8'hff;
//					Green <= 8'h00;
//					Blue <= 8'hfe;
//					//defaultColor = 4'b1001; //nine
//				end			
//				
//			//plat right 1 pink
//			else if(G_platRight_on == 1'b1 )
//			  begin          
//					
//					Red <= 8'hff;
//					Green <= 8'h00;
//					Blue <= 8'hfe;
//					//defaultColor = 4'b1001; //nine
//				end		
//				
//			
//				//plat float 1 yellow
//			else if(G_platFloat_on == 1'b1 )
//			  begin          
//					
//					Red <= 8'hff;
//					Green <= 8'hcc;
//					Blue <= 8'h33;
//					//defaultColor = 4'b1001; //nine
//				end		
//	



/////////////////////////////////////////////////////////Green1 color dec ^

				

///////////////////////////////////////////////////////Green2 dec
//	//plat1
//		  else if ((G2_plat1_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		//plat2
//		  else if ((G2_plat2_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  	//plat3
//		  else if ((G2_plat3_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  		  	//plat4
//		  else if ((G2_plat4_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//
//		  	//plat5
//		  else if ((G2_plat5_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end


/////////////////////////////////////////////////////Green2 ^

////////////////////////////////////////////////////Green3 dec!

//	//plat1
//		  else if ((G3_plat1_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		//plat2
//		  else if ((G3_plat2_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  	//plat3
//		  else if ((G3_plat3_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  		  	//plat4
//		  else if ((G3_plat4_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//
//		  	//plat5
//		  else if ((G3_plat5_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		    //plat6
//		  else if ((G3_plat6_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		      //plat7
//		  else if ((G3_plat7_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		      //plat8
//		  else if ((G3_plat8_on == 1'b1)) 
//        begin 
//            Red <= 8'h77;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  

///////////////////////////////////////////////////Green3 dec^


////////////////////////////////////////////////leaf1 dec!


////plat1
//		  else if ((L1_plat1_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		//plat2
//		  else if ((L1_plat2_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'h00;
//            Blue <= 8'h33;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  	//plat3
//		  else if ((L1_plat3_on == 1'b1)) 
//        begin 
//            Red <= 8'h33;
//            Green <= 8'hff;
//            Blue <= 8'h55;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  		  	//plat4
//		  else if ((L1_plat4_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'hff;
//            Blue <= 8'h55;
//			//	balldebug = 4'b0001; //1
//        end
//
//		  	//plat5
//		  else if ((L1_plat5_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'h22;
//            Blue <= 8'h55;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		    //plat6
//		  else if ((L1_plat6_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'h88;
//            Blue <= 8'h99;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		      //plat7
//		  else if ((L1_plat7_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'hff;
//            Blue <= 8'h99;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		      //plat8
//		  else if ((L1_plat8_on == 1'b1)) 
//        begin 
//            Red <= 8'h22;
//            Green <= 8'hff;
//            Blue <= 8'hff;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		        //plat9
//		  else if ((L1_plat9_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'hbb;
//            Blue <= 8'hff;
//			//	balldebug = 4'b0001; //1
//        end
//		  

///////////////////////////////////////////////////leaf1 ^		



//////////////////////////////////////////////////leaf2 dec !
//plat1
//		  else if ((L2_plat1_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'h44;
//            Blue <= 8'hdd;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		//plat2
//		  else if ((L2_plat2_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'h00;
//            Blue <= 8'h33;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  	//plat3
//		  else if ((L2_plat3_on == 1'b1)) 
//        begin 
//            Red <= 8'h33;
//            Green <= 8'hff;
//            Blue <= 8'h55;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		  		  	//plat4
//		  else if ((L2_plat4_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'hff;
//            Blue <= 8'h55;
//			//	balldebug = 4'b0001; //1
//        end
//
//		  	//plat5
//		  else if ((L2_plat5_on == 1'b1)) 
//        begin 
//            Red <= 8'hee;
//            Green <= 8'h22;
//            Blue <= 8'h55;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		    //plat6
//		  else if ((L2_plat6_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'h88;
//            Blue <= 8'h99;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		      //plat7
//		  else if ((L2_plat7_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'hff;
//            Blue <= 8'h99;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		      //plat8
//		  else if ((L2_plat8_on == 1'b1)) 
//        begin 
//            Red <= 8'h22;
//            Green <= 8'hff;
//            Blue <= 8'hff;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		        //plat9
//		  else if ((L2_plat9_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'hbb;
//            Blue <= 8'hff;
//			//	balldebug = 4'b0001; //1
//        end
//		  
//		         //plat10
//		  else if ((L2_plat10_on == 1'b1)) 
//        begin 
//            Red <= 8'hff;
//            Green <= 8'hbb;
//            Blue <= 8'hff;
//			//	balldebug = 4'b0001; //1
//        end
		  
///////////////////////////////////////////////////leaf2 ^

/////////////////////////////////////leaf3!
//plat1
		  else if ((L3_plat1_on == 1'b1)) 
        begin 
            Red <= 8'hff;
            Green <= 8'h44;
            Blue <= 8'hdd;
			//	balldebug = 4'b0001; //1
        end
		  

/////////////////////////////////////leaf3^

		
				
			//top line
		  else if ((topline_on == 1'b1)) 
        begin 
            Red <= 8'h55;
            Green <= 8'hdd;
            Blue <= 8'hff;
			//	balldebug = 4'b0001; //1
        end
//		//bot line
//		  else if ((botpline_on == 1'b1)) 
//        begin 
//            Red <= 8'h55;
//            Green <= 8'hdd;
//            Blue <= 8'hff;
//			//	balldebug = 4'b0001; //1
//        end		
		  
//		 	//plat bottom 1 blue
//			else if(G_platBottom_on == 1'b1 )
//			  begin          
//					
//					Red <= 8'h33;
//					Green <= 8'h55;
//					Blue <= 8'hee;
//					//defaultColor = 4'b1001; //nine
//				end		
				 
				
			//new else if	
				
				
				
		  //side like the border colors 
        else if(background_on == 1'b1 )
        begin          
				
				Red <= palette_red;
				Green <= palette_green;
				Blue <= palette_blue; 
				//defaultColor = 4'b1001; //nine
			end		
				

				
			else
				begin
					Red <= 8'h55; 
					Green <= 8'hee;
					//Blue = 8'h7f - DrawX[9:3];
					Blue <= 8'haa;
				end
					     
	end
	
/////////////////////////////////////////////////////////////////////////////////////RGB End ^	
	
	
	
	
/////////////////////////////////////////////////////////////////////////////
//background assignments 	


logic [18:0] rom_address, rom_address_start, rom_address_green1, 
rom_address_green2, rom_address_gutter1, rom_address_gutter2, rom_address_gutter3, 
rom_address_snow1, rom_address_snow2, rom_address_snow3, rom_address_end;

logic [8:0] rom_q, rom_q_start, rom_q_green1, rom_q_green2,
rom_q_gutter1, rom_q_gutter2, rom_q_gutter3, rom_q_snow1, rom_q_snow2, rom_q_snow3, rom_q_end;	
logic [3:0] palette_red, palette_green, palette_blue;	

//assign rom_address = (DrawX*420/640) + (DrawY*465/480 * 420);
assign rom_address = (DrawX*105/640) + (DrawY*117/480 * 105); //1/4
//assign rom_address = (DrawX*420/640) + (DrawY*468/480 * 420); //nice one
//Test checker


leafy3_rom bruhrom (
	.clock   (pixel_clk),
	.address (rom_address),
	.q       (rom_q)
);

leafy3_palette bruhpallete (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

//StartScreen_rom greenlvl1rom (
//	.clock   (pixel_clk),
//	.address (rom_address),
//	.q       (rom_q)
//);
//
//StartScreen_palette greenlvl1palette (
//	.index (rom_q),
//	.red   (palette_red),
//	.green (palette_green),
//	.blue  (palette_blue)
//);




//emf test checker ^
//
//
//assign rom_address_start= (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_green1 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_green2 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_gutter1 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_gutter2 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_gutter3= (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_snow1 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_snow2 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_snow3 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_end = (DrawX*105/640) + (DrawY*117/480 * 105);
//
///////////////////////////////////////////////////////// Star
//logic [3:0] Red_Start, Green_Start, Blue_Start;
//	StartScreen_rom startrom(
//			.clock(pixel_clk),
//			.address(rom_address_start),
//			.q(rom_q_start)
//	);
//	StartScreen_palette startpalette(
//			.index(rom_q_start),
//			.red(Red_Start),
//			.green(Green_Start),
//			.blue(Blue_Start)
//		);
//
//
/////////////////////////////////////////////////////////Green1
//logic [3:0] Red_Green1, Green_Green1, Blue_Green1;
//		Greenlvl1_rom green1rom (
//			.clock   (pixel_clk),
//			.address (rom_address_green1),
//			.q       (rom_q_green1)
//		);
//
//		Greenlvl1_palette green1palette (
//			.index (rom_q_green1),
//			.red   (Red_Green1),
//			.green (Green_Green1),
//			.blue  (Blue_Green1)
//		);
//
/////////////////////////////////////////////////////////Green2
//logic [3:0] Red_Green2, Green_Green2, Blue_Green2;
//	Greenlvl2_rom green2rom(
//			.clock(pixel_clk),
//			.address(rom_address_green2),
//			.q(rom_q_green2)
//	);
//		Greenlvl2_palette green2palette(
//			.index(rom_q_green2),
//			.red(Red_Green2),
//			.green(Green_Green2),
//			.blue(Blue_Green2)
//		);
//
/////////////////////////////////////////////////////////////Gutter1
//logic [3:0] Red_Gutter1, Green_Gutter1, Blue_Gutter1;
//	Gutterslvl1_rom gutter1rom(
//			.clock(pixel_clk),
//			.address(rom_address_gutter1),
//			.q(rom_q_gutter1)
//	);
//	Gutterslvl1_palette gutter1palette(
//			.index(rom_q_gutter1),
//			.red(Red_Gutter1),
//			.greenGreen_Gutter1(),
//			.blue(Blue_Gutter1)
//		);
//
///////////////////////////////////////////////////////////////Gutter2
//logic [3:0] Red_Gutter2, Green_Gutter2, Blue_Gutter2;
//	Gutterslvl2_rom gutter2rom(
//			.clock(pixel_clk),
//			.address(rom_address_gutter2),
//			.q(rom_q_gutter2)
//	);
//	Gutterslvl2_palette gutter2palette(
//			.index(rom_q_gutter2),
//			.red(Red_Gutter2),
//			.green(Green_Gutter2),
//			.blue(Blue_Gutter2)
//		);
//
//////////////////////////////////////////////////////////////Gutter3
//logic [3:0] Red_Gutter3, Green_Gutter3, Blue_Gutter3;
//	Gutterslvl3_rom gutter3rom(
//			.clock(pixel_clk),
//			.address(rom_address_gutter3),
//			.q(rom_q_gutter3)
//	);
//	Gutterslvl3_palette gutter3palette(
//			.index(rom_q_gutter3),
//			.red(Red_Gutter3),
//			.green(Green_Gutter3),
//			.blue(Blue_Gutter3)
//		);
//
//////////////////////////////////////////////////////////////Snow1
//logic [3:0] Red_Snow1, Green_Snow1, Blue_Snow1;
//	Snowlvl1_rom snow1rom(
//			.clock(pixel_clk),
//			.address(rom_address_snow1),
//			.q(rom_q_snow1)
//	);
//	Snowlvl1_palette snow1palette(
//			.index(rom_q_snow1),
//			.red(Red_Snow1),
//			.green(Green_Snow1),
//			.blue(Blue_Snow1)
//		);
//
//////////////////////////////////////////////////////////////Snow2
//logic [3:0] Red_Snow2, Green_Snow2, Blue_Snow2;
//	Snowlvl2_rom snow2rom(
//			.clock(pixel_clk),
//			.address(rom_address_snow2),
//			.q(rom_q_snow2)
//	);
//	Snowlvl2_palette snow2palette(
//			.index(rom_q_snow2),
//			.red(Red_Snow2),
//			.green(Green_Snow2),
//			.blue(Blue_Snow2)
//		);
//
/////////////////////////////////////////////////////////////Snow3
//logic [3:0] Red_Snow3, Green_Snow3, Blue_Snow3;
//	Snowlvl3_rom snow3rom(
//			.clock(pixel_clk),
//			.address(rom_address_snow3),
//			.q(rom_q_snow3)
//	);
//	Snowlvl3_palette snow3palette(
//			.index(rom_q_snow3),
//			.red(Red_Snow3),
//			.green(Green_Snow3),
//			.blue(Blue_Snow3)
//		);
//
/////////////////////////////////////////////////////////////endscreen
//logic [3:0] Red_End, Green_End, Blue_End;
//	EndScreen_rom endscreenrom(
//			.clock(pixel_clk),
//			.address(rom_address_end),
//			.q(rom_q_end)
//	);
//	EndScreen_palette endscreenpalette(
//			.index(rom_q_end),
//			.red(Red_End),
//			.green(Green_End),
//			.blue(Blue_End)
//		);
//
////unique case for choosing background display 
//always_comb
//	begin
//		unique case(background_number)
//			
//			//start screen
//			10'b00_0000_0001:
//				begin	
//					palette_blue = Blue_Start;
//					palette_green = Green_Start;
//					palette_red = Red_Start;
//				end
//			
//			//Green1
//			10'b00_0000_0010:	
//				begin
//					palette_blue = Blue_Green1;
//					palette_green = Green_Green1;
//					palette_red = Red_Green1;
//				end
//			
//			//Green2
//			10'b00_0000_0100:	
//				begin	
//					palette_blue = Blue_Green2;
//					palette_green = Green_Green2;
//					palette_red = Red_Green2;
//				end	
//			//Gutter1
//			10'b00_0000_1000:	
//				begin	
//					palette_blue = Blue_Gutter1;
//					palette_green = Green_Gutter1;
//					palette_red =Red_Gutter1;
//				end
//			//Gutter2
//			10'b00_0001_0000:	
//				begin
//					palette_blue = Blue_Gutter2;
//					palette_green = Green_Gutter2;
//					palette_red = Red_Gutter2;
//				end
//			//Gutter3
//			10'b00_0010_0000:	
//				begin
//					palette_blue =  Blue_Gutter3;
//					palette_green = Green_Gutter3;
//					palette_red = Red_Gutter3;
//				end
//			//Snow1
//			10'b00_0100_0000:	
//				begin
//					palette_blue = Blue_Snow1;
//					palette_green = Green_Snow1;
//					palette_red = Red_Snow1;
//				end
//			//Snow2
//			10'b00_1000_0000:	
//				begin
//					palette_blue = Blue_Snow2;
//					palette_green = Green_Snow2;
//					palette_red = Red_Snow2;
//				end
//			//Snow3
//			10'b01_0000_0000:	
//				begin
//					palette_blue = Blue_Snow3;
//					palette_green = Green_Snow3;
//					palette_red = Red_Snow3;
//				end
//			//EndScreen
//			10'b10_0000_0000:
//				begin
//					palette_blue = Blue_End;
//					palette_green = Green_End;
//					palette_red = Red_End;
//				end
//				
//			
//		endcase
//	   
//end

	

    
endmodule
