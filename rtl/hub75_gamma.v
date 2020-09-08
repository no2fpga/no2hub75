/*
 * hub75_gamma.v
 *
 * vim: ts=4 sw=4
 *
 * Copyright (C) 2019-2020  Sylvain Munaut <tnt@246tNt.com>
 * SPDX-License-Identifier: CERN-OHL-W-2.0
 */

`default_nettype none

module hub75_gamma #(
	parameter IW = 8,
	parameter OW = 10
)(
	input  wire [IW-1:0] in,
	output wire [OW-1:0] out,
	input  wire enable,
	input  wire clk
);
	reg  [15:0] gamma_rom [0:255];
	wire [ 7:0] rd_addr;
	reg  [15:0] rd_data;

	initial
		$readmemh("gamma_table.hex", gamma_rom);

	always @(posedge clk)
	begin
		// Read
		if (enable)
			rd_data <= gamma_rom[rd_addr];
	end

	genvar i;
	generate
		for (i=0; i<8; i=i+1)
			assign rd_addr[7-i] = in[IW-1-(i%IW)];
	endgenerate

	assign out = rd_data[15:16-OW];

endmodule // hub75_gamma
