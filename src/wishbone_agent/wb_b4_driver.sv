//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_b4_driver.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 09.01.2026
//------------------------------------------------------------------------------
// Description     : Wisbone driver for sending transactions
//------------------------------------------------------------------------------
// Changes         :
// 09.01.2026 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __WB_B4_DRIVER_SV
`define __WB_B4_DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class wb_b4_driver extends uvm_driver;

    virtual interface wb_b4_intrf v_intrf;
    protected wb_b4_transfer transaction;

    `uvm_component_utils(wb_b4_driver);

    function new (string name = "wb_b4_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    extern function void build_phase(uvm_phase phase);
    extern task          reset_phase(uvm_phase phase);
    extern task          main_phase(uvm_phase phase);

endclass:wb_b4_driver

function void wb_b4_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual wb_b4_intrf)::get(this, "", "v_intrf", v_intrf))begin
        `uvm_fatal(get_type_name(), {"Virtual interface must be set for:", get_full_name(), ".v_intrf"})
    end
endfunction:build_phase

task wb_b4_driver::reset_phase(uvm_phase phase);
    super.reset_phase(phase);

    phase.raise_objection(this);
    @(posedge v_intrf.rst_p);//assert the reset phase
    v_intrf.cyc     <= 'b0;  
    v_intrf.stb     <= 'b0;
    v_intrf.we      <= 'b0;
    v_intrf.addr    <= 'b0;
    v_intrf.i_data  <= 'b0;
    v_intrf.sel     <= 'b0;
    @(negedge v_intrf.rst_p);
    @(posedge v_intrf.clk);@(posedge v_intrf.clk);@(posedge v_intrf.clk);@(posedge v_intrf.clk);
    phase.drop_objection(this);
endtask:reset_phase

task wb_b4_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this);
    fork
        forever begin
            seq_item_port.get_next_item(req);
            transaction = wb_b4_transfer'(req);
            `uvm_info(get_full_name(), $sformatf("Start sending a new transaction %0s at the time: %0t", transaction.convert2string(), $time), UVM_LOW)
            if(transaction.op_type[2] === 1)begin//Block operation type
                @(posedge v_intrf.clk);
                case (transaction.op_type[0])
                    1'b0:begin//write

                    end
                    1'b1:begin//read
                        
                    end
                endcase
            end else if(transaction.op_type[1] === 1)begin//Pipelined operation type
                case (transaction.op_type[0])
                    1'b0:begin//write

                    end
                    1'b1:begin//read
                        
                    end
                endcase
            end else begin//Classic operation type
                case (transaction.op_type[0])
                    1'b1:begin//write
                        //Clock edge 0
                        v_intrf.addr    <= transaction.addr;
                        v_intrf.we      <= 1'b1;//write op
                        v_intrf.cyc     <= 1'b1;  //signalise a new transaction
                        v_intrf.stb     <= 1'b1;
                        v_intrf.i_data  <= transaction.data;
                        v_intrf.sel     <= transaction.byte_mask;
                        @(posedge v_intrf.clk);
                        while(v_intrf.ack === 0) @(posedge v_intrf.clk);
                        //@(posedge v_intrf.clk);
                        v_intrf.cyc     <= 1'b0;
                        v_intrf.stb     <= 1'b0;
                        v_intrf.we      <= 1'b0;
                        @(posedge v_intrf.clk);
                    end
                    1'b0:begin//read
                        //Clock edge 0
                        v_intrf.addr    <= transaction.addr;
                        v_intrf.we      <= 1'b0;//read op
                        v_intrf.cyc     <= 1'b1;  //signalise a new transaction
                        v_intrf.stb     <= 1'b1;
                        v_intrf.sel     <= transaction.byte_mask;
                        @(posedge v_intrf.clk);
                        while(v_intrf.ack === 0) @(posedge v_intrf.clk);
                        //monitor samples the data when ack is on logic 1
                        //@(posedge v_intrf.clk);
                        v_intrf.stb     <= 1'b0;
                        v_intrf.cyc     <= 1'b0;
                        @(posedge v_intrf.clk);
                    end
                endcase
            end
            seq_item_port.item_done();//releasing the packet
        end
    join
    phase.drop_objection(this);
endtask:main_phase

`endif
