
module SHA_farm	
	#( parameter WIDTH_ADD=5,
	   parameter WIDTH_FARM = 16
	)

	(
		input clk_i,
		input rst_i,				 
		input [WIDTH_ADD-1:0] readrow_en_i,			// encoded value of read row in SHA Farm
		input [WIDTH_ADD-1:0]readcol_en_i,			// encoded value of read column in SHA Farm
		input [WIDTH_ADD-1:0]writerow_en_i,
		input [WIDTH_ADD-1:0]writecol_en_i,
		inout [WIDTH_FARM-1:0]farmdata_io,				// data bus to carry data to and from Farm based on rwfarm signal
		output farmwrite_o,					// Read/Write signal for reading and writing to Farm Plants(Units)
		output farmbusy_o
	);

endmodule
