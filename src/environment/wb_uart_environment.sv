//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_uart_environment.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 24.11.2024
//------------------------------------------------------------------------------
// Description     : Verification environment for instantiating the agents
//------------------------------------------------------------------------------
// Changes         :
// 24.11.2024 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __WB_UART_ENVIRONMENT_SV
`define __WB_UART_ENVIRONMENT_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class wb_uart_environment extends uvm_env;
    `uvm_component_utils(wb_uart_environment);

    uart_agent      uart_ag;
    //wishbone_agent  wb_ag;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        uart_ag = uart_agent::type_id::create("uart_agent", this);
    //    wb_ag   = wishbone_agent::type_id::create("wishbone_b4_agent", this);
    endfunction:build_phase

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        //connect the ports
    endfunction:connect_phase

    //  Constructor: new
    function new(string name = "wb_uart_environment", uvm_component parent = null);
        super.new(name, parent);
    endfunction:new

endclass:wb_uart_environment

`endif