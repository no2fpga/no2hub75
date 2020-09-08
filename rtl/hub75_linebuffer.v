/*
 * hub75_linebuffer.v
 *
 * vim: ts=4 sw=4
 *
 * Copyright (C) 2019-2020  Sylvain Munaut <tnt@246tNt.com>
 * SPDX-License-Identifier: CERN-OHL-W-2.0
 */

`default_nettype none

module hub75_linebuffer #(
	parameter N_WORDS = 1,
	parameter WORD_WIDTH = 24,
	parameter ADDR_WIDTH = 6
)(
	input  wire [ADDR_WIDTH-1:0] wr_addr,
	input  wire [(N_WORDS*WORD_WIDTH)-1:0] wr_data,
	input  wire [N_WORDS-1:0] wr_mask,
	input  wire wr_ena,

	input  wire [ADDR_WIDTH-1:0] rd_addr,
	output reg  [(N_WORDS*WORD_WIDTH)-1:0] rd_data,
	input  wire rd_ena,

	input  wire clk
);
	integer i;
	reg [(N_WORDS*WORD_WIDTH)-1:0] ram [(1<<ADDR_WIDTH)-1:0];

`ifdef SIM
	initial
		for (i=0; i<(1<<ADDR_WIDTH); i=i+1)
			ram[i] = 0;
`endif

	always @(posedge clk)
	begin
		// Read
		if (rd_ena)
			rd_data <= ram[rd_addr];

		// Write
		if (wr_ena)
			for (i=0; i<N_WORDS; i=i+1)
				if (wr_mask[i])
					ram[wr_addr][((i+1)*WORD_WIDTH)-1 -: WORD_WIDTH] <= wr_data[((i+1)*WORD_WIDTH)-1 -: WORD_WIDTH];
	end

endmodule // hub75_linebuffer
