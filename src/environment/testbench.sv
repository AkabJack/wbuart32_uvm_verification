//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : testbench.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 23.11.2024
//------------------------------------------------------------------------------
// Description     : Testbench for referencing the DUT
//------------------------------------------------------------------------------
// Changes         :
// 23.11.2024 (NCA): Initial commit
//------------------------------------------------------------------------------
`timescale 1ns/1ps


module testbench;
  logic clk;
  logic rst_n;

  // 200 MHz clock: 5 ns period, toggle every 2.5 ns
  initial clk = 1'b0;
  always #2.5 clk = ~clk;

  

endmodule:testbench
