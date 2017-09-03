`ifndef ternarioDoble
  `include "modulos/ternarioDoble.v"
`endif
`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif

`timescale 1ns/1ps

/*
El módulo testternarioDoble se encarga de probar
el módulo ternarioDoble en todas sus combinaciones.
 */
module testternarioDoble ();

  reg a, b, c, s1, s2, clk;
  wire y;

  ternarioDoble tester(
    .a(a),
    .b(b),
    .c(c),
    .s1(s1),
    .s2(s2),
    .y(y)
  );

  initial # 100 clk = 0;

  always # 45 clk = ~clk;

  initial begin

    // elección de señal a=0
    # 150;
    @(posedge clk);
      $display("Eleccion de señal a=0, entonces s1=0 y s2=0");
      a <= 1'b0;
      b <= 1'b0;
      c <= 1'b0;
      s1 <= 1'b0;
      s2 <= 1'b0;
      // se cambian valores de b y c para corroborar
      // funcionamiento correcto.
      # 150;
      @(posedge clk);
        b <= 1'b1;
      # 150;
      @(posedge clk);
        c <= 1'b1;
      # 150;
      @(posedge clk);
        b <= 1'b0;

    // elección de señal a=1 igual a la prueba anterior
    # 150;
    @(posedge clk);
    $display("Eleccion de señal a=1, entonces s1=0 y s2=0");
      a <= 1'b1;
      b <= 1'b0;
      c <= 1'b0;
      s1 <= 1'b0;
      s2 <= 1'b0;

      # 150;
      @(posedge clk);
        b <= 1'b1;
      # 150;
      @(posedge clk);
        c <= 1'b1;
      # 150;
      @(posedge clk);
        b <= 1'b0;


    // elección de señal b=0
    # 150;
    @(posedge clk);
      $display("Eleccion de señal b=0, entonces s1=0 y s2=0");
      a <= 1'b0;
      b <= 1'b0;
      c <= 1'b0;
      s1 <= 1'b1;
      s2 <= 1'b0;
      // se cambian valores de a y c para corroborar
      // funcionamiento correcto.
      # 150;
      @(posedge clk);
        a <= 1'b1;
      # 150;
      @(posedge clk);
        c <= 1'b1;
      # 150;
      @(posedge clk);
        a <= 1'b0;

    // elección de señal b=1 igual a la prueba anterior
    # 150;
    @(posedge clk);
    $display("Eleccion de señal b=1, entonces s1=1 y s2=0");
      a <= 1'b0;
      b <= 1'b1;
      c <= 1'b0;
      s1 <= 1'b1;
      s2 <= 1'b0;

      # 150;
      @(posedge clk);
        a <= 1'b1;
      # 150;
      @(posedge clk);
        c <= 1'b1;
      # 150;
      @(posedge clk);
        a <= 1'b0;


    // elección de señal c=0
    # 150;
    @(posedge clk);
      $display("Eleccion de señal c=0, entonces s1=x y s2=1");
      a <= 1'b0;
      b <= 1'b0;
      c <= 1'b0;
      s1 <= 1'bx;
      s2 <= 1'b1;
      // se cambian valores de a y b para corroborar
      // funcionamiento correcto.
      # 150;
      @(posedge clk);
        a <= 1'b1;
      # 150;
      @(posedge clk);
        b <= 1'b1;
      # 150;
      @(posedge clk);
        a <= 1'b0;

    // elección de señal c=1 igual a la prueba anterior
    # 150;
    @(posedge clk);
    $display("Eleccion de señal c=1, entonces s0=x y s1=1");
      a <= 1'b0;
      b <= 1'b0;
      c <= 1'b1;
      s1 <= 1'bx;
      s2 <= 1'b1;

      # 150;
      @(posedge clk);
        a <= 1'b1;
      # 150;
      @(posedge clk);
        b <= 1'b1;
      # 150;
      @(posedge clk);
        a <= 1'b0;
    # 150;
    @(posedge clk);
    $finish;
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
    $dumpfile("./tests/testternarioDoble.vcd");
    $dumpvars;
    $display("------------------------------------");
    $display("-- Test para modulo ternarioDoble --");
    $display("------------------------------------");
    $display ("\t     tiempo | a | b | c | s1 | s2 | y | tiempo");
    $monitor            ("%t| %b | %b | %b | %b  | %b  | %b | %f ns",
                          $time, a, b, c, s1, s2, y, $realtime);
  end
endmodule
