//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_intrf.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 23.11.2025
//------------------------------------------------------------------------------
// Description     : Interface for the uart interface
//------------------------------------------------------------------------------
// Changes         :
// 23.11.2025 (NCA): Initial commit
//------------------------------------------------------------------------------
`default_nettype wire

interface uart_intrf(
    input logic clk, 
    input logic rst_p
);
    logic rx;
    logic tx;
    logic cts;
    logic rts;
    logic uart_clk;
endinterface:uart_intrf
