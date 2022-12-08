module back_controller(input [7:0] keycode0, keycode1,
							  input CLK,
							  input reset, ts_colide, bs_collide,
							  output logic [3:0] tracker,
							  output logic [10:0] background_number, //used by color mapper to change backgrounds							 
							  output [3:0] HEXstate
);

		enum logic [5:0] {StartScreen,
							Green1,
							Green2,
							Gutter1,
							Gutter2, 
							Gutter3,
							Snow1,
							Snow2,
							Snow3,
							EndScreen
							}	state, next_state;
							
		always_ff @ (posedge CLK)
		begin
				if(background_number == 10'b00_0000_0000)
						tracker <= 0; 
				else if (ts_colide)
					tracker <= tracker + 1; 
				else if(bs_collide)
					tracker <= tracker -1;
				else 
					tracker <= tracker;
		end
		

					
							
		always_ff @ (posedge CLK)
		begin
				if (reset)
					state <= StartScreen; //if reset, go to start screen
				else
					state <= next_state;
		end
		

			always_comb
		begin 
				// Default next state is staying at current state
				next_state = state;
				
				// Default controls signal values

				background_number = 10'h0;
		
					
			//assing next state
			unique case(state)

			StartScreen:	
			//maybe tracker ==0
				if((keycode0 == 8'h2C)) //space
					next_state = Green1;		
				else
					next_state = StartScreen;	

			Green1:
				if((tracker == 1) || (keycode0 == 8'h1e))	//1
					next_state = Green2;					
				else					
					next_state = Green1;
				

			Green2:
				if((tracker == 2) || (keycode0 == 8'h1f)) //2
					next_state = Gutter2;
					
				else if((tracker == 1))
					next_state = Green1;
				
				else
					next_state = Green2;
				
			Gutter1:
				if((tracker == 3) || (keycode0 == 8'h20))  //3
					next_state = Gutter2;
					
				else if((tracker == 2))
					next_state = Green2;
					
				else
					next_state = Gutter1;
					

			Gutter2:
				if((tracker == 4) || (keycode0 == 8'h21)) //4
					next_state = Gutter3;
					
				else if((tracker == 3))
					next_state = Gutter1;
					
				else
					next_state = Gutter2;
				
			Gutter3:
				if((tracker == 5) || (keycode0 == 8'h22))  //5
					next_state = Snow1;
					
				else if((tracker == 4))
					next_state = Gutter2;
					
				else
					next_state = Gutter3;
					
			Snow1:
				if((tracker == 6) || (keycode0 == 8'h23))  //6
					next_state = Snow2;
					
				else if((tracker == 5))
					next_state = Gutter3;
					
				else
					next_state = Snow1;
				
			Snow2:
				if((tracker == 7) || (keycode0 == 8'h24))  //7
					next_state = Snow3;
					
				else if((tracker == 6))
					next_state = Snow1;
					
				else
					next_state = Snow2;
				
			Snow3:
				if((tracker == 8) || (keycode0 == 8'h25)) //8
					next_state = EndScreen;
					
				else if((tracker == 7))
					next_state = Snow2;
					
				else
					next_state = Snow3;
				
			EndScreen:	
				if((keycode0 == 8'h15)) //r
						next_state = StartScreen;			
				else
					next_state = EndScreen;
					
			endcase


			unique case(state)

			StartScreen:
				begin
					background_number[0] = 1'b1; //00-0000-0001 is startscreen
					HEXstate = 4'b0000; //0
				end
			Green1:
				begin
					background_number[1] = 1'b1; //00-0000-0010 
					HEXstate = 4'b0001; //1
				end
				
			Green2:
				begin
					background_number[2] = 1'b1; //00-0000-0100 
					HEXstate = 4'b0010; //2
				end

			Gutter1:		
				begin
					background_number[3] = 1'b1; //00-0000-1000
					HEXstate = 4'b0011; //3
				end
				
			Gutter2:		
				begin
					background_number[4] = 1'h1; //00-0001-0000
					HEXstate = 4'b0100; //4
				end
				
			Gutter3:		
				begin
					background_number[5] = 1'h1; //00-0010-0000
					HEXstate = 4'b0101; //5
				end
				
			Snow1:		
				begin
					background_number[6] = 1'h1; //00-0100-0000
					HEXstate = 4'b0110; //6
				end
				
			Snow2:		
				begin
					background_number[7] = 1'h1; //00-1000-0000
					HEXstate = 4'b0111; //7
				end
				
			Snow3:		
				begin
					background_number[8] = 1'h1; //01-0000-0000
					HEXstate = 4'b1000; //8
				end
				
			EndScreen:		
				begin
					background_number[9] = 1'h1; //10-0000-0000
					HEXstate = 4'b1001; //9
				end
				
			default :
				begin
					background_number = 10'h0; 
					HEXstate = 4'b1010; //A
				end	
	
			endcase		
				
		end

	endmodule
				