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

//  Class: uart_agent
//
class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_agent);

    //  Constructor: new
    function new(string name = "uart_agent", uvm_component parent);
        super.new(name, parent);
    endfunction:new


    
endclass:uart_agent
