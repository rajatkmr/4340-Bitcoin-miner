TOP=top.sv
INTERFACE=interface.sv
BENCH=bench.sv
DUT=bcminer.sv SHA_farm.sv bus_controller.sv dist_unit.sv memory.sv
CLASSES=params.sv

.PHONY: help

help:
	@echo "The following make targets are supported:" ;\
	echo " bench  - builds and runs the testbench";\
	echo " indent - automatically indents verilog and c files" ;\
	echo " clean  - cleans testbench and intermediate files" ;\
	echo " help   - show this information";\


indent:
	emacs --batch *.sv -f verilog-batch-indent
	indent -linux *.c *.h
	rm *~

dut:  
	vcs -PP -sverilog +define+SV +define+VPD $(INTERFACE) $(DUT) 

classes:
	vcs -PP -sverilog +define+SV +define+VPD $(CLASSES) 

test: 
	vcs -PP -sverilog +define+SV +define+VPD $(INTERFACE) $(BENCH)

bench: 
	vcs -PP -sverilog +define+SV +define+VPD $(TOP) $(INTERFACE) $(DUT) $(CLASSES) $(BENCH) -o testbench.exe

clean:
	rm -rf *.o *~ *.vpd sim* csrc DVEfiles *daidir *exe

