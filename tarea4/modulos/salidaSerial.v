module salidaSerial (
  input [1:0] modo,
  input s_der,
  input s_izq,
  input dir,
  output s_out
);

  //añadir serialOcontiguo y mnux para compilar
  // Entradas salidas, todas son wire.
  wire [1:0] modo;
  wire s_der, s_izq, s_out, dir;
  wire outMux;
  wire [1:0] canalesMux;

  assign canalesMux[0] = s_izq;
  assign canalesMux[1] = s_der;


//a[0] se selecciona con s0 y a[1] con s1
parameter notoe = 1'b0;

  mux derOizq(
	  .s(dir),
	  .a(canalesMux),
	  .notoe(notoe),
	  .y(outMux)
  );

  serialOcontiguo salida(
	  .usual(1'b0),
	  .s_in(outMux),
	  .modo(modo),
	  .out(s_out)
);

endmodule // ternarioDoble
