//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_intrf.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 23.11.2024
//------------------------------------------------------------------------------
// Description     : Interface for the uart interface
//------------------------------------------------------------------------------
// Changes         :
// 23.11.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

interface uart_intrf(
    input clk, 
    input rst_n
);
    logic rx;
    logic tx;
    logic cts;
    logic rts;
endinterface:uart_intrf
