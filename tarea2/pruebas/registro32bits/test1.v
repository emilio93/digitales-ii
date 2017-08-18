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
    #4;

    // se prueba posición de registros individuales
    #2 d = 32'hffffffff;
    #2 d = 32'hfffffff0;
    #2 d = 32'hffffff00;
    #2 d = 32'hfffff000;
    #2 d = 32'hffff0000;
    #2 d = 32'hfff00000;
    #2 d = 32'hff000000;
    #2 d = 32'hf0000000;
    #2 d = 32'h00000000;

    #2 d = 32'hf0000000;
    #2 d = 32'hff000000;
    #2 d = 32'hfff00000;
    #2 d = 32'hffff0000;
    #2 d = 32'hfffff000;
    #2 d = 32'hffffff00;
    #2 d = 32'hfffffff0;
    #2 d = 32'hffffffff;

    // se prueban bits de primer registro individual
    #2 d = 32'b0001;
    #2 d = 32'b0010;
    #2 d = 32'b0100;
    #2 d = 32'b1000;

    // un numero cualquiera
    #4 d = 32'hffaebc13;

    // a partir de este numero se insertan hacia la izquierda
    // sale el MSB s_out
    #4 s_in = 0;
    #4 modo = 2'b00;

    // ahora a la derecha insertandole 1
    #100 s_in = 1;
    #0 dir = 1;

    // se carga un valor y se rota circularmente
    #120 modo = 2'b10;
    #4 d = 32'haf00f050;
    #4 dir = 0;
    #4;
    #4 modo = 2'b01;

    #120 modo = 2'b10;
    #0 d = 32'h000aa000;
    #4 dir = 0;
    #4;
    #4 modo = 2'b01;


    // retraso acumulado 267

    #20 dir = 1;
    #30 dir = 0;

    #20 dir = 1;
    #30 dir = 0;

    #20 dir = 1;
    #30 dir = 0;

    #20 dir = 1;
    #30 dir = 0;

    #20 dir = 1;
    #30 dir = 0;

    #120 $finish;
  end

  initial begin
    $display("\t\ttiempo  dir s_in modo d \t\t\t\tq \t\t\t\t  s_out\n");
    $monitor(
      "%d", $time,
      "\t%b   ", dir,
      "%b    ", s_in,
      "%2b   ", modo,
      "%4b\t", d,
      "%4b  ", q,
      "%b", s_out
    );
  end
endmodule
