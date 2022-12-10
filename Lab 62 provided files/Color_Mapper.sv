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
	  
    int DistX, DistY;
	 assign DistX = DrawX - BallX;
    assign DistY = DrawY - BallY;
    assign Size = Ball_size;
	 

		  
	
	
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
	  
    int Size;
	  
    always_comb
    begin:Ball_on_proc
        if ((DrawX >= (BallX)) &&
				(DrawX <= (BallX + Size)) &&
				(DrawY >= (BallY)) &&
				(DrawY <= (BallY + Size))) 
            ball_on = 1'b1;
        else 
            ball_on = 1'b0;
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
					Red <= 8'hff; 
					Green <= 8'he;
					//Blue = 8'h7f - DrawX[9:3];
					Blue <= 8'haa;
				end
					     
	end
	
/////////////////////////////////////////////////////////////////////////////////////RGB End ^	
	
	
	
	
/////////////////////////////////////////////////////////////////////////////
//background assignments 	


logic [18:0] rom_address, rom_address_start, rom_address_green1, 
rom_address_green2, rom_address_green3,rom_address_leaf1, rom_address_leaf2, rom_address_leaf3, 
rom_address_end;

logic [8:0] rom_q, rom_q_start, rom_q_green1, rom_q_green2,rom_q_green3,
rom_q_leaf1, rom_q_leaf2, rom_q_leaf3, rom_q_end;	
logic [3:0] palette_red, palette_green, palette_blue;	

//assign rom_address = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address = (DrawX*210/640) + (DrawY*234/480 * 210);
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


//
//assign rom_address_start = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_green1 = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_green2 = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_green3 = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_leaf1 = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_leaf2 = (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_leaf3= (DrawX*420/640) + (DrawY*465/480 * 420);
//assign rom_address_end = (DrawX*420/640) + (DrawY*465/480 * 420);


//assign rom_address_start = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_green1 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_green2 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_green3 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_leaf1 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_leaf2 = (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_leaf3= (DrawX*105/640) + (DrawY*117/480 * 105);
//assign rom_address_end = (DrawX*105/640) + (DrawY*117/480 * 105);



assign rom_address_start = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_green1 = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_green2 = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_green3 = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_leaf1 = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_leaf2 = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_leaf3 = (DrawX*210/640) + (DrawY*234/480 * 210);
assign rom_address_end = (DrawX*210/640) + (DrawY*234/480 * 210);

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
		
///////////////////////////////////////////////////////Green3
logic [3:0] Red_Green3, Green_Green3, Blue_Green3;
	Greenlvl3_rom green3rom(
			.clock(pixel_clk),
			.address(rom_address_green3),
			.q(rom_q_green3)
	);
		Greenlvl3_palette green3palette(
			.index(rom_q_green3),
			.red(Red_Green3),
			.green(Green_Green3),
			.blue(Blue_Green3)
		);		
		
		
///////////////////////////////////////////////////////////leaf1
logic [3:0] Red_leaf1, Green_leaf1, Blue_leaf1;
	leafy1_rom leaf1rom(
			.clock(pixel_clk),
			.address(rom_address_leaf1),
			.q(rom_q_leaf1)
	);
	leafy1_palette leaf1palette(
			.index(rom_q_leaf1),
			.red(Red_leaf1),
			.green(Green_leaf1),
			.blue(Blue_leaf1)
		);
		
///////////////////////////////////////////////////////////leaf2		
logic [3:0] Red_leaf2, Green_leaf2, Blue_leaf2;
	leafy2_rom leaf2rom(
			.clock(pixel_clk),
			.address(rom_address_leaf2),
			.q(rom_q_leaf2)
	);
	leafy2_palette leaf2palette(
			.index(rom_q_leaf2),
			.red(Red_leaf2),
			.green(Green_leaf2),
			.blue(Blue_leaf2)
		);

///////////////////////////////////////////////////////////leaf3		
logic [3:0] Red_leaf3, Green_leaf3, Blue_leaf3;
	leafy3_rom leaf3rom(
			.clock(pixel_clk),
			.address(rom_address_leaf3),
			.q(rom_q_leaf3)
	);
	leafy3_palette leaf3palette(
			.index(rom_q_leaf3),
			.red(Red_leaf3),
			.green(Green_leaf3),
			.blue(Blue_leaf3)
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
				//Green3
			10'b00_0000_1000:	
				begin	
					palette_blue = Blue_Green2;
					palette_green = Green_Green2;
					palette_red = Red_Green2;
				end		
			//Leaf1
			10'b00_0001_0000:	
				begin	
					palette_blue = Blue_leaf1;
					palette_green = Green_leaf1;
					palette_red =Red_leaf1;
				end
			//Leaf2
			10'b00_0010_0000:	
				begin
					palette_blue = Blue_leaf2;
					palette_green = Green_leaf2;
					palette_red = Red_leaf2;
				end
			//Leaf3
			10'b00_0100_0000:	
				begin
					palette_blue =  Blue_leaf3;
					palette_green = Green_leaf3;
					palette_red = Red_leaf3;
				end
			//EndScreen
			10'b00_1000_0000:
				begin
					palette_blue = Blue_End;
					palette_green = Green_End;
					palette_red = Red_End;
				end
				
			
		endcase
	   
end

	

    
endmodule