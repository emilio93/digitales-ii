module test1;
  initial begin
    $display("Test Bench 1 registro");
    $display("Prueba la funcionalidad de carga en serie a la izquierda");
    $display("********************************************************");
    $dumpfile("tests/registro/test1.vcd");
    $dumpvars(0, test1);
  end
  reg clk  = 0;
  reg enb  = 1;
  reg dir  = 0;
  reg s_in = 1;

  reg [1:0] modo  = 2'b10;
  reg [3:0] d     = 4'b0000;

  wire [3:0] q;
  wire s_out;

  registro registro1(clk, enb, dir, s_in, modo, d, q, s_out);

  // _-_-_-_-_-
  always #1 clk = ~clk;

  initial begin
    #0 modo = 2'b10;
    #0 dir = 0;
    #0 s_in = 1;
    #0 d = 4'b0000;

    // modo de carga en serie
    #2 modo = 2'b00; // cargar 1's
    #10 s_in = 2'b0; // cargar 0's

    // secuencia
    #2 s_in = 2'b1;
    #2 s_in = 2'b0;
    #2 s_in = 2'b1;
    #2 s_in = 2'b0;
    #2 s_in = 2'b1;
    #2 s_in = 2'b0;

    #8 $finish;
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
