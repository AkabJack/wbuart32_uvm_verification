# Verilator Makefile for direct Verilog testbench simulation
SHELL := /bin/bash

VERILATOR = verilator
TOP = wbuart
BUILD_ROOT = ~/Documents/Proiecte_Verificare/wbuart32_uvm_verification/sim
OBJ_DIR = $(BUILD_ROOT)/obj_dir
RTL_DIR = ~/Documents/Proiecte_Verificare/wbuart32_uvm_verification/rtl
FILE_LIST = files_to_compile.txt
DUMP_FILE = dump.vcd

.PHONY: all clean compile run

all: clean compile run

compile:
	$(VERILATOR) --timing --trace --binary --build-jobs 8 -Mdir $(OBJ_DIR) -f $(FILE_LIST) --top-module $(TOP)
run:
	./$(OBJ_DIR)/V$(TOP)
	$(HOME)/surfer ./$(DUMP_FILE)
clean:
	rm -rf $(OBJ_DIR)
	rm -f $(DUMP_FILE)
