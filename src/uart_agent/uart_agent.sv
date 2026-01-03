//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_agent.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 24.11.2024
//------------------------------------------------------------------------------
// Description     : Uart agent for sending uart transactions
//------------------------------------------------------------------------------
// Changes         :
// 24.11.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __UART_AGENT_SV
`define __UART_AGENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_agent);

    uart_driver     u_driver;
    uart_sequencer  u_sequencer;
    //uart_monitor    monitor;

    extern function         new(string name = "uart_agent", uvm_component parent);
    extern function void    build_phase(uvm_phase phase);
    extern function void    connect_phase(uvm_phase phase);

endclass:uart_agent

function uart_agent::new(string name = "uart_agent", uvm_component parent);
    super.new(name, parent);
endfunction:new

function void uart_agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    //creating the components of the agent
    if (!uvm_config_db#(uvm_active_passive_enum)::get(this, "", "is_active", is_active))begin
        `uvm_fatal(get_type_name(),{"is_active isn't set for this agent ", get_full_name(),""})
    end
    u_driver    = uart_driver::type_id::create("u_driver", this);
    u_sequencer = uart_sequencer::type_id::create("u_sequencer", this);
endfunction:build_phase

function void uart_agent::connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    //connect the driver's item port to the sequencer export port
    u_driver.seq_item_port.connect(u_sequencer.seq_item_export);
endfunction:connect_phase

`endif
