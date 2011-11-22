
module memory 
	#(
		parameter WIDTH_C2M = 16,
		parameter WIDTH_M2D = 16
	)
	(
		input clk_i,					
		input rst_i,
		input conwrite_i,
		inout [WIDTH_C2M-1:0] c2m_data_io,
		output memwrite_o,			// memwrite -> to indicate Slave is ready to output 
		output valid_o,				// Valid signal to "Master" processor goes high if a valid block is mined
		output busy_o,				// Busy indicates no more input can be taken from master
	
		inout [WIDTH_M2D-1:0] m2d_data_io,			// m2d_data takes data from memory to distribution unit
		inout m2d_rwbit_io			// m2d_rwbit is direction signal for m2d_data bus
	);

endmodule

