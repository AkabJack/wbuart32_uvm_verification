//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_driver.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 02.12.2025
//------------------------------------------------------------------------------
// Description     : Uart driver for sending transactions through uart
//------------------------------------------------------------------------------
// Changes         :
// 02.12.2025 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __UART_DRIVER_SV
`define __UART_DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_driver extends uvm_driver;

    virtual interface uart_intrf v_intrf;
    protected uart_transfer transaction;
    int baud_rate;
    int setup_count;
    bit internal_clk_gen;
    bit setup_done;
    time baud_half_period;

    `uvm_component_utils(uart_driver)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new

    extern function void build_phase(uvm_phase phase);
    extern task          reset_phase(uvm_phase phase);
    extern task          main_phase(uvm_phase phase);

endclass:uart_driver

function void uart_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
        if(!uvm_config_db#(virtual uart_intrf)::get(this, "", "v_intrf", v_intrf))begin
           `uvm_fatal(get_type_name(), {"Virtual interface must be set for:", get_full_name(), ".v_intrf"})
        end
        if(!uvm_config_db#(int)::get(this, "", "baud_rate", baud_rate))begin
           `uvm_info(get_full_name(), "Setting the default Baud Rate value of 9600", UVM_LOW)
            baud_rate = 9600;
            baud_half_period = (1s / baud_rate) / 2;
        end else begin
            baud_half_period = (1s / baud_rate) / 2;
        end
endfunction:build_phase

task uart_driver::reset_phase(uvm_phase phase);
    super.reset_phase(phase);
    phase.raise_objection(this);

    @(posedge v_intrf.rst_p);//assert the reset phase
    v_intrf.tx  <= 'b1;//setting the line at high after reset
    v_intrf.cts <= 'b1;
    internal_clk_gen <= 'b0;//reseting the clock signal
    v_intrf.uart_clk <= internal_clk_gen;
    setup_done <= 'b0;
    setup_count <= 0;
    @(negedge v_intrf.rst_p);

    phase.drop_objection(this);
endtask:reset_phase

task uart_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);
    phase.raise_objection(this);
    `uvm_info(get_full_name(), "Entering main phase", UVM_LOW)
    // Half period derived from baud rate (bit time = 1/baud, toggle every half bit)
    //baud_half_period = (1s / baud_rate) / 2;
    //we asserted the reset in the reset phase, for this moment is enough, but I think in the future we need to modify this aspect
    fork
        forever begin
            seq_item_port.get_next_item(req);
            transaction = uart_transfer'(req);//casting to the uart_transfer
                while(setup_done === 0) @(posedge v_intrf.clk);
                `uvm_info(get_full_name(), $sformatf("Start sending a new transaction %0s at the time: %0t", transaction.convert2string(), $time), UVM_LOW)
                @(posedge internal_clk_gen);
                v_intrf.cts <= 0;//asserting (CTS - Clear to send) and waiting the (RTS - Ready to send)
                if (v_intrf.rts != 0)@(negedge v_intrf.rts);
                @(posedge internal_clk_gen);
                v_intrf.tx <= 1'b0;
                @(posedge internal_clk_gen);//waiting 1 clock pulse

                for(int i = 0; i < 8; i++)begin
                    v_intrf.tx <= transaction.data[i];
                    @(posedge internal_clk_gen);
                end
                v_intrf.cts <= 1;//Deasserting CTS
                `uvm_info(get_full_name(), $sformatf("Finished sending the transaction %0s at the time: %0t", transaction.convert2string(), $time), UVM_LOW)
            seq_item_port.item_done();//releasing the packet
        end
        forever begin//clock generator
            #baud_half_period;
            if(setup_count == 18) setup_done = 1;//added with 3 more to be sure that the DUT is configured, 16 is defined in the datasheet
            else setup_count = setup_count + 1;

            internal_clk_gen = ~internal_clk_gen;
            v_intrf.uart_clk <= internal_clk_gen;
        end
    join
    phase.drop_objection(this);
endtask:main_phase

`endif
