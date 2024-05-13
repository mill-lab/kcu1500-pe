`timescale 1ns/1ps
module pe_tb();
   parameter STEP = 10;
   parameter NumPorts = 4;
   reg	     RST, CLK;

   reg [7:0][63:0] PECPIN;
   reg		   D_VALID;
   wire [7:0][63:0] PECPOUT;
   wire		    Q_VALID;

   reg [63:0]	    CNT;
   
   pe_cp32bit pe32
     (.RST(RST),
      .CLK(CLK),
      .PECPIN(PECPIN),
      .D_VALID(D_VALID),
      .PECPOUT(PECPOUT),
      .Q_VALID(Q_VALID)
      );
   
   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("ASM");

      RST <= 1;
      PECPIN <= 0;
      D_VALID <= 0;

      #(12.1*STEP)
      RST <= 0;
      
      #(1000*STEP)
      $finish;
   end // initial begin

   always @ (posedge CLK) begin
      if (RST) begin
	 CNT <= 0;
      end else begin 
	 CNT <= CNT + 1;
	 case (CNT)
	   100: begin
	      PECPIN[0] <= {32'b0, 32'h1111_1111};
	      PECPIN[1] <= {32'b0, 32'h2222_2222};
	      PECPIN[2] <= {32'b0, 32'h3333_3333};
	      PECPIN[3] <= {32'b0, 32'h4444_4444};
	      PECPIN[4] <= {32'b0, 32'h5555_5555};
	      PECPIN[5] <= {32'b0, 32'h1234_1234};
	      PECPIN[6] <= {32'b0, 32'h5678_5678};
	      PECPIN[7] <= {32'b0, 32'h1234_5678};
	      
	      D_VALID <= 1;
	   end // case: 100
	   101: begin
	      PECPIN <= 0;

	      D_VALID <= 0;
	   end // case: 101
	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule
