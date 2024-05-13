`default_nettype none
module pe_add1
  (input wire CLK, RST,
   input wire [63:0]  PEADD1IN,
   output wire [63:0] PEADD1OUT
   );

   assign PEADD1OUT = PEADD1IN + 1;
   
endmodule
   
`default_nettype wire
