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
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on;
	 
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
		  
		  
	 
	  
    int Size;
    assign Size = Ball_size;
	  
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
       
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1)) 
        begin 
            Red = 8'hff;
            Green = 8'h55;
            Blue = 8'h00;
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
        else 
        begin 
            Red = 8'h00; 
            Green = 8'h00;
            Blue = 8'h7f - DrawX[9:3];
        end      
    end 
    
endmodule
