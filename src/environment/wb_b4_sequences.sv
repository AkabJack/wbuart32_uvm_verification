//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_b4_sequences.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 11.01.2026
//------------------------------------------------------------------------------
// Description     : Sequence library for the Wishbone Agent
//------------------------------------------------------------------------------
// Changes         :
// 11.01.2026 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __WB_B4_SEQUENCES_SV
`define __WB_B4_SEQUENCES_SV

import uvm_pkg::*;
`include "uvm_macros.svh"
//-----------------------<  Base Sequence Class  >------------------------------

class wb_b4_base_sequence extends uvm_sequence;

    `uvm_object_utils(wb_b4_base_sequence)
    `uvm_declare_p_sequencer(virtual_sequencer)
    
    function new(string name = "wb_b4_base_sequence");
        super.new(name);
    endfunction: new

    virtual task body();
        `uvm_info(get_full_name(), "Base class for uart sequence", UVM_LOW)
    endtask:body

endclass:wb_b4_base_sequence

class wb_setup_write extends wb_b4_base_sequence;
    rand wb_b4_transfer t;

    `uvm_object_utils(wb_setup_write)

    function new(string name = "wb_setup_write");
        super.new(name);
    endfunction:new

    virtual task body();
        `uvm_info(get_full_name(), "Executing an Wishbone write transfer -- setup", UVM_LOW)
        `uvm_do_on_with(t, p_sequencer.wb_seq, {t.op_type == 'h1;// no block op, classic transaction, write operation
                                                t.byte_mask == 'hf;
                                                t.data == 32'h60005161;   //hardware control, 8 bits per word, no parity, 9600 Baud Rate  
                                                t.addr == 0;})   //setup register address, it has w/r access
    endtask:body
endclass:wb_setup_write

class wb_setup_read extends wb_b4_base_sequence;
    rand wb_b4_transfer t;

    `uvm_object_utils(wb_setup_read)

    function new(string name = "wb_setup_read");
        super.new(name);
    endfunction:new

    virtual task body();
        `uvm_info(get_full_name(), "Executing an Wishbone read transfer -- setup", UVM_LOW)
        `uvm_do_on_with(t, p_sequencer.wb_seq, {t.op_type == 'h0;// no block op, classic transaction, read operation
                                                t.byte_mask == 'hf;
                                                t.addr == 0;})   //setup register address, it has w/r access
    endtask:body
endclass:wb_setup_read

`endif