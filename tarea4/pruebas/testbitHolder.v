`ifndef bitHolder
  `include "modulos/bitHolder.v"
`endif

`timescale 1ns/1ps

/*
El módulo testbitHolder se encarga de
 */
module testbitHolder ();

  reg s_der, s_izq, d_n, dir, clk;
  reg [1:0] modo;
  wire y;

  bitHolder tester(
    .s_der(s_der),
    .s_izq(s_izq),
    .d_n(d_n),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out)
  );


  initial #20 clk = 0;
  always #3 clk = ~clk;

  initial begin
    #50;
    @(posedge clk);
      s_der = 0;
      s_izq = 0;
      d_n = 0;
      dir = 0;
      modo = 2'b00;

    #50;
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
    @(posedge clk);
  end

  always @(posedge clk) begin
    // if ($realtime > 100) begin
    //   if (out_bit_cond != out_bit_estr) begin
    //     $display ($time, "ERROR: esperado out_bit_cond: %b, encontrado out_bit_estr: %b", out_bit_cond, out_bit_estr);
    //   end
    //   if (carry_bit_cond != carry_bit_estr) begin
    //     $display ($time, "ERROR: esperado carry_bit_cond: %b, encontrado carry_bit_estr: %b", carry_bit_cond, carry_bit_estr);
    //   end
    // end
  end

  initial
    begin
    $dumpfile("./tests/testbitHolder.vcd");
    $dumpvars;
    $display ("\t     tiempo | s_der | s_izq | d_n | dir | modo[1]");
    $monitor             ("%t| %b     | %b     | %b   | %b   | %b",
                          $time, s_der, s_izq, d_n, dir, modo[1], clk);
    #700;
    $finish;
  end
endmodule
