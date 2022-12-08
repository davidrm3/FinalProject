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
							  output logic top_next, //used for next level
							  output logic bot_back, //used for falling back to old level
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
	
//procs for backgrounds	 
    always_comb
    begin:StartScreen_on_proc
        if (background && background_number[0]) 
            StartScreen_on = 1'b1;
        else 
            StartScreen_on = 1'b0;
     end 
/////////////////	  
    always_comb
    begin:Green1_on_proc
        if (background && background_number[1]) 
            Green1_on = 1'b1;
        else 
            Green1_on = 1'b0;
     end 	
//////////////
    always_comb
    begin:Green2_on_proc
        if (background && background_number[2]) 
            Green2_on = 1'b1;
        else 
            Green2_on = 1'b0;
     end 	
/////////////////
    always_comb
    begin:Gutter1_on_proc
        if (background && background_number[3]) 
            Gutter1_on = 1'b1;
        else 
            Gutter1_on = 1'b0;
     end 
////////////////
    always_comb
    begin:Gutter2_on_proc
        if (background && background_number[4]) 
            Gutter2_on = 1'b1;
        else 
            Gutter2_on = 1'b0;
     end 	
//////////////// 	 
    always_comb
    begin:Gutter3_on_proc
        if (background && background_number[5]) 
            Gutter3_on = 1'b1;
        else 
            Gutter3_on = 1'b0;
     end  
////////////////
    always_comb
    begin:Snow1_on_proc
        if (background && background_number[6]) 
            Snow1_on = 1'b1;
        else 
            Snow1_on = 1'b0;
     end 
//////////////////
  always_comb
    begin:Snow2_on_proc
        if (background && background_number[7]) 
            Snow2_on = 1'b1;
        else 
            Snow2_on = 1'b0;
     end 	
//////////////////
  always_comb
    begin:Snow3_on_proc
        if (background && background_number[8]) 
            Snow3_on = 1'b1;
        else 
            Snow3_on = 1'b0;
     end 
////////////////////
  always_comb
    begin:EndScreen_on_proc
        if (background && background_number[9]) 
            EndScreen = 1'b1;
        else 
            EndScreen = 1'b0;
     end   
	 
	 
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

////background signal
//	 always_comb
//    begin:Background_on_proc
//        if ((background)) 
//            background_on = 1'b1;
//        else 
//            background_on = 1'b0;
//     end   
//	  
	  
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
	   
	  

    always_ff @ (posedge pixel_clk)
    begin:RGB_Display
	 //
		  if(~blank)
		  begin
            Red <= 8'h00;
            Green <= 8'h00;
            Blue <= 8'h00;				
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
				
		//plat left 1
			else if(G_platLeft_on == 1'b1 )
			  begin          
					
					Red <= 8'hff;
					Green <= 8'h00;
					Blue <= 8'hfe;
					//defaultColor = 4'b1001; //nine
				end			
				
			//plat right 1
			else if(G_platRight_on == 1'b1 )
			  begin          
					
					Red <= 8'hff;
					Green <= 8'h00;
					Blue <= 8'hfe;
					//defaultColor = 4'b1001; //nine
				end		
				
				//plat bottom 1
			else if(G_platBottom_on == 1'b1 )
			  begin          
					
					Red <= 8'h33;
					Green <= 8'h55;
					Blue <= 8'hee;
					//defaultColor = 4'b1001; //nine
				end		
				
				//plat float 1
			else if(G_platFloat_on == 1'b1 )
			  begin          
					
					Red <= 8'hff;
					Green <= 8'hcc;
					Blue <= 8'h33;
					//defaultColor = 4'b1001; //nine
				end		
					
				
				
			//new else if	
				
				
				
		  //background color 
        else if(background_on == 1'b1 )
        begin          
				
				Red <= palette_red;
				Green <= palette_green;
				Blue <= palette_blue; 
				//defaultColor = 4'b1001; //nine
			end		
				

				
			else
				begin
					Red <= 8'hff; 
					Green <= 8'hff;
					//Blue = 8'h7f - DrawX[9:3];
					Blue <= 8'hff;
				end
					     
	end
	
	
	
	
	
	
/////////////////////////////////////////////////////////////////////////////
//background assignments 	


logic [18:0] rom_address;
logic [8:0] rom_q;	
logic [3:0] palette_red, palette_green, palette_blue;	

assign rom_address = (DrawX*420/640) + (DrawY*465/480 * 420);


/////////////////////////////////////////////////////////
logic [3:0] Red_Start, Green_Start, Blue_Start;
	StartScreen_rom startrom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	StartScreen_palette startpalette(
			index(),
			red(),
			green(),
			blue()
		);


///////////////////////////////////////////////////////
logic [3:0] Red_Green1, Green_Green1, Blue_Green1;
		Greenlvl1_rom green1rom (
			.clock   (pixel_clk),
			.address (rom_address),
			.q       (rom_q)
		);

		Greenlvl1_palette green1palette (
			.index (rom_q),
			.red   (palette_red),
			.green (palette_green),
			.blue  (palette_blue)
		);

///////////////////////////////////////////////////////
logic [3:0] Red_Green2, Green_Green2, Blue_Green2;
	Greenlvl2_rom green2rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
		Greenlvl2_palette green2palette(
			index(),
			red(),
			green(),
			blue()
		);

///////////////////////////////////////////////////////////
logic [3:0] Red_Gutter1, Green_Gutter1, Blue_Gutter1;
	Gutterslvl1_rom gutter1rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	Gutterslvl1_palette gutter1palette(
			index(),
			red(),
			green(),
			blue()
		);

/////////////////////////////////////////////////////////////
logic [3:0] Red_Gutter2, Green_Gutter2, Blue_Gutter2;
	Gutterslvl2_rom gutter2rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	Gutterslvl2_palette gutter2palette(
			index(),
			red(),
			green(),
			blue()
		);

////////////////////////////////////////////////////////////
logic [3:0] Red_Gutter3, Green_Gutter3, Blue_Gutter3;
	Gutterslvl3_rom gutter3rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	Gutterslvl3_palette gutter3palette(
			index(),
			red(),
			green(),
			blue()
		);

////////////////////////////////////////////////////////////
logic [3:0] Red_Snow1, Green_Snow1, Blue_Snow1;
	Snowlvl1_rom snow1rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	Snowlvl1_palette snow1palette(
			index(),
			red(),
			green(),
			blue()
		);

////////////////////////////////////////////////////////////
logic [3:0] Red_Snow2, Green_Snow2, Blue_Snow2;
	Snowlvl2_rom snow2rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	Snowlvl2_palette snow2palette(
			index(),
			red(),
			green(),
			blue()
		);

///////////////////////////////////////////////////////////
logic [3:0] Red_Snow3, Green_Snow3, Blue_Snow3;
	Snowlvl3_rom snow3rom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	Snowlvl3_palette snow3palette(
			index(),
			red(),
			green(),
			blue()
		);

///////////////////////////////////////////////////////////
logic [3:0] Red_End, Green_End, Blue_End;
	EndScreen_rom endscreenrom(
			.clock(pixel_clk),
			.address(rom_address),
			.q(rom_q)
	);
	EndScreen_palette endscreenpalette(
			index(),
			red(),
			green(),
			blue()
		);

//unique case for choosing background display 
always_comb
	begin
		unique case(background_number) 
			
			10'b00_0000_0001:
			pallete red pallet snow red =
			
			10'b00_0000_0010:			
			
			10'b00_0000_0100:
			
			10'b00_0000_1000:
			
			10'b00_0001_0000:
			
			10'b00_0010_0000:
			
			10'b00_0100_0000:
			
			10'b00_1000_0000:
			
			10'b01_0000_0000:
			
			10'b10_0000_0000:
				
		endcase
	   
end

	

    
endmodule
