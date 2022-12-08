module back_controller(input [7:0] keycode0, keycode1,
							  input CLK,
							  input reset,
							  input top_reached_signal,
							  input bot_reached_signal,
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
				if(~(keycode0 == 8'h2C))
						next_state = StartScreen;		
				else
					next_state = Green1;	

			Green1:
				if(top_reached_signal || (keycode0 == 8'h1D))		
					next_state = Green2;
					
				else
					next_state = Green1;
				

			Green2:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = Gutter1;
					
				else if(bot_reached_signal)
					next_state = Green1;
				
				else
					next_state = Green2;
				
			Gutter1:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = Gutter2;
					
				else if(bot_reached_signal)
					next_state = Green2;
					
				else
					next_state = Gutter1;
					

			Gutter2:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = Gutter3;
					
				else if(bot_reached_signal)
					next_state = Gutter1;
					
				else
					next_state = Gutter2;
				
			Gutter3:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = Snow1;
					
				else if(bot_reached_signal)
					next_state = Gutter2;
					
				else
					next_state = Gutter3;
					
			Snow1:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = Snow2;
					
				else if(bot_reached_signal)
					next_state = Gutter3;
					
				else
					next_state = Snow1;
				
			Snow2:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = Snow3;
					
				else if(bot_reached_signal)
					next_state = Snow1;
					
				else
					next_state = Snow2;
				
			Snow3:
				if(top_reached_signal || (keycode0 == 8'h1D))
					next_state = EndScreen;
					
				else if(bot_reached_signal)
					next_state = Snow2;
					
				else
					next_state = Snow3;
				
			EndScreen:	
				if(~(keycode0 == 8'h2C))
						next_state = EndScreen;		
				else
					next_state = StartScreen;	
					
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
				