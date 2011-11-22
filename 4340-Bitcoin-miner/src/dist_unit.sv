
module dist_unit 
	#(	parameter WIDTH_M2D = 16,
		parameter WIDTH_BITS = 5,	
		parameter WIDTH_FARM = (1 << WIDTH_BITS-1)
	)

	(
		input clk_i,
		input rst_i,	
		inout [WIDTH_M2D-1:0] m2d_data_io,				// Data Bus from Memory
		inout m2d_rwbit_io,				// Read/Write signal to specify direction of "Memory" to "Distribution Unit" data bus
		
		input farmbusy_i,
		input farmwrite_i,			// used to tell Distribution Unit when input is to be collected from Farm's Plants(Units)
		inout [WIDTH_FARM-1:0] farmdata_io,	// data bus to carry data to and from Farm based on rwfarm signal
		output duwrite_o,			// used to tell that Dist. Unit is ready to read from memory 
		output [WIDTH_BITS-1:0] readrow_en_o,			// encoded value of read row in SHA Farm
		output [WIDTH_BITS-1:0] readcol_en_o,			// encoded value of read column in SHA Farm
		output [WIDTH_BITS-1:0] writerow_en_o,
		output [WIDTH_BITS-1:0] writecol_en_o
	);

endmodule

