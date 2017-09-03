//`ifndef norGate
//  `include "../tarea3/modulos/norGate.v"
//`endif
//`ifndef mux
 // `include "../tarea3/modulos/mux.v"
//`endif

/*
  Modulo enabler
 */

//Incluir notGate y nandGate al compilar

module enabler(
  input clk,
  input enb,
  output eclk
);

  wire clk,enb,eclk;

  wire outNot;
  wire outNand;

  parameter notoe = 1'b0;

  nandGate modeNor(
	 .a(clk),
	 .b(enb),
	 .y(outNand)
);

  notGate inverter(
	  .a(outNand),
	  .y(outNot)		  
);

assign eclk = outNot;

endmodule//enabler
