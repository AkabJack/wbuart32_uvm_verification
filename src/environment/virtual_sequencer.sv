//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : virtual_sequencer.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 21.12.2024
//------------------------------------------------------------------------------
// Description     : Main virtual sequencer for instantiating the other 
//                  sequencers, and for connecting the sequencers to the test
//------------------------------------------------------------------------------
// Changes         :
// 21.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __VIRTUAL_SEQUENCER_SV
`define __VIRTUAL_SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

typedef class base_test;

class virtual_sequencer extends uvm_virtual_sequencer;

    `uvm_component_utils(virtual_sequencer)

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new

    uart_sequencer u_seq;
    base_test base_test_pointer;

endclass:virtual_sequencer

class v_sequence_base extends uvm_sequence;
    `uvm_object_utils(v_sequence_base)
    `uvm_declare_p_sequencer(virtual_sequencer)

    uart_sequencer uart_p_sequencer;

    function new(string name="v_sequence_base");
        super.new(name);
    endfunction:new

    virtual task body();
        uart_p_sequencer = p_sequencer.u_seq;
    endtask:body
    
endclass:v_sequence_base

`endif
