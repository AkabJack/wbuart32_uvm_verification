//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_monitor.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 06.12.2024
//------------------------------------------------------------------------------
// Description     : Uart monitor for reading the uart lines
//------------------------------------------------------------------------------
// Changes         :
// 06.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __UART_MONITOR_SV
`define __UART_MONITOR_SV

import uvm_pkg::*;
`include "uvm_macros.svh"

class uart_monitor extends uvm_monitor;

    virtual uart_intrf v_intrf;
    protected uart_transfer transaction;
    //add coverage class

endclass:uart_monitor
`endif