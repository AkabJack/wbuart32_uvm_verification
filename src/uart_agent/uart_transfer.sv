//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_transfer.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 07.12.2024
//------------------------------------------------------------------------------
// Description     : Uart packet for encapsulating the transaction
//------------------------------------------------------------------------------
// Changes         :
// 07.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __UART_TRANSFER_SV
`define __UART_TRANSFER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_transfer extends uvm_sequence_item;


    rand bit   [32 -1:0]      data;
    rand int                  width;

    `uvm_object_utils_begin(uart_transfer)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(width, UVM_ALL_ON)
    `uvm_object_utils_end

    extern function new(string name = "uart_transfer");
    //  Function: do_copy
    // extern function void do_copy(uvm_object rhs);
    //  Function: do_compare
    // extern function bit do_compare(uvm_object rhs, uvm_comparer comparer);
    //  Function: convert2string
    extern function string convert2string();
    //  Function: do_print
    // extern function void do_print(uvm_printer printer);
    //  Function: do_record
    // extern function void do_record(uvm_recorder recorder);
    //  Function: do_pack
    // extern function void do_pack();
    //  Function: do_unpack
    // extern function void do_unpack();
    
endclass:uart_transfer


/*----------------------------------------------------------------------------*/
/*  Constraints                                                               */
/*----------------------------------------------------------------------------*/



/*----------------------------------------------------------------------------*/
/*  Functions                                                                 */
/*----------------------------------------------------------------------------*/
function uart_transfer::new(string name = "uart_transfer");
    super.new(name);
endfunction:new

function string uart_transfer::convert2string();
    return $sformatf("data = 0x%0h, width = 0x%0h", data, width);
endfunction:convert2string

`endif
