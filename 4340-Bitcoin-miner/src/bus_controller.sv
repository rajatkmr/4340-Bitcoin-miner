
module bus_controller #(parameter WIDTH_C2M = 16)
(
	input clk_i,
	input memwrite_i,
	inout [15:0] masterdata_io,
	inout [WIDTH_C2M-1:0] c2m_data_io,
	output rst_o,
	output conwrite_o
);
			
endmodule

