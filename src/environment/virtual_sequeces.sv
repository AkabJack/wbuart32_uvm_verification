//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : virtual_sequences.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 29.12.2024
//------------------------------------------------------------------------------
// Description     : Sequences for starting the other sequences for each driver
//------------------------------------------------------------------------------
// Changes         :
// 29.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __VIRTUAL_SEQUECES_SV
`define __VIRTUAL_SEQUECES_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class v_seq_basic_uart_trans extends v_sequence_base;
    `uvm_object_utils(v_seq_basic_uart_trans)

    function new(string name = "v_seq_basic_uart_trans");
        super.new(name);
    endfunction:new

    virtual task body();
        seq_send_data uart_seq_data = seq_send_data::type_id::create("uart_seq_data");
        `uvm_info(get_full_name(), "Executing an v_seq_basic_uart_trans transfer", UVM_LOW)
        uart_seq_data.randomize();
        `uvm_do_on(uart_seq_data, uart_p_sequencer);
        `uvm_info(get_full_name(), "Ending an v_seq_basic_uart_trans transfer", UVM_LOW)
    endtask
endclass:v_seq_basic_uart_trans

`endif