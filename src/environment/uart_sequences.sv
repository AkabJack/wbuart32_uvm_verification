//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_sequences.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 08.12.2024
//------------------------------------------------------------------------------
// Description     : Sequence library for the uart agent
//------------------------------------------------------------------------------
// Changes         :
// 08.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __UART_SEQUENCES_SV
`define __UART_SEQUENCES_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
//-----------------------<  Base Sequence Class  >------------------------------

class uart_base_sequence extends uvm_sequence;

    `uvm_object_utils(uart_base_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)
    
    function new(string name = "uart_base_sequence");
        super.new(name);
    endfunction: new

    extern virtual task body();
endclass:uart_base_sequence

task uart_base_sequence::body();
    `uvm_info(get_full_name(), "Base class for uart sequence", UVM_LOW)
endtask:body

class seq_send_data extends uart_base_sequence;
    rand uart_transfer t;

    `uvm_object_utils(seq_send_data)

    function new(string name = "seq_send_data");
        super.new(name);
    endfunction:new

    virtual task body();
        `uvm_info(get_full_name(), "Executing an UART transfer", UVM_LOW)
        `uvm_do_on_with(t, p_sequencer.u_seq, {t.data == 'h55;//0101_0101 constraint randomization debug
                                               t.width == 8;})//width -> 8 bits
    endtask:body

endclass:seq_send_data

`endif