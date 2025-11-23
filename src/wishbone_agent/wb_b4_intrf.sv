//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : bw_b4_intrf.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 23.11.2024
//------------------------------------------------------------------------------
// Description     : Interface for the Wishbone B4
//------------------------------------------------------------------------------
// Changes         :
// 23.11.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

interface wb_b4_intrf #(
    parameter ADDR_WIDTH        = 32,
    parameter SEL_WIDTH         = 4,
    parameter DATA_INPUT_WIDTH  = 32,
    parameter DATA_OUTPUT_WIDTH = 32
) (
    input clk, 
    input rst_n
);
    logic                          cyc;
    logic                          stb;
    logic                          we;
    logic [ADDR_WIDTH-1:0]         addr;
    logic [DATA_INPUT_WIDTH-1:0]   i_data;
    logic [SEL_WIDTH-1:0]          sel;
    logic                          stall;
    logic                          ack;
    logic [DATA_OUTPUT_WIDTH:0]    o_data;
    
endinterface:wb_b4_intrf
