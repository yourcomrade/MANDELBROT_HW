module dpram
#(parameter DATA_WIDTH = 8, ADDR_WIDTH = 6)
(
	input [(DATA_WIDTH-1):0] wdata_a, wdata_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] rdata_a, rdata_b
);


	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	always @ (posedge clk)
	begin // Port a
		if (we_a)
		begin
			ram[addr_a] <= wdata_a;
			rdata_a <= wdata_a;
		end
		else
			rdata_a <= ram[addr_a];
	end
	always @ (posedge clk)
	begin // Port b
		if (we_b)
		begin
			ram[addr_b] <= wdata_b;
			rdata_b <= wdata_b;
		end
		else
			rdata_b <= ram[addr_b];
	end
endmodule