`ifndef enabler
  `include "modulos/enabler.v"
`endif
`ifndef nandGate
  `include "../tarea3/modulos/nandGate.v"
`endif
`ifndef notGate
  `include "../tarea3/modulos/notGate.v"
`endif

`timescale 1ns/1ps

/*
El módulo Enabler  encarga de crear un habilitador para todo el registro mediante el clock
 */
module testEnabler();
   reg clk;
   reg enb;
   wire out;

  enabler tester(
    .clk(clk),
    .enb(enb),
    .eclk(out)
  );

  parameter retardos = 30;
  always #30  clk = !clk;

 initial begin

  	clk = 0;
	enb = 1;
	#retardos

	enb = 0;
	#retardos
	enb = 1;

	#retardos
	enb = 0;
	#retardos

	enb = 0;
	#retardos
	enb = 0;
	#retardos

	enb = 1;
	#retardos
	enb = 1;

end

  initial
    begin
    $dumpfile("./tests/testEnabler.vcd");
    $dumpvars();
    $display ("\t     tiempo | clk | enb | out ");
    $monitor             ("%t| %b    | %b     | %b ",
                          $time, clk, enb,  out);
  #450
    $finish;
  end
endmodule
