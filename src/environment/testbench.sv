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

`define DEF_ADDR_SIZE 32
`define DEF_DATA_SIZE 32

module testbench;
  logic clk;
  logic rst_n;
  logic uart_rx_int;
  logic uart_tx_int;
  logic uart_rxfifo_int;
  logic uart_txfifo_int;

  // 200 MHz clock: 5 ns period, toggle every 2.5 ns
  initial clk = 1'b0;
  always #2.5 clk = ~clk;

  // Active-low reset, release after a few cycles
  initial begin
    rst_n = 1'b0;
    #20 rst_n = 1'b1;
  end

  uart_intrf    uart_ref_intrf (clk, rst_n);
  wb_b4_intrf   wb_intrf(clk, rst_n);

  wbuart DUT(
    .i_clk             (clk),
    .i_reset           (~rst_n),
    .i_wb_cyc          (wb_intrf.cyc),
    .i_wb_stb          (wb_intrf.stb),
    .i_wb_we           (wb_intrf.we),
    .i_wb_addr         (wb_intrf.addr[1:0]),
    .i_wb_data         (wb_intrf.i_data),
    .i_wb_sel          (wb_intrf.sel),
    .o_wb_stall        (wb_intrf.stall),
    .o_wb_ack          (wb_intrf.ack),
    .o_wb_data         (wb_intrf.o_data[31:0]),
    .i_uart_rx         (uart_ref_intrf.rx),
    .o_uart_tx         (uart_ref_intrf.tx),
    .i_cts_n           (uart_ref_intrf.cts),
    .o_rts_n           (uart_ref_intrf.rts),
    .o_uart_rx_int     (uart_rx_int),
    .o_uart_tx_int     (uart_tx_int),
    .o_uart_rxfifo_int (uart_rxfifo_int),
    .o_uart_txfifo_int (uart_txfifo_int)
  );

  

endmodule:testbench
