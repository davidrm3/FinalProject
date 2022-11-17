module counter(input RESET,
					input CLK,
					input count_en,
					input max,
					output [31:0] count
);

logic [31:0] count_next;

always_ff @(posedge CLK)
begin
	count <= count_next;
end

always_comb
begin
	if(count == max)
		count_next = count;
	else
		count_next = count + 1;
end

//always_ff @(posedge CLK)
//begin
//	if (RESET)
//		begin
//			count <= 0;
//		end
//	else if ((count_en == 1) && (count < max+1)) // ensures jump is finite
//		begin
//			count <= count + 1;
//		end
//end

endmodule