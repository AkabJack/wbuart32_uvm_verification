//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_b4_sequencer.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 11.01.2026
//------------------------------------------------------------------------------
// Description     : Sequencer for sending packets to the WISHBONE Driver 
//------------------------------------------------------------------------------
// Changes         :
// 11.01.2026 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __WB_B4_SEQUENCER_SV
`define __WB_B4_SEQUENCER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class wb_b4_sequencer extends uvm_sequencer;

    `uvm_component_utils(wb_b4_sequencer)
    extern function new(string name = "wb_b4_sequencer", uvm_component parent);

endclass:wb_b4_sequencer

function wb_b4_sequencer::new(string name = "wb_b4_sequencer", uvm_component parent);
    super.new(name, parent);
endfunction:new

`endif