`ifndef salidaSerial
  `include "./modulos/salidaSerial.v"
`endif
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

`ifndef rdesplazante
  `include "./modulos/sreg.v"
`endif


`timescale 1ns/1ps

/*
El módulo testregistro4bits se encarga de probar el módulo
registro4bits.
 */
module testregistro4bits ();

//  reg clk;//termina con e es estructural
  //reg enb;
//  reg dir;
//  reg s_ine;

//  reg [1:0] modoe;
//  reg [3:0] de;

  wire [3:0] qe;
  wire s_oute;

  reg clk;//termina con c es conductual
  reg enb;
  reg dir;
  reg s_in;

  reg [1:0] modo;
  reg [3:0] d;

  wire [3:0] qc;
  wire s_outc;


  registro4bits estructural(//estructural
	.clk(clk),
	.enb(enb),
	.dir(dir),
	.s_in(s_in),
	.modo(modo),
	.d(d),
	.q(qe),
	.s_out(s_oute)
  );

  rdesplazante conductual(//conductual
	.CLK(clk),
	.ENB(enb),
	.DIR(dir),
	.S_IN(s_in),
	.MODE(modo),
	.D(d),
	.Q(qc),
	.S_OUT(s_outc)
  );

  // inicio de la señal de reloj.
  initial # 50 clk = 0;

  always # 17.4 clk = ~clk;

  always @(qe,qc ) begin
	  if(qe != qc)$display("<<<<<<<<<<<<<<<<HAY ADiferencias entre las salidas  q  >>>>>>>>>>>>>>>>>>>");

  end

  always @(s_outc,s_oute ) begin
	  if(s_outc != s_oute)$display("<<<<<<<<<<<<<<<<HAY ADiferencias entre las salidas s_out  >>>>>>>>>>>>>>>>>>>");

  end

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
      s_in <= 1'b1;

    # 90
    $display("con s_in = 1");
    @(posedge clk);
      s_in <= 1'b0;

    # 60
    $display("con s_in = 1");
    @(posedge clk);
      s_in <= 1'b1;

    # 40
    $display("con s_in = 1");
    @(posedge clk);
      s_in <= 1'b0;

    # 550;
    @(posedge clk);
	//Nuevamente una carga paralela para verificar que la rotación circular
	//funciona
   $display("Hacemos otra carga paralela antes de la rotacion circular");
    # 60;
    $display("se carga 0111");
    @(posedge clk);
      modo <= 2'b10;
      d <= 4'b0111;
      dir <= 1'bx;


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

    $display("------------------------------------");
    $display("##### FIN TEST DE REGISTRO    #####-");
    $display("------------------------------------");

    $finish;
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
                          $time, enb, dir, s_in, modo, d, qc, s_outc , $realtime);
  end
endmodule
