
module bc_miner #(parameter WIDTH_C2M = 16,
				  parameter WIDTH_FARM = 16,
				  parameter WIDTH_M2D = 16,
				  parameter WIDTH_ADD = 5)
(ifc.miner_dut md);


//memifc memif;				// memory to distribution block interface
//dbifc dbifc;				// interface for distribution block to SHA compute farm

wire [WIDTH_C2M-1:0] c2m_data;		// data bus for connecting controller to memory
wire conwrite;				// conwrite flags to memory when controller is ready to write
wire memwrite;				// memwrite flags to controller when memory is ready to write
wire rst;				// rst wire to rest of units inside Bitcoin Miner

bus_controller bc11 (
			.clk_i(md.clk),
			.memwrite_i(memwrite),
			.masterdata_io(md.data_input),
			.c2m_data_io(c2m_data),
			.rst_o(rst),
			.conwrite_o(conwrite)
		);
			
wire [WIDTH_FARM-1:0] farmdata;		// data bus to carry data from distribution unit to SHA Farm
wire [WIDTH_M2D-1:0] m2d_data;		// memory to distribution unit data bus
wire m2d_rwbit;
wire busy;
wire valid;

// MEMORY							// Memory Block
memory mem 
	(	.clk_i(md.clk),					
		.rst_i(md.rst),
		.conwrite_i(conwrite),
		.c2m_data_io(c2m_data),
		.memwrite_o(memwrite),				// memwrite -> to indicate Slave is ready to output 
		.valid_o(md.valid),				// Valid signal to "Master" processor goes high if a valid block is mined
		.busy_o(busy),					// Busy indicates no more input can be taken from master
	
		.m2d_data_io(m2d_data),				// m2d_data takes data from memory to distribution unit
		.m2d_rwbit_io(m2d_rwbit)			// m2d_rwbit is direction signal for m2d_data bus
	 );

wire [WIDTH_ADD-1:0] readrow_en, readcol_en, writerow_en, writecol_en;
wire rwfarm,farmbusy;

//DISTRIBUTION UNIT
dist_unit dunit (.clk_i(md.clk),
		.rst_i(md.rst),	
		.m2d_data_io(m2d_data),				// Data Bus from Memory
		.m2d_rwbit_io(m2d_rwbit),			// Read/Write signal to specify direction of "Memory" to "Distribution Unit" data bus
		
		.farmbusy_i(farmbusy),				// used to stop dist. unit from sending another Block_Header
		.farmwrite_i(farmwrite),			// used to tell Distribution Unit when input is to be collected from Farm's Plants(Units)
		.farmdata_io(farmdata),				// data bus to carry data to and from Farm based on rwfarm signal
		.duwrite_o(duread),				// used to tell that Dist. Unit is ready to read from memory 
		.readrow_en_o(readrow_en),			// encoded value of read row in SHA Farm
		.readcol_en_o(readcol_en),			// encoded value of read column in SHA Farm
		.writerow_en_o(writerow_en),
		.writecol_en_o(writecol_en)
		);

// SHA Compute Farm
SHA_farm farm1(	.clk_i(md.clk),
		.rst_i(md.rst),				 
		.readrow_en_i(readrow_en),			// encoded value of read row in SHA Farm
		.readcol_en_i(readcol_en),			// encoded value of read column in SHA Farm
		.writerow_en_i(writerow_en),
		.writecol_en_i(writecol_en),
		.farmdata_io(farmdata),				// Data bus to carry data to and from Farm
		.farmwrite_o(farmwrite),			// Read/Write signal for reading and writing to Farm Plants(Units)
		.farmbusy_o(farmbusy)
	);

endmodule
