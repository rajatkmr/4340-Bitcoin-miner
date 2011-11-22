
class params;

	int max_cycles;


	function new();
		read_params();
	endfunction

	function void read_params;
		int file = $fopen("./params.cfg", "r");
		if (file == 0) begin
			$display("Could not read file params.cfg");
			$exit;
		end

		if ($fscanf(file, "max_cycles %d", max_cycles)==-1) begin
			$display("Could not read params from params.cfg");
			$exit;
		end

		$fclose(file);

		$display("Read params:");
		$display("max_cycles %0d", max_cycles);
	endfunction

endclass

