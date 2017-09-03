//`ifndef norGate
//  `include "../tarea3/modulos/norGate.v"
//`endif
//`ifndef mux
 // `include "../tarea3/modulos/mux.v"
//`endif

/*
  Modulo serialOcontiguo
 */
module serialOcontiguo(
  input usual,
  input s_in,
  input [1:0] modo,
  output out
);

  wire usual, s_in, out;
  wire [1:0] modo;

  wire outNor;
  wire outMux;
  wire [1:0] canalesMux;
  assign canalesMux[1] = s_in;
  assign canalesMux[0] = usual;

  parameter notoe = 1'b0;

  norGate modeNor(
	 .a(modo[1]),
	 .b(modo[0]),
	 .y(outNor)
);

  mux selector(
	  .s(outNor),
	  .a(canalesMux),
	  .notoe(notoe),
	  .y(outMux)		  
);

assign out = outMux;

endmodule//serialOcontiguo

