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
//-----------------------<  Base Sequence Class  >------------------------------

class uart_base_sequence extends uvm_sequence;

    `uvm_object_utils(uart_base_sequence)
    `uvm_declare_p_sequencer(uart_sequencer)

    function new(string name = "uart_base_sequence");
        super.new(name);
    endfunction: new

    //  Task: pre_start
    //  This task is a user-definable callback that is called before the optional 
    //  execution of <pre_body>.
    // extern virtual task pre_start();

    //  Task: pre_body
    //  This task is a user-definable callback that is called before the execution 
    //  of <body> ~only~ when the sequence is started with <start>.
    //  If <start> is called with ~call_pre_post~ set to 0, ~pre_body~ is not called.
    // extern virtual task pre_body();

    //  Task: pre_do
    //  This task is a user-definable callback task that is called ~on the parent 
    //  sequence~, if any. The sequence has issued a wait_for_grant() call and after
    //  the sequencer has selected this sequence, and before the item is randomized.
    //
    //  Although pre_do is a task, consuming simulation cycles may result in unexpected
    //  behavior on the driver.
    // extern virtual task pre_do(bit is_item);

    //  Function: mid_do
    //  This function is a user-definable callback function that is called after the 
    //  sequence item has been randomized, and just before the item is sent to the 
    //  driver.
    // extern virtual function void mid_do(uvm_sequence_item this_item);

    //  Task: body
    //  This is the user-defined task where the main sequence code resides.
    extern virtual task body();

    //  Function: post_do
    //  This function is a user-definable callback function that is called after the 
    //  driver has indicated that it has completed the item, using either this 
    //  item_done or put methods. 
    // extern virtual function void post_do(uvm_sequence_item this_item);

    //  Task: post_body
    //  This task is a user-definable callback task that is called after the execution 
    //  of <body> ~only~ when the sequence is started with <start>.
    //  If <start> is called with ~call_pre_post~ set to 0, ~post_body~ is not called.
    // extern virtual task post_body();

    //  Task: post_start
    //  This task is a user-definable callback that is called after the optional 
    //  execution of <post_body>.
    // extern virtual task post_start();
    
endclass:uart_base_sequence

task uart_base_sequence::body();
    `uvm_info(get_full_name(), "Base class for uart sequence", UVM_LOW)
endtask:body

class seq_send_data extends uart_base_sequence;

    uart_transfer transaction;

    

    `uvm_component_utils_begin(seq_send_data)

    `uvm_component_utils_end

    function new(string name = "seq_send_data");

    endfunction

endclass

`endif