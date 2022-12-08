module Snowlvl3_rom (
	input logic clock,
	input logic [13:0] address,
	output logic [2:0] q
);

logic [2:0] memory [0:12284] /* synthesis ram_init_file = "C:\Users\David\Desktop\ECE385\Final\Lab_6\statebackground\Snowlvl3\Snowlvl3.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
