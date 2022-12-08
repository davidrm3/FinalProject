module counter  (input RESET,
					input CLK,
					input enable,
					input [31:0] max,
					input [31:0] multi,
					output [31:0] sec
);

logic [31:0] count;

always_ff @(posedge CLK)
begin
	if (RESET)
		begin
			sec <= 0;
			count <= 0;
		end
	else if ((!enable) && (count < (1 * multi)))
		begin
			count <= 0;
		end
	else if ((enable == 1) && (count < (1 * multi)))
		begin
			count <= count + 1;
		end
	
	else if ((count >= (1 * multi)) && (sec < max+1))
		begin
			sec <= sec + 1;
			count <= 0;
		end
end

endmodule