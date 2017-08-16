module test3;
  initial begin
    $display("Test Bench 3 registro");
    $display("Prueba la funcionalidad de rotacion circular a la izquierda");
    $display("***********************************************************");
    $dumpfile("tests/registro/test3.vcd");
    $dumpvars(0, test3);
  end
  reg clk  = 0;
  reg enb  = 1;
  reg dir  = 0;
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
    #0 dir = 0;
    #0 s_in = 0;
    #0 d = 4'b0110;

    // modo de ciclo
    #2 modo = 2'b01;

    // pruebas para s_in
    #10 s_in = 2'b0;
    #10 s_in = 2'b1;
    #10 s_in = 2'bx;

    //pruebas para d
    #10 d = 4'b0000;
    #10 d = 4'b1111;
    #10 d = 4'bxxxx;

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
