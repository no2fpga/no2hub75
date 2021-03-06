/*
 * hub75_init_inject_tb.v
 *
 * vim: ts=4 sw=4
 *
 * Copyright (C) 2019-2020  Sylvain Munaut <tnt@246tNt.com>
 * SPDX-License-Identifier: CERN-OHL-W-2.0
 */

`default_nettype none
`timescale 1ns / 100ps

module hub75_init_inject_tb;

	// Signals
	reg rst = 1;
	reg clk = 1;

	wire phy_out_addr_inc;
	wire phy_out_addr_rst;
	wire [4:0] phy_out_addr;
	wire [5:0] phy_out_data;
	wire phy_out_clk;
	wire phy_out_le;
	wire phy_out_blank;

	wire scan_go_in;
	wire scan_go_out;
	wire scan_rdy_in;
	wire scan_rdy_out;
	wire bcm_rdy_in;

	// Setup recording
	initial begin
		$dumpfile("hub75_init_inject_tb.vcd");
		$dumpvars(0,hub75_init_inject_tb);
	end

	// Reset pulse
	initial begin
		# 31 rst = 0;
		# 20000 $finish;
	end

	// Clocks
	always #5 clk = !clk;

	// DUT
	hub75_init_inject dut_I (
		.phy_in_addr_inc(1'b0),
		.phy_in_addr_rst(1'b0),
		.phy_in_addr(5'h00),
		.phy_in_data(6'h00),
		.phy_in_clk(1'b0),
		.phy_in_le(1'b0),
		.phy_in_blank(1'b1),
		.phy_out_addr_inc(phy_out_addr_inc),
		.phy_out_addr_rst(phy_out_addr_rst),
		.phy_out_addr(phy_out_addr),
		.phy_out_data(phy_out_data),
		.phy_out_clk(phy_out_clk),
		.phy_out_le(phy_out_le),
		.phy_out_blank(phy_out_blank),
		.scan_go_in(scan_go_in),
		.scan_go_out(scan_go_out),
		.scan_rdy_in(scan_rdy_in),
		.scan_rdy_out(scan_rdy_out),
		.bcm_rdy_in(bcm_rdy_in),
		.clk(clk),
		.rst(rst)
	);

	// Dummy
	assign scan_go_in = scan_rdy_out;
	assign scan_rdy_in = 1'b1;
	assign bcm_rdy_in = 1'b1;

	// PHY
	hub75_phy phy_I (
		.phy_addr_inc(phy_out_addr_inc),
		.phy_addr_rst(phy_out_addr_rst),
		.phy_addr(phy_out_addr),
		.phy_data(phy_out_data),
		.phy_clk(phy_out_clk),
		.phy_le(phy_out_le),
		.phy_blank(phy_out_blank),
		.clk(clk),
		.rst(rst)
	);

endmodule
