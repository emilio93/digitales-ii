`ifndef registro4bits
  `include "./modulos/registro4bits.v"
`endif
`ifndef bitHolder
  `include "./modulos/bitHolder.v"
`endif
`ifndef ternarioDoble
  `include "./modulos/ternarioDoble.v"
`endif
`ifndef serialOcontiguo
  `include "./modulos/serialOcontiguo.v"
`endif
`ifndef enabler
  `include "./modulos/enabler.v"
`endif

`ifndef norGate
  `include "../tarea3/modulos/norGate.v"
`endif
`ifndef notGate
  `include "../tarea3/modulos/notGate.v"
`endif
`ifndef nandGate
  `include "../tarea3/modulos/nandGate.v"
`endif
`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif
`ifndef ffD
  `include "../tarea3/modulos/ffD.v"
`endif

`timescale 1ns/1ps

/*
El módulo testregistro4bits se encarga de probar el módulo
registro4bits.
 */
module testregistro4bits ();

  reg clk;
  reg enb;
  reg dir;
  reg s_in;

  reg [1:0] modo;
  reg [3:0] d;

  wire [3:0] q;
  wire s_out;

  registro4bits registro1(
    .clk(clk),
    .enb(enb),
    .dir(dir),
    .s_in(s_in),
    .modo(modo),
    .d(d),
    .q(q),
    .s_out(s_out)
  );

  // inicio de la señal de reloj.
  initial # 50 clk = 0;

  always # 45 clk = ~clk;


  initial begin

    # 50;
    @(posedge clk);
    modo <= 2'b00;
    // Prueba de carga en paralelo debido a que es
    // escencial que este modo funcione bien por
    // varias razones:
    //   - Está bastante desligado al funcionamiento de los
    //     otros modos, nótese que solo pasa por un mux antes
    //     de entrar(o no entrar) al flipflop.
    //   - Se utiliza para cargar los datos en las pruebas de los
    //     otros modos.

    # 10;
    $display("se carga 0000");
    @(posedge clk);
      enb <= 1;
      modo <= 2'b10;
      d <= 4'b0000;
      dir <= 1'bx;

    # 50;
    $display("se carga 0001");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0001;
      dir <= 1'bx;

    # 50;
    $display("se carga 0010");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0010;
      dir <= 1'bx;

    # 50;
    $display("se carga 0100");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0100;
      dir <= 1'bx;

    # 50;
    $display("se carga 1000");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b1000;
      dir <= 1'bx;

    # 50;
    $display("se carga 0000");
    @(posedge clk);
      enb <= 1;
      modo <= 2'b10;
      d <= 4'b0000;
      dir <= 1'bx;

    # 50;
    $display("se carga 0001");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0001;
      dir <= 1'bx;

    # 50;
    $display("se carga 0011");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0011;
      dir <= 1'bx;

    # 50;
    $display("se carga 0111");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0111;
      dir <= 1'bx;

    # 50;
    $display("se carga 1111");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b1111;
      dir <= 1'bx;

    // Prueba de carga en serie modo (00) 
    // direccion 0:izquiera ,  1:derecha
    # 200
    $display("---\nModo de Carga en Serie\n---");
    $display("Hacia la izquierda");
    $display("con s_in = 0");
    @(posedge clk);
      d <= 4'bzzzz;
      modo <= 2'b00;
      dir <= 1'b0;
      s_in <= 2'b0;

    # 400
    $display("con s_in = 1");
    @(posedge clk);
      s_in <= 1;

    # 400
    $display("Hacia la derecha");
    $display("con s_in = 0");
    @(posedge clk);
      dir <= 1'b1;
      s_in <= 0;

    # 400
    $display("con s_in = 1");
    @(posedge clk);
      s_in <= 2'b1;

    # 550;
    @(posedge clk);

    // Prueba de rotación circular modo (01) 
    // direccion 0:izquiera ,  1:derecha
    # 200
    $display("---\nModo de rotacion circular\n---");
    $display("Hacia la izquierda");
    @(posedge clk);
      d <= 4'bzzzz;
      modo <= 2'b01;
      dir <= 1'b0;

    # 400
    $display("Hacia la derecha");
    @(posedge clk);
      dir <= 1'b1;

    # 550;
    @(posedge clk);
 

    $finish;

    $display("------------------------------------");
    $display("##### FIN TEST DE REGISTRO    #####-");
    $display("------------------------------------");
 
  end

  initial
    begin
    $dumpfile("./tests/testregistro4bits.vcd");
    $dumpvars;
    $display("------------------------------------");
    $display("-- Test para modulo registro4bits --");
    $display("------------------------------------");
    $display ("\t     tiempo | enb | dir | s_in | modo | d    | q    | s_out | tiempo");
    $monitor            ("%t| %b   | %b   | %b    | %b   | %b | %b | %b     | %f ns",
                          $time, enb, dir, s_in, modo, d, q, s_out , $realtime);
  end
endmodule
