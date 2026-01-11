//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_b4_agent.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 11.01.2026
//------------------------------------------------------------------------------
// Description     : Wishbone B4 agent
//------------------------------------------------------------------------------
// Changes         :
// 11.01.2026 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __WB_B4_AGENT_SV
`define __WB_B4_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class wb_b4_agent extends uvm_agent;
    `uvm_component_utils(wb_b4_agent);

    wb_b4_driver     wb_driver;
    wb_b4_sequencer  wb_sequencer;
    //wb_b4_monitor    wb_monitor;

    extern function         new(string name = "wb_b4_agent", uvm_component parent);
    extern function void    build_phase(uvm_phase phase);
    extern function void    connect_phase(uvm_phase phase);

endclass:wb_b4_agent

function wb_b4_agent::new(string name = "wb_b4_agent", uvm_component parent);
    super.new(name, parent);
endfunction:new

function void wb_b4_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //creating the components of the agent
    if (!uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active))begin
        `uvm_fatal(get_type_name(),{"is_active isn't set for this agent ", get_full_name(),""})
    end
    wb_driver    = wb_b4_driver::type_id::create("wb_driver", this);
    wb_sequencer = wb_b4_sequencer::type_id::create("wb_sequencer", this);
endfunction:build_phase

function void wb_b4_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //connect the driver's item port to the sequencer export port
    wb_driver.seq_item_port.connect(wb_sequencer.seq_item_export);
endfunction:connect_phase

`endif
