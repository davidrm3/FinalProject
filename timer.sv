module timer  (input RESET,
					input CLK,
					input enable,
					input [31:0] max,
					output [31:0] sec
);

logic [31:0] count;

always_ff @(posedge CLK)
begin
	if (RESET)
		begin
			count <= 0;
		end
	else if ((count_en == 1) && (count < 50000000))
		begin
			count <= count + 1;
		end
	else if ((count >= 50000000) && (sec <= max))
		begin
			count <= 0;
			sec == sec + 1;
		end
end

endmodule