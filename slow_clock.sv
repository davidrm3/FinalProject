module slow_clk(
				input clk, reset,
				output logic sec
					);

logic [25:0] accum = 26'b0;
logic pps;
logic prepps; 

always_ff @(posedge clk)
begin
	if(reset)
		sec <= 1'b0;
	else
		begin
			accum <= accum +1;
			pps <= accum ==20_000_000;
			
			if(!prepps && pps)
				begin
					sec <= ~sec;
					accum <= 0;
				end
		end
end					
					
endmodule