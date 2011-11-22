
interface ifc(input bit clk);

	/* Inputs to miner */
	logic rst;
	wire [15:0] data_input;
	logic [1:0] interrupt;
//	input mready,

	/* Outputs from miner */
	logic mem_write;	// for indicating memory is ready to give output to master
	logic valid;
//	logic busy;			// to indicate the host that no more data can be received from master

	clocking cblock @(posedge clk);
		input mem_write, valid;
		inout data_input;
		output rst, interrupt;
	endclocking

	modport test_bench(clocking cblock);
	modport miner_dut(input clk, rst, interrupt,
					  inout data_input,
					  output mem_write, valid);

endinterface
