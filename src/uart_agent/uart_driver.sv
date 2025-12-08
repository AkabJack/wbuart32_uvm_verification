//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : uart_driver.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 02.12.2024
//------------------------------------------------------------------------------
// Description     : Uart driver for sending transactions through uart
//------------------------------------------------------------------------------
// Changes         :
// 02.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------
`ifndef __UART_DRIVER_SV
`define __UART_DRIVER_SV

class uart_driver extends uvm_driver;

    virtual interface uart_intrf v_intrf;
    protected uart_transfer transaction;
    protected agent_mode_e driver_mode;//active or passive
    int baud_rate;
    bit internal_clk_gen;

    `uvm_component_utils(uart_driver)

    function new (string name, uvm_component parent);
        super.new(name, parent);
    endfunction:new

    extern function void build_phase(uvm_phase phase);
    extern task          reset_phase(uvm_phase phase);
    extern task          main_phase(uvm_phase phase);

endclass:uart_driver

function void uart_driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
        if(!uvm_config_db#(virtual uart_intrf)::get(this, "", "v_intrf", v_intrf))begin
           `uvm_fatal(get_type_name(), {"Virtual interface must be set for:", get_full_name(), ".v_intrf"})
        end
        if(!uvm_config_db#(int baud_rate)::get(this, "", "baud_rate", baud_rate))begin
           `uvm_info(get_full_name(), "Setting the default Baud Rate value of 9600", UVM_LOW)
            baud_rate = 9600;
        end
        if(!uvm_config_db#(agent_mode_e driver_mode)::get(this, "", "driver_mode", driver_mode))begin
            `uvm_warning(get_full_name(), "Setting the agent to passive mode")
            driver_mode = PASSIVE;
        end
endfunction: build_phase

task uart_driver::reset_phase(uvm_phase phase);
        @(negedge v_intrf.rst_n)//assert the reset phase
        //setup the signals values
        //v_intrf.rx  <= 'b0;
        v_intrf.tx  <= 'b1;//setting the line at high after reset
        v_intrf.cts <= 'b0;
        v_intrf.rst <= 'b0;
        //reseting the clock signal
        internal_clk_gen <= 'b0;
        @(posedge v_intrf.rst_n)
endtask:reset_phase

task uart_driver::main_phase(uvm_phase phase);
    super.main_phase(phase);
    // Half period derived from baud rate (bit time = 1/baud, toggle every half bit)
    time baud_half_period = (1s / baud_rate) / 2;
    //we asserted the reset in the reset phase, for this moment is enough, but I think in the future we need to modify this aspect
    fork
        forever begin
            seq_item_port.get_next_item(req);
            transaction = uart_transfer'(req);//casting to the uart_transfer
                `uvm_info(get_full_name(), $sformatf("Start sending a new transaction %0s at the time: %0t", transaction.convert2string(), $time), UVM_LOW)
                v_intrf.tx <= 1'b0;
                @(posedge internal_clk_gen);//waiting 1 clock pulse

                for(int i = 0; i < 8; i++)begin
                    v_intrf.tx <= uart_transfer[i];
                    @(posedge internal_clk_gen);//waiting 1 clock pulse
                end
                `uvm_info(get_full_name(), $sformatf("Finished sending the transaction %0s at the time: %0t", transaction.convert2string(), $time), UVM_LOW)
            seq_item_port.item_done();//releasing the packet
        end
        forever begin//clock generator
            #baud_half_period;
            internal_clk_gen = ~internal_clk_gen;
        end
    join
endtask
`endif
