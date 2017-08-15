`include "modulos/registro.v"

module test2;
  reg clk =   0;
  reg enb =   1;
  reg dir;
  reg s_in;

  reg [1:0] modo  = 2'b00;
  reg [3:0] d     = 4'b0000;

  wire [3:0] q;
  wire s_out;

  registro registro1(clk, enb, dir, s_in, modo, d, q, s_out);

  always #1 clk = ~clk;

  initial begin
    $display("Test Bench 2 registro");
    $dumpfile("tests/registro/test2.vcd");
    $dumpvars(0, test2);

    #0 $finish;
  end

  initial begin
    $monitor(
      "En t:%t\n", $time,
      "dir:\t%b\n", dir,
      "s_in:\t%b\n", s_in,
      "modo:\t%2b\n", modo,
      "d:\t%4b\n", d,
      "q:\t%4b\n", q,
      "s_out:\t%b\n", s_out,
      "--------------------------");
  end
endmodule
