
// Modulo ternarioDoble
// Representa la línea
// y = s2 ? c : (s1 ? b : a); // *
// que es de bastante utilidad.
// Nótese que se puede utilizar ternario simple
// haciendo b = a y seleccionando con s2
// únicamente.
// *
// if (s2) c
// else if (s1) b
// else if (!s1) a
module ternarioDoble (
  input a,
  input b,
  input c,
  input s1,
  input s2,
  output y
);

  // Entradas salidas, todas son wire.
  wire a, b, c, s1, s2, y;

  // conexión entre muxes mediante la salida del mux 1
  // y la entrada en bajo del mux2.
  wire mux1__mux2;


  // Decide con s1 entre a(0) y b(1)
  mux mux1(
    .s(s1),
    .a({a, b}),
    .notoe(notoe),
    .y(mux1__mux2)
  );

  // Decide con s2 entre a, b(0) y c(1), finalmente da la salida.
  mux mux2(
    .s(s2),
    .a({mux1__mux2, c}),
    .notoe(notoe),
    .y(y)
  );
endmodule // ternarioDoble
