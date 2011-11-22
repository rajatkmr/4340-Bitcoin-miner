
program tb (ifc.test_bench ds);
	params param;
	int ctr;
	bit verbose;

	initial begin
		verbose = 1;
		param = new();

		$display("\nStarting test...");
		repeat (param.max_cycles) begin
			ctr = 1 + ctr;
			$display("\n#%0d:", ctr);
			@(ds.cblock);
		end

	end 

endprogram
