module EndScreen_rom (
	input logic clock,
	input logic [17:0] address,
	output logic [3:0] q
);

logic [3:0] memory [0:195299] /* synthesis ram_init_file = "C:\Users\David\Desktop\ECE385\Final\Lab_6\levels\End\EndScreen.mif" */;

always_ff @ (posedge clock) begin
	q <= memory[address];
end

endmodule
