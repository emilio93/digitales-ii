`ifndef bitHolder
  `include "./modulos/bitHolder.v"
`endif
`ifndef notGate
  `include "../tarea3/modulos/notGate.v"
`endif
`ifndef norGate
  `include "../tarea3/modulos/norGate.v"
`endif
`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif
`ifndef ffD
  `include "../tarea3/modulos/ffD.v"
`endif
`ifndef ternarioDoble
  `include "./modulos/ternarioDoble.v"
`endif

`timescale 1ns/1ps

/*
El módulo testbitHolder se encarga de probar el módulo
bitHolder.
 */
module testbitHolder ();

  reg s_der, s_izq, d_n, dir, clk, enb;
  reg [1:0] modo;
  wire clkenb, y;

  assign clkenb = clk & enb;

  bitHolder tester(
    .s_der(s_der),
    .s_izq(s_izq),
    .d_n(d_n),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out)
  );

  // inicio de la señal de reloj.
  initial # 50 clk = 0;

  // El bitHolder tiene un retraso máximo de 2 not, 2 muxes y un flip flop.
  // Para nuestro flip flop se tiene que el máximo retraso es tphlmax = 11.4ns
  // En el caso del mux, tdismax = 5.5ns
  // esto da (2*5.5+11.4)ns = 16.9ns => f = 59.17MHz para el bitHolder
  // se utiliza un retraso de 17 => 58.82MHz
  //
  always # 37 clk = ~clk;

  initial begin

    // Prueba de carga en paralelo debido a que es
    // escencial que este modo funcione bien por
    // varias razones:
    //   - Está bastante desligado al funcionamiento de los
    //     otros modos, nótese que solo pasa por un mux antes
    //     de entrar(o no entrar) al flipflop.
    //   - Se utiliza para cargar los datos en las pruebas de los
    //     otros modos.

    // Primero se carga un 0.
    # 50;
    enb <= 1;
    $display("se carga un 0");
    @(posedge clk);
      modo <= 2'b1x;
      s_der <= 1'bx;
      s_izq <= 1'bx;
      d_n <= 1'b0;
      dir <= 1'bx;

    // Ahora se carga un 1.
    # 50;
    $display("se carga un 1");
    @(posedge clk);
      modo <= 2'b1x;
      s_der <= 1'bx;
      s_izq <= 1'bx;
      d_n <= 1'b1;
      dir <= 1'bx;

    // Prueba de carga en serie
    # 70
    $display("---\nModo de Carga en Serie\n---");
    $display("Hacia la izquierda");
    $display("con s_der = 0");
    @(posedge clk);
      modo <= 2'b00;
      s_izq <= 1'bx;
      dir <= 1'b0;
      s_der <= 1'b0;
      d_n <= 1'bx;

    # 70
    $display("con s_der = 1");
    @(posedge clk);
      modo <= 2'b00;
      s_izq <= 1'bx;
      dir <= 1'b0;
      s_der <= 1'b1;
      d_n <= 1'bx;

    $display("Hacia la derecha");
    $display("con s_izq = 0");
    @(posedge clk);
      modo <= 2'b00;
      s_izq <= 1'b0;
      dir <= 1'b1;
      s_der <= 1'bx;
      d_n <= 1'bx;

    # 70
    $display("con s_izq = 1");
    @(posedge clk);
      modo <= 2'b00;
      s_izq <= 1'b1;
      dir <= 1'b1;
      s_der <= 1'bx;
      d_n <= 1'bx;

    // Prueba de modo en rotacion
    # 70
    $display("---\nModo de rotacion\n---");
    $display("Hacia la izquierda");
    $display("con s_der = 0");
    @(posedge clk);
      modo <= 2'b01;
      s_izq <= 1'bx;
      dir <= 1'b0;
      s_der <= 1'b0;
      d_n <= 1'bx;

    # 70
    $display("con s_der = 1");
    @(posedge clk);
      modo <= 2'b01;
      s_izq <= 1'bx;
      dir <= 1'b0;
      s_der <= 1'b1;
      d_n <= 1'bx;

    $display("Hacia la derecha");
    $display("con s_izq = 0");
    @(posedge clk);
      modo <= 2'b01;
      s_izq <= 1'b0;
      dir <= 1'b1;
      s_der <= 1'bx;
      d_n <= 1'bx;

    # 70
    $display("con s_izq = 1");
    @(posedge clk);
      modo <= 2'b01;
      s_izq <= 1'b1;
      dir <= 1'b1;
      s_der <= 1'bx;
      d_n <= 1'bx;


    # 150;
    @(posedge clk);
    $finish;
  end

  initial
    begin
    $dumpfile("./tests/testbitHolder.vcd");
    $dumpvars;
    $display("------------------------------------");
    $display("-- Test para modulo bitHolder     --");
    $display("------------------------------------");
    $display ("\t     tiempo | s_der | s_izq | d_n | dir | modo[1] | s_out | tiempo");
    $monitor            ("%t| %b     | %b     | %b   | %b   | %b       | %b     | %f ns",
                          $time, s_der, s_izq, d_n, dir, modo[1], s_out, $realtime);
  end
endmodule
