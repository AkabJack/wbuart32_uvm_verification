//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : wb_b4_driver.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 09.01.2026
//------------------------------------------------------------------------------
// Description     : Wisbone driver for sending transactions
//------------------------------------------------------------------------------
// Changes         :
// 09.01.2026 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __WB_B4_DRIVER_SV
`define __WB_B4_DRIVER_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class wb_b4_driver extends uvm_driver;

    virtual interface wb_b4_intrf v_intrf;
    protected wb_b4_transfer transaction;

    `uvm_component_utils(wb_b4_driver);

    function new (string name = "wb_b4_driver", uvm_component parent);
        super.new(name, parent);
    endfunction:new

    extern function void build_phase(uvm_phase phase);
    extern task          reset_phase(uvm_phase phase);
    extern task          main_phase(uvm_phase phase);

endclass:wb_b4_driver

function void wb_b4_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual wb_b4_intrf)::get(this, "", "v_intrf", v_intrf))begin
        `uvm_fatal(get_type_name(), {"Virtual interface must be set for:", get_full_name(), ".v_intrf"})
    end
endfunction:build_phase

task wb_b4_driver::reset_phase(uvm_phase phase);
    @(posedge v_intrf.rst_p);//assert the reset phase
    
endtask:reset_phase

`endif
