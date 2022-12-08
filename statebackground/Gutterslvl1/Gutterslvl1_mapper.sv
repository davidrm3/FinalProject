module Gutterslvl1_mapper (
	input logic [9:0] DrawX, DrawY,
	input logic vga_clk, blank,
	output logic [3:0] red, green, blue
);

logic [14:0] rom_address;
logic [3:0] rom_q;

logic [3:0] palette_red, palette_green, palette_blue;

assign rom_address = (DrawX*105/640) + (DrawY*117/480 * 105);

always_ff @ (posedge vga_clk) begin
	red <= 4'h0;
	green <= 4'h0;
	blue <= 4'h0;

	if (blank) begin
		red <= palette_red;
		green <= palette_green;
		blue <= palette_blue;
	end
end

Gutterslvl1_rom Gutterslvl1_rom (
	.clock   (vga_clk),
	.address (rom_address),
	.q       (rom_q)
);

Gutterslvl1_palette Gutterslvl1_palette (
	.index (rom_q),
	.red   (palette_red),
	.green (palette_green),
	.blue  (palette_blue)
);

endmodule
