`ifndef norGate
  `include "../tarea3/modulos/norGate.v"
`endif
`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif

/*
  Modulo serialOcontiguo
 */
module serialOcontiguo(
  input usual,
  input s_in,
  input modo[1:0],
  output out,
);

  wire usual, s_in, out;
  wire [1:0] modo;

  wire outNor;
  wire outMux;
  wire [1:0] canalesMux;
  assign canalesMux[0] = s_in;
  assign canalesMux[1] = usual;

  paramenter notoe = 1'b0;

  norGate modeNor(
	 .a(mode[1]),
	 .b(mode[0]),
	 .y(outNor)
);

  mux selector(
	  .s(outNor),
	  .a(canalesMux),
	  .notoe(notoe),
	  .y(outMux)		  
);

endmodule//serialOcontiguo

