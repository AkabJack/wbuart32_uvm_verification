# Vivado Makefile for direct Verilog testbench simulation
SHELL := /bin/bash
export PATH := /usr/bin:$(PATH)
export LIBRARY_PATH := /usr/lib/x86_64-linux-gnu:/lib/x86_64-linux-gnu

VIVADO_BIN = /media/al3x/PapaBobby/VIVADO/2025.2/Vivado/bin
TOP = testbench
BUILD_ROOT := $(abspath .)
FILE_LIST = files_to_compile.txt

.PHONY: all clean compile run

all: clean compile run

compile:
	$(VIVADO_BIN)/xvlog -work work --sv \
  		-L uvm \
  		-f $(BUILD_ROOT)/$(FILE_LIST)
	$(VIVADO_BIN)/xelab work.$(TOP) -L uvm --dpi_absolute --sv -d VIVADO --debug all
run:
	$(VIVADO_BIN)/xsim work.$(TOP) --R --testplusarg UVM_TESTNAME=base_test
run_gui:
	$(VIVADO_BIN)/xsim work.$(TOP) --g --testplusarg UVM_TESTNAME=base_test -gui
clean:
	rm -rf xsim.dir
	rm -rf .Xil
	rm -f xelab* xsim* xvlog* *.wdb *.log
