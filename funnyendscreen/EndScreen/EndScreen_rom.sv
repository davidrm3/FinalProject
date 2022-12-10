module EndScreen_rom (
	input logic clock,
	input logic [15:0] address,
	output logic [3:0] q
);

logic [3:0] memory [0:49139] /* synthesis ram_init_file = "C:\Users\David\Downloads\Final\Lab_6\funnyendscreen\EndScreen\EndScreen.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
