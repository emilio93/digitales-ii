module salidaSerial (
  input [1:0] modo,
  input s_der,
  input s_izq,
  input dir,
  output s_out
);

  // Entradas salidas, todas son wire.
  wire [1:0] modo;
  wire s_der, s_izq, s_out, dir;
  wire outAnd;



  enabler andGate(
	  .clk(modo[0]),
	  .enb(modo[1]),
	  .eclk(outAnd)
  );

  ternarioDoble salida(
	  .a(s_izq),
	  .b(s_der),
	  .c(1'b0),
	  .s1(dir),
	  .s2(outAnd),
	  .y(s_out)
  );

endmodule // ternarioDoble
