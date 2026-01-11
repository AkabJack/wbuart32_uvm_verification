//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : base_test.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 21.12.2025
//------------------------------------------------------------------------------
// Description     : Base test for running a test
//------------------------------------------------------------------------------
// Changes         :
// 21.12.2025 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __BASE_TEST_SV
`define __BASE_TEST_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

typedef class virtual_sequencer;
//add typedef class for wishbone_b4

class base_test extends uvm_test;
    wb_uart_environment environment;
    virtual_sequencer   v_sequencer;

    `uvm_component_utils(base_test)

    function new(string name = "base_test", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    extern virtual function void end_of_elaboration_phase(uvm_phase phase);
    extern virtual task          main_phase(uvm_phase phase);
endclass:base_test

function void base_test::build_phase(uvm_phase phase);
    // Set the UART agent active and register the default sequence on its sequencer
    uvm_config_db #(uvm_active_passive_enum)::set(this, "wb_uart_env.uart_agent", "is_active", UVM_ACTIVE);
    uvm_config_db #(uvm_active_passive_enum)::set(this, "wb_uart_env.wb_b4_agent", "is_active", UVM_ACTIVE);
    environment = wb_uart_environment::type_id::create("wb_uart_env", this);
    v_sequencer = virtual_sequencer::type_id::create("env_v_seq", this);
endfunction:build_phase

function void base_test::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    v_sequencer.u_seq = environment.uart_ag.u_sequencer;
    v_sequencer.wb_seq = environment.wb_ag.wb_sequencer;
    v_sequencer.base_test_pointer = this;
endfunction:connect_phase

task base_test::main_phase(uvm_phase phase);
    setup_wbuart_module setup = setup_wbuart_module::type_id::create("setup_wbuart_module");
    v_seq_basic_uart_trans u_s = v_seq_basic_uart_trans::type_id::create("v_seq_basic_uart_trans");
    phase.raise_objection(this);
        fork
            begin
                // Start the virtual sequence on the virtual sequencer so p_sequencer casts correctly
                setup.start(v_sequencer);// I should add this to the configure phase
                #20ns;
                u_s.start(v_sequencer);
                #20ns;
            end
            begin
                //timeout guard
                #50ms;
                `uvm_fatal(get_full_name(), "Test wasn't finished after 1ms")
            end
        join_any
    phase.drop_objection(this);
endtask:main_phase

function void base_test::end_of_elaboration_phase(uvm_phase phase);
    uvm_top.print_topology();
endfunction:end_of_elaboration_phase

`endif