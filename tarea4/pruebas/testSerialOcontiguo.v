`ifndef serialOcontiguo
  `include "modulos/serialOcontiguo.v"
`endif

`timescale 1ns/1ps

/*
El módulo serialOcontiguo se encarga de
 */
module testserialOcontiguo ();

//  reg s_der, s_izq, d_n, dir, clk;
//  reg [1:0] modo;
  reg usual, s_in;
  reg modo[1:0];
  wire out;

  serialOcontiguo tester(
    .usual(usual),
    .s_in(s_in),
    .modo(modo),
    .out(out)
  );


  initial #20 clk = 0;
  always #3 clk = ~clk;

  initial begin
    #50;
    @(posedge clk);
    usual = 0;
    modo = 2'b0;
    s_in = 0;

    #50;
    usual = 1;
    modo = 2'b0;
    s_in = 0;

	#50;
    usual = 1;
    modo = 2'b01;
    s_in = 0;

	#50;
    usual = 1;
    modo = 2'b10;
    s_in = 0;

	#50;
    usual = 1;
    modo = 2'b10;
    s_in = 1;

    #50;
    usual = 1;
    modo = 2'b11;
    s_in = 1;

	#50;
    usual = 1;
    modo = 2'b10;
    s_in = 1;

	#50;
    usual = 0;
    modo = 2'b10;
    s_in = 1;


/*
    @(posedge clk);
      s_der = 1;
      s_izq = 0;
      d_n = 0;
      dir = 0;
      modo = 2'b00;
      #50;
      @(posedge clk);

    #50;
    @(posedge clk);

    #50;
    @(posedge clk);

    #50;
    @(posedge clk);

    #50;
    @(posedge clk);

    #50;
    @(posedge clk);

    #50;
    @(posedge clk);*/
  end
/*
  always @(posedge clk) begin
    // if ($realtime > 100) begin
    //   if (out_bit_cond != out_bit_estr) begin
    //     $display ($time, "ERROR: esperado out_bit_cond: %b, encontrado out_bit_estr: %b", out_bit_cond, out_bit_estr);
    //   end
    //   if (carry_bit_cond != carry_bit_estr) begin
    //     $display ($time, "ERROR: esperado carry_bit_cond: %b, encontrado carry_bit_estr: %b", carry_bit_cond, carry_bit_estr);
    //   end
    // end
  end*/

  initial
    begin
    $dumpfile("./tests/testSerialOcontiguo.vcd");
    $dumpvars;
    $display ("\t     tiempo | usual | s_in | modo | out ");
    $monitor             ("%t| %b    | %b     | %b   | %b",
                          $time, usual, s_in, modo, out);
    #700;
    $finish;
  end
endmodule
