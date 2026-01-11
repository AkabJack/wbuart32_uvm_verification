//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_b4_transfer.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 10.01.2026
//------------------------------------------------------------------------------
// Description     : WB-B4 packet for encapsulating the transaction
//------------------------------------------------------------------------------
// Changes         :
// 10.01.2026 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __WB_B4_TRANSFER_SV
`define __WB_B4_TRANSFER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class wb_b4_transfer extends uvm_sequence_item;

    /* op_type = Operation type 
     *      [2] == 1 -> Block operation     | [2] == 0 -> No block op
     *      [1] == 1 -> Pipelined operation | [1] == 0 -> Classic operation 
     *      [0] == 1 -> Write operation     | [0] == 0 -> Read operation
     */ 
    rand bit   [2:0]          op_type;
    rand bit   [3:0]          byte_mask;//for the sel signal
    rand bit   [32 -1:0]      addr;
    rand bit   [32 -1:0]      data;
    

    `uvm_object_utils_begin(wb_b4_transfer)
        `uvm_field_int(data, UVM_ALL_ON)
        `uvm_field_int(byte_mask, UVM_ALL_ON)
        `uvm_field_int(addr, UVM_ALL_ON)
        `uvm_field_int(op_type, UVM_ALL_ON)
    `uvm_object_utils_end

    extern function new(string name = "wb_b4_transfer");
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
    
endclass:wb_b4_transfer
/*----------------------------------------------------------------------------*/
/*  Functions                                                                 */
/*----------------------------------------------------------------------------*/
function wb_b4_transfer::new(string name = "wb_b4_transfer");
    super.new(name);
endfunction:new

function string wb_b4_transfer::convert2string();
return $sformatf("data = 0x%0h, byte_mask = 4'b%0b,addr = 0x%0h, operation type: block = %0b, Pipeline = %0b, classic = %0b, Write op = %0b, Read op = %0b", 
                    data, byte_mask, addr, op_type[2], op_type[1], !op_type[1], op_type[0], !op_type[0]
                );
endfunction:convert2string

`endif
