//module wind_cycle(
//);
//
//enum logic [2:0] {calm,
//						weak_l,
//						strong_l,
//						weak_r,
//						strong_r
//						} state, next_state;
//						
//logic [2:0] place;
//
//always_ff @ (posedge CLK)
//	begin
//		if (reset)
//			state <= calm; //restart
//			place <= 0;
//		else
//			state <= next_state;
//	end
//	
//always_comb
//	begin
//		unique case (state)
//			calm:
//				begin
//					if ((place == 0) && (wind_state == 1) && (wind_count == 5))
//						begin
//							next_state <= weak_l;
//							place <= place + 1;
//						end
//					else if ((place == 1) && (wind_state == 1) && (wind_count == 5))
//						begin
//							next_state <= strong_l;
//							place <= place + 1;
//						end
//					else if ((place == 2) && (wind_state == 1) && (wind_count == 5))
//						begin
//							next_state <= calm;
//							place <= place + 1;
//						end
//					else if ((place == 3) && (wind_state == 1) && (wind_count == 5))
//						begin
//							next_state <= weak_r;
//							place <= place + 1;
//						end
//					else if ((place == 4) && (wind_state == 1) && (wind_count == 5))
//						begin
//							next_state <= strong_r;
//							place <= place + 1;
//						end
//					else if (wind_state == 0) || ((place == 5) && (wind_state == 1) && (wind_count == 5)))
//						begin
//							next_state <= calm;
//							place <= 0;
//						end
//					else
//						next_state = calm_1;
//				end
//			weak_l:
//				begin
//					if ((wind_state == 1) && (wind_count == 5))
//						begin
//							next_state = calm;
//						end
//					else if (wind_state == 0)
//						begin
//							next_state <= calm;
//							place <= 0;
//						end
//					else
//						next_state = weak_1;
//				end
//			strong_l:
//				begin
//					if ((wind_state ==1) && (wind_count == 5))
//						begin
//							next_state = calm;
//						end
//					else
//						next_state = strong_1;
//				end
//			weak_r:
//				begin
//					if ((wind_state ==1) && (wind_count == 5))
//						begin
//							next_state = calm;
//						end
//					else
//						next_state = weak_r;
//				end
//			strong_r:
//				begin
//					if ((wind_state ==1) && (wind_count == 5))
//						begin
//							next_state = calm;
//						end
//					else
//						next_state = strong_r;
//				end
//		endcase
//		
//		unique case (state)
//			calm_1:
//				begin
//				end
//			weak_l:
//				begin
//				end
//			strong_l:
//				begin
//				end
//			calm_2:
//			weak_r:
//				begin
//				end
//			strong_r:
//				begin
//				end
//		endcase
//	end
//
//endmodule
