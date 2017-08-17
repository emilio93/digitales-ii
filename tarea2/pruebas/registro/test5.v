module test5;
  initial begin
    $display("Test Bench 5 registro");
    $display("Prueba la funcionalidad de carga en paralelo");
    $display("********************************************");
    $dumpfile("tests/registro/test5.vcd");
    $dumpvars(0, test5);
  end
  reg clk  = 0;
  reg enb  = 1;
  reg dir  = 1;
  reg s_in = 0;

  reg [1:0] modo  = 2'b01;
  reg [3:0] d     = 4'b0110;

  wire [3:0] q;
  wire s_out;

  registro registro1(clk, enb, dir, s_in, modo, d, q, s_out);

  always #1 clk = ~clk;

  initial begin

    // Se carga D
    #0 modo = 2'b10;
    #0 dir = 1;
    #0 s_in = 0;
    #0 d = 4'b0000;

    // modo de carga en paralelo
    #2 modo = 2'b10;

    // pruebas para d y enb
    #10 d = 4'b0000;
    #2 enb = 0;
    #2 d = 4'b1111;
    #10 enb = 1;
    #2 d = 4'b1111;
    #10 d = 4'bxxxx;

    //pruebas para d
    #10 d = 4'b0x0x;
    #4 d = 4'b101x;
    #4 d = 4'bx10x;

    #10 $finish;
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
