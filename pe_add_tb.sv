`timescale 1ns/1ps
module pe_add_tb();
   parameter STEP = 10;
   reg	     RST, CLK;

   reg [7:0][63:0] D1, D2;
   reg		   D1_VALID, D2_VALID;
   wire [7:0][63:0] Q;
   wire		    Q_VALID;
   reg		    Q_BP;

   reg [63:0]	    CNT;
   
   pe_add peadd
     (.RST(RST),
      .CLK(CLK),
      .D1(D1),
      .D2(D2),
      .D1_VALID(D1_VALID),
      .D2_VALID(D2_VALID),
      .D1_BP(),
      .D2_BP(),
      .Q(Q),
      .Q_VALID(Q_VALID),
      .Q_BP(Q_BP)
      );
   
   initial CLK <= 1;
   always #(STEP/2) CLK <= ~CLK;

   initial begin
      $shm_open();
      $shm_probe("ASM");

      RST <= 1;
      D1 <= 0;
      D2 <= 0;
      D1_VALID <= 0;
      D2_VALID <= 0;
      Q_BP <= 0;
      
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
	      D1[0] <= 64'd1111;

	      D2[0] <= 64'd1111;
	      
	      D1_VALID <= 1;
	      D2_VALID <= 1;
	   end // case: 100

	   101: begin
	      D1[0] <= 64'd1111;

	      D2[0] <= 64'd2222;
	      
	      D1_VALID <= 1;
	      D2_VALID <= 1;
	   end

	   102: begin
	      D1[0] <= 64'd1111;

	      D2[0] <= 64'd3333;
	      
	      D1_VALID <= 1;
	      D2_VALID <= 1;
	   end

	   103: begin
	      D1[0] <= 64'd1111;

	      D2[0] <= 64'd4444;
	      
	      D1_VALID <= 1;
	      D2_VALID <= 1;
	   end

	   104: begin
	      D1[0] <= 64'd150;

	      D2[0] <= 64'd150;
	      
	      D1_VALID <= 1;
	      D2_VALID <= 1;

	      Q_BP <= 1;
	   end

	   105: begin
	      D1 <= 0;
	      D2 <= 0;

	      D1_VALID <= 0;
	      D2_VALID <= 0;
	   end

	   110: begin
	      Q_BP <= 0;
	   end
	 endcase // case (CNT)
      end
   end // always @ (posedge CLK)
endmodule
