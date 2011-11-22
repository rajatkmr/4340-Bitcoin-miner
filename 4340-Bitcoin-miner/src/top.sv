
`timescale 1ns/100ps

module top;
 // clock generator
 bit clk = 0;
 always #5 clk = ~clk;
 
 // command to generate the VCD dump file that you open with DVE
 // initial $vcdpluson;

 ifc ext_ifc(clk); // instantiate the interface file
 bc_miner miner(ext_ifc.miner_dut);
 tb bench(ext_ifc.test_bench);

endmodule
