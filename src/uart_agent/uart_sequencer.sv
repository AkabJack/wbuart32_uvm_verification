//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_sequencer.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 08.12.2024
//------------------------------------------------------------------------------
// Description     : Sequencer for sending packets to the UART Driver 
//------------------------------------------------------------------------------
// Changes         :
// 08.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __UART_SEQUENCER_SV
`define __UART_SEQUENCER_SV

class uart_sequencer extends uvm_sequencer;

    `uvm_component_utils(uart_sequencer)
    extern function new(string name = "uart_sequencer", uvm_component parent);

endclass:uart_sequencer

function uart_sequencer::new(string name = "uart_sequencer", uvm_component parent);
    super.new(name, parent);
endfunction:new

`endif