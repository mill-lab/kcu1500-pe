`default_nettype none
module pe_add
  (input wire              CLK, RST,
   input wire [7:0][63:0]  D1, D2,
   input wire		   D1_VALID, D2_VALID,
   output wire		   D1_BP, D2_BP,
   
   output wire [7:0][63:0] Q,
   output wire		   Q_VALID
   );

   wire [7:0][63:0]	   FIFO1_Q, FIFO2_Q;
   wire			   FIFO1_VALID, FIFO2_VALID;
   wire			   RD_EN = ~(D1_BP | D2_BP);

   xpm_fifo_sync #(
   .CASCADE_HEIGHT(0),        // DECIMAL
   .DOUT_RESET_VALUE("0"),    // String
   .ECC_MODE("no_ecc"),       // String
   .FIFO_MEMORY_TYPE("auto"), // String
   .FIFO_READ_LATENCY(0),     // DECIMAL
   .FIFO_WRITE_DEPTH(512),    // DECIMAL
   .FULL_RESET_VALUE(0),      // DECIMAL
   .PROG_EMPTY_THRESH(10),    // DECIMAL
   .PROG_FULL_THRESH(400),    // DECIMAL
   .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
   .READ_DATA_WIDTH(512),     // DECIMAL
   .READ_MODE("fwft"),        // String
   .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_ADV_FEATURES("1002"), // String
   .WAKEUP_TIME(0),           // DECIMAL
   .WRITE_DATA_WIDTH(512),    // DECIMAL
   .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
  )
   xpm_fifo_sync1 (.data_valid(FIFO1_VALID), // O
		   .dout(FIFO1_Q),           // O
		   .prog_full(D1_BP),        // O
		   .full(),                  // for test
		   .din(D1),                 // I
		   .rd_en(RD_EN),            // I
		   .rst(RST),                // I
		   .wr_clk(CLK),             // I
		   .wr_en(D1_VALID)          // I
		   );

   xpm_fifo_sync #(
   .CASCADE_HEIGHT(0),        // DECIMAL
   .DOUT_RESET_VALUE("0"),    // String
   .ECC_MODE("no_ecc"),       // String
   .FIFO_MEMORY_TYPE("auto"), // String
   .FIFO_READ_LATENCY(0),     // DECIMAL
   .FIFO_WRITE_DEPTH(512),    // DECIMAL
   .FULL_RESET_VALUE(0),      // DECIMAL
   .PROG_EMPTY_THRESH(10),    // DECIMAL
   .PROG_FULL_THRESH(400),    // DECIMAL
   .RD_DATA_COUNT_WIDTH(1),   // DECIMAL
   .READ_DATA_WIDTH(512),     // DECIMAL
   .READ_MODE("fwft"),        // String
   .SIM_ASSERT_CHK(0),        // DECIMAL; 0=disable simulation messages, 1=enable simulation messages
   .USE_ADV_FEATURES("1002"), // String
   .WAKEUP_TIME(0),           // DECIMAL
   .WRITE_DATA_WIDTH(512),    // DECIMAL
   .WR_DATA_COUNT_WIDTH(1)    // DECIMAL
  )
   xpm_fifo_sync2 (.data_valid(FIFO2_VALID), // O
		   .dout(FIFO2_Q),           // O
		   .prog_full(D2_BP),        // O
		   .full(),                  // for test
		   .din(D2),                 // I
		   .rd_en(RD_EN),            // I
		   .rst(RST),                // I
		   .wr_clk(CLK),             // I
		   .wr_en(D2_VALID)          // I
		   );

   reg [7:0][63:0]	   Q_R;
   reg			   Q_VR;
   
   always @ (posedge CLK or posedge RST) begin
      if (RST) begin
	 
      end else begin
	 if (RD_EN) begin
	    Q_R = FIFO1_Q + FIFO2_Q;
	 end
      end
   end

   assign Q = Q_R;
   assign Q_VALID = Q_VR;
   
endmodule // pe_add
`default_nettype wire
