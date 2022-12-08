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
	 
	 
	 //orginal platform coordinates
	logic [10:0] shape_x = 270;
	logic [10:0] shape_size_x = 100;
	logic [10:0] shape_y = 300;
	logic [10:0] shape_size_y = 16;	
	
	assign platform = DrawX >= shape_x && DrawX < shape_x + shape_size_x && 
	DrawY >= shape_y && DrawY < shape_y + shape_size_y;
	
	
	
	//green level 1 map shapes
	
		//plat left 1 start
		logic G_platLeft_on;
		
		logic [10:00] G_platLeft_x = 110;
		logic [10:00] G_platLeft_size_x = 100;
		logic [10:00] G_platLeft_y = 240;
		logic [10:00] G_platLeft_size_y = 167;
		
		assign G_platLeft = DrawX >= G_platLeft_x && DrawX < G_platLeft_x + G_platLeft_size_x && 
		DrawY >= G_platLeft_y && DrawY < G_platLeft_y + G_platLeft_size_y;
		
		 always_comb
		 begin:G_PlatformLeft_on_proc
			  if ((G_platLeft)) 
					G_platLeft_on = 1'b1;
			  else 
					G_platLeft_on = 1'b0;
		  end 
		 //plat left 1 end 
		 
		 
/////////////////////////
////////////////////////
			
		//plat right 1 start
		logic G_platRight_on;
		
		logic [10:00] G_platRight_x = 432;
		logic [10:00] G_platRight_size_x = 101;
		logic [10:00] G_platRight_y = 240;
		logic [10:00] G_platRight_size_y = 167;
		
		assign G_platRight = DrawX >= G_platRight_x && DrawX < G_platRight_x + G_platRight_size_x && 
		DrawY >= G_platRight_y && DrawY < G_platRight_y + G_platRight_size_y;
		
		 always_comb
		 begin:G_PlatformRight_on_proc
			  if ((G_platRight)) 
					G_platRight_on = 1'b1;
			  else 
					G_platRight_on = 1'b0;
		  end 
		  //plat right 1 end
		  
		  
//////////////////////
//////////////////////


		//plat bottom 1 start
		logic G_platBottom_on;
		
		logic [10:00] G_platBottom_x = 110;
		logic [10:00] G_platBottom_size_x = 423;
		logic [10:00] G_platBottom_y = 407;
		logic [10:00] G_platBottom_size_y = 50;
		
		assign G_platBottom = DrawX >= G_platBottom_x && DrawX < G_platBottom_x + G_platBottom_size_x && 
		DrawY >= G_platBottom_y && DrawY < G_platBottom_y + G_platBottom_size_y;
		
		 always_comb
		 begin:G_PlatformBottom_on_proc
			  if ((G_platBottom)) 
					G_platBottom_on = 1'b1;
			  else 
					G_platBottom_on = 1'b0;
		  end 
		  //plat bottom 1 end	
	


////////////////////////
////////////////////////	

		//plat float 1 start
		logic G_platFloat_on;
		
		logic [10:00] G_platFloat_x = 265;
		logic [10:00] G_platFloat_size_x = 113;
		logic [10:00] G_platFloat_y = 80;
		logic [10:00] G_platFloat_size_y = 50;
		
		assign G_platFloat = DrawX >= G_platFloat_x && DrawX < G_platFloat_x + G_platFloat_size_x && 
		DrawY >= G_platFloat_y && DrawY < G_platFloat_y + G_platFloat_size_y;
		
		 always_comb
		 begin:G_PlatformFloat_on_proc
			  if ((G_platFloat)) 
					G_platFloat_on = 1'b1;
			  else 
					G_platFloat_on = 1'b0;
		  end 
		  //plat bottom 1 end	
		  
		  
		  

		  
	
	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////	
//background assignments	
	
	assign background = DrawX >=110 && DrawX <= 532 && DrawY >= 0 && DrawY <= 480;
	
	logic StartScreen_on, Green1_on, Green2_on, Gutter1_on, Gutter2_on, Gutter3_on, Snow1_on, Snow2_on, Snow3_on, EndScreen_on;
	
//procs for backgrounds	 

	 
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
	  
	  
	 always_comb
    begin:Platform_on_proc
        if ((platform)) 
            platform_on = 1'b1;
        else 
            platform_on = 1'b0;
     end  

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
		  
		//platform color of lime green  
		  else if((platform_on == 1'b1))
				begin
					Red <= 8'hcc;
					Green <= 8'hbb;
					Blue <= 8'hbb;
				//	platdebug =  4'b0010; //2
					
				end
				
		//plat left 1 pink
			else if(G_platLeft_on == 1'b1 )
			  begin          
					
					Red <= 8'hff;
					Green <= 8'h00;
					Blue <= 8'hfe;
					//defaultColor = 4'b1001; //nine
				end			
				
			//plat right 1 pink
			else if(G_platRight_on == 1'b1 )
			  begin          
					
					Red <= 8'hff;
					Green <= 8'h00;
					Blue <= 8'hfe;
					//defaultColor = 4'b1001; //nine
				end		
				
			
				//plat float 1 yellow
			else if(G_platFloat_on == 1'b1 )
			  begin          
					
					Red <= 8'hff;
					Green <= 8'hcc;
					Blue <= 8'h33;
					//defaultColor = 4'b1001; //nine
				end		
					
				
				
			//top line
		  else if ((topline_on == 1'b1)) 
        begin 
            Red <= 8'h55;
            Green <= 8'hdd;
            Blue <= 8'hff;
			//	balldebug = 4'b0001; //1
        end
		//bot line
		  else if ((topline_on == 1'b1)) 
        begin 
            Red <= 8'h55;
            Green <= 8'hdd;
            Blue <= 8'hff;
			//	balldebug = 4'b0001; //1
        end		
		  
		 	//plat bottom 1 blue
			else if(G_platBottom_on == 1'b1 )
			  begin          
					
					Red <= 8'h33;
					Green <= 8'h55;
					Blue <= 8'hee;
					//defaultColor = 4'b1001; //nine
				end		
				 
				
			//new else if	
				
				
				
		  //side color 
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
assign rom_address = (DrawX*105/640) + (DrawY*117/480 * 105);
//Test checker

//hGreenlvl1_rom greenlvl1rom (
//	.clock   (pixel_clk),
//	.address (rom_address),
//	.q       (rom_q)
//);
//
//hGreenlvl1_palette greenlvl1palette (
//	.index (rom_q),
//	.red   (palette_red),
//	.green (palette_green),
//	.blue  (palette_blue)
//);

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




//emf test checker


assign rom_address_start= (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_green1 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_green2 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_gutter1 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_gutter2 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_gutter3= (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_snow1 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_snow2 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_snow3 = (DrawX*105/640) + (DrawY*117/480 * 105);
assign rom_address_end = (DrawX*105/640) + (DrawY*117/480 * 105);

/////////////////////////////////////////////////////// Star
logic [3:0] Red_Start, Green_Start, Blue_Start;
	StartScreen_rom startrom(
			.clock(pixel_clk),
			.address(rom_address_start),
			.q(rom_q_start)
	);
	StartScreen_palette startpalette(
			.index(rom_q_start),
			.red(Red_Start),
			.green(Green_Start),
			.blue(Blue_Start)
		);


///////////////////////////////////////////////////////Green1
logic [3:0] Red_Green1, Green_Green1, Blue_Green1;
		Greenlvl1_rom green1rom (
			.clock   (pixel_clk),
			.address (rom_address_green1),
			.q       (rom_q_green1)
		);

		Greenlvl1_palette green1palette (
			.index (rom_q_green1),
			.red   (Red_Green1),
			.green (Green_Green1),
			.blue  (Blue_Green1)
		);

///////////////////////////////////////////////////////Green2
logic [3:0] Red_Green2, Green_Green2, Blue_Green2;
	Greenlvl2_rom green2rom(
			.clock(pixel_clk),
			.address(rom_address_green2),
			.q(rom_q_green2)
	);
		Greenlvl2_palette green2palette(
			.index(rom_q_green2),
			.red(Red_Green2),
			.green(Green_Green2),
			.blue(Blue_Green2)
		);

///////////////////////////////////////////////////////////Gutter1
logic [3:0] Red_Gutter1, Green_Gutter1, Blue_Gutter1;
	Gutterslvl1_rom gutter1rom(
			.clock(pixel_clk),
			.address(rom_address_gutter1),
			.q(rom_q_gutter1)
	);
	Gutterslvl1_palette gutter1palette(
			.index(rom_q_gutter1),
			.red(Red_Gutter1),
			.greenGreen_Gutter1(),
			.blue(Blue_Gutter1)
		);

/////////////////////////////////////////////////////////////Gutter2
logic [3:0] Red_Gutter2, Green_Gutter2, Blue_Gutter2;
	Gutterslvl2_rom gutter2rom(
			.clock(pixel_clk),
			.address(rom_address_gutter2),
			.q(rom_q_gutter2)
	);
	Gutterslvl2_palette gutter2palette(
			.index(rom_q_gutter2),
			.red(Red_Gutter2),
			.green(Green_Gutter2),
			.blue(Blue_Gutter2)
		);

////////////////////////////////////////////////////////////Gutter3
logic [3:0] Red_Gutter3, Green_Gutter3, Blue_Gutter3;
	Gutterslvl3_rom gutter3rom(
			.clock(pixel_clk),
			.address(rom_address_gutter3),
			.q(rom_q_gutter3)
	);
	Gutterslvl3_palette gutter3palette(
			.index(rom_q_gutter3),
			.red(Red_Gutter3),
			.green(Green_Gutter3),
			.blue(Blue_Gutter3)
		);

////////////////////////////////////////////////////////////Snow1
logic [3:0] Red_Snow1, Green_Snow1, Blue_Snow1;
	Snowlvl1_rom snow1rom(
			.clock(pixel_clk),
			.address(rom_address_snow1),
			.q(rom_q_snow1)
	);
	Snowlvl1_palette snow1palette(
			.index(rom_q_snow1),
			.red(Red_Snow1),
			.green(Green_Snow1),
			.blue(Blue_Snow1)
		);

////////////////////////////////////////////////////////////Snow2
logic [3:0] Red_Snow2, Green_Snow2, Blue_Snow2;
	Snowlvl2_rom snow2rom(
			.clock(pixel_clk),
			.address(rom_address_snow2),
			.q(rom_q_snow2)
	);
	Snowlvl2_palette snow2palette(
			.index(rom_q_snow2),
			.red(Red_Snow2),
			.green(Green_Snow2),
			.blue(Blue_Snow2)
		);

///////////////////////////////////////////////////////////Snow3
logic [3:0] Red_Snow3, Green_Snow3, Blue_Snow3;
	Snowlvl3_rom snow3rom(
			.clock(pixel_clk),
			.address(rom_address_snow3),
			.q(rom_q_snow3)
	);
	Snowlvl3_palette snow3palette(
			.index(rom_q_snow3),
			.red(Red_Snow3),
			.green(Green_Snow3),
			.blue(Blue_Snow3)
		);

///////////////////////////////////////////////////////////endscreen
logic [3:0] Red_End, Green_End, Blue_End;
	EndScreen_rom endscreenrom(
			.clock(pixel_clk),
			.address(rom_address_end),
			.q(rom_q_end)
	);
	EndScreen_palette endscreenpalette(
			.index(rom_q_end),
			.red(Red_End),
			.green(Green_End),
			.blue(Blue_End)
		);

//unique case for choosing background display 
always_comb
	begin
		unique case(background_number)
			
			//start screen
			10'b00_0000_0001:
				begin	
					palette_blue = Blue_Start;
					palette_green = Green_Start;
					palette_red = Red_Start;
				end
			
			//Green1
			10'b00_0000_0010:	
				begin
					palette_blue = Blue_Green1;
					palette_green = Green_Green1;
					palette_red = Red_Green1;
				end
			
			//Green2
			10'b00_0000_0100:	
				begin	
					palette_blue = Blue_Green2;
					palette_green = Green_Green2;
					palette_red = Red_Green2;
				end	
			//Gutter1
			10'b00_0000_1000:	
				begin	
					palette_blue = Blue_Gutter1;
					palette_green = Green_Gutter1;
					palette_red =Red_Gutter1;
				end
			//Gutter2
			10'b00_0001_0000:	
				begin
					palette_blue = Blue_Gutter2;
					palette_green = Green_Gutter2;
					palette_red = Red_Gutter2;
				end
			//Gutter3
			10'b00_0010_0000:	
				begin
					palette_blue =  Blue_Gutter3;
					palette_green = Green_Gutter3;
					palette_red = Red_Gutter3;
				end
			//Snow1
			10'b00_0100_0000:	
				begin
					palette_blue = Blue_Snow1;
					palette_green = Green_Snow1;
					palette_red = Red_Snow1;
				end
			//Snow2
			10'b00_1000_0000:	
				begin
					palette_blue = Blue_Snow2;
					palette_green = Green_Snow2;
					palette_red = Red_Snow2;
				end
			//Snow3
			10'b01_0000_0000:	
				begin
					palette_blue = Blue_Snow3;
					palette_green = Green_Snow3;
					palette_red = Red_Snow3;
				end
			//EndScreen
			10'b10_0000_0000:
				begin
					palette_blue = Blue_End;
					palette_green = Green_End;
					palette_red = Red_End;
				end
				
			
		endcase
	   
end

	

    
endmodule
