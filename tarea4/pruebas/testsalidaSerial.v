`ifndef ternarioDoble
  `include "modulos/ternarioDoble.v"
`endif
`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif
`ifndef norGate
  `include "../tarea3/modulos/norGate.v"
`endif
`ifndef salidaSerial
  `include "modulos/salidaSerial.v"
`endif
`ifndef serialOcontiguo
  `include "modulos/serialOcontiguo.v"
`endif

`timescale 1ns/1ps

module testsalidaSerial ();

  reg s_der, s_izq, dir;
  reg [1:0] modo;
  wire outAnd;

  // ls_der ss_derlids_der y es  ontrols_derds_der por el módulo de prues_izqs_der.
  wire s_out;

  // se insts_dern is_der el módulo.
  salidaSerial tester(
    .modo(modo),
    .s_der(s_der),
    .s_izq(s_izq),
    .dir(dir),
    .s_out(s_out)
  );

  parameter retardos = 25;


  initial begin


  #retardos
  modo = 2'b00;
  s_der = 0;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 1;
  dir = 1;

  #retardos
  modo = 2'b00;
  s_der = 0;
  s_izq = 1;
  dir = 1;

  #retardos
  modo = 2'b00;
  s_der = 0;
  s_izq = 0;
  dir = 1;

  #retardos
  modo = 2'b10;
  s_der = 0;
  s_izq = 0;
  dir = 1;

  #retardos
  modo = 2'b10;
  s_der = 0;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b10;
  s_der = 0;
  s_izq = 1;
  dir = 0;

  #retardos
  modo = 2'b01;
  s_der = 1;
  s_izq = 1;
  dir = 1;

  #retardos
  modo = 2'b01;
  s_der = 0;
  s_izq = 1;
  dir = 1;

  #retardos
  modo = 2'b10;
  s_der = 0;
  s_izq = 1;
  dir = 0;

  #retardos
  modo = 2'b10;
  s_der = 1;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 1;

  #retardos
  modo = 2'b00;
  s_der = 0;
  s_izq = 1;
  dir = 1;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 1;
  dir = 0;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 1;

  #retardos
  modo = 2'b00;
  s_der = 0;
  s_izq = 1;
  dir = 1;

  #retardos
  modo = 2'b00;
  s_der = 1;
  s_izq = 0;
  dir = 0;


  $finish;
  end

  initial begin

    $dumpfile("./tests/testsalidaSerial.vcd");
    $dumpvars;
    $display("------------------------------------");
    $display("-- Test -para modulo salidaSerial --");
    $display("------------------------------------");
    $display ("\t     tiempo | s_der | s_izq | dir | dir | s_out | tiempo");
    $monitor ("%t| %b | %b | %b | %b  | %f ns",
              $time, s_der, s_izq, dir, s_out, $realtime);
	//	  #500
  

	end
endmodule
