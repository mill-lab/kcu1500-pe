`default_nettype none
module pe_cp32bit
  (input wire CLK, RST,
   input wire [7:0][63:0]  PECPIN,
   input wire		   D_VALID,
   output wire [7:0][63:0] PECPOUT,
   output wire		   Q_VALID
   );

   assign PECPOUT[0] = {PECPIN[0][31:0],PECPIN[0][31:0]};
   assign PECPOUT[1] = {PECPIN[1][31:0],PECPIN[1][31:0]};
   assign PECPOUT[2] = {PECPIN[2][31:0],PECPIN[2][31:0]};
   assign PECPOUT[3] = {PECPIN[3][31:0],PECPIN[3][31:0]};
   assign PECPOUT[4] = {PECPIN[4][31:0],PECPIN[4][31:0]};
   assign PECPOUT[5] = {PECPIN[5][31:0],PECPIN[5][31:0]};
   assign PECPOUT[6] = {PECPIN[6][31:0],PECPIN[6][31:0]};
   assign PECPOUT[7] = {PECPIN[7][31:0],PECPIN[7][31:0]};

   assign Q_VALID = D_VALID;
   
endmodule
   
`default_nettype wire
