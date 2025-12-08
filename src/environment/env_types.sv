//------------------------------------------------------------------------------
// Project         : wbuart_uvm_verification
// Module          : env_types.sv
// Autor           : Nistor Ciprian Alexandru
// Data            : 06.12.2024
//------------------------------------------------------------------------------
// Description     : Types for the environment
//------------------------------------------------------------------------------
// Changes         :
// 06.12.2024 (NCA): Initial commit
//------------------------------------------------------------------------------

`ifndef __ENV_TYPES_SV
`define __ENV_TYPES_SV

// Agent operating modes used across the environment
typedef enum logic [0:0] {
  PASSIVE, //do nothing / monitor the DUT
  ACTIVE   //affects the DUT in some way
} agent_mode_e;


`endif
