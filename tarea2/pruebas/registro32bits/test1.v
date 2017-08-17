module test1;
  initial begin
    $display("Test Bench 1 registro32bits");
    $display("Prueba la funcionalidad de carga en serie a la izquierda");
    $display("********************************************************");
    $dumpfile("tests/registro32bits/test1.vcd");
    $dumpvars(0, test1);
  end

  reg clk = 0;
  reg enb = 1;
  reg dir;
  reg s_in;

  reg [1:0] modo  = 2'b0;
  reg [31:0] d    = 4'h0;

  wire [31:0] q;
  wire s_out;

  registro32bits registro1(clk, enb, dir, s_in, modo, d, q, s_out);

  always #1 clk = ~clk;

  initial begin
    // Se cargan D distintos
    #0 modo = 2'b10;
    #0 dir = 0;
    #0 s_in = 1;
    #0 d = 32'h0;

    #4 d = 32'hffffffff;
    #4 d = 32'b00000000000000000000000000001111;
    #4 d = 32'hffaebc13;

    // retraso acumulado 12

    // a partir de este numero se insertan hacia la izquierda
    // sale el MSB s_out
    #4 s_in = 0;
    #4 modo = 2'b00;

    // retraso acumulado 20

    // ahora a la derecha insertandole 1
    #120 s_in = 1;
    #1 dir = 1;

    // retraso acumulado 141

    // se carga un valor y se rota circularmente
    #120 modo = 2'b10;
    #1 d = 32'habc456f0;
    #4 dir = 0;
    #1 modo = 2'b01;

    // retraso acumulado 267

    #120 dir = 1;

    // retraso acumulado 387

    #120 $finish;
    // retraso acumulado 507
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
