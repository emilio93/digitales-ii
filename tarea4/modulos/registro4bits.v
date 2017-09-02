`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif
`ifndef ffD
  `include "../tarea3/modulos/ffD.v"
`endif
`ifndef bitHolder
  `include "./bitHolder.v"
`endif

/*
  Modulo registro4bits

  Se utilizan las mismas entradas que el modulo conductual de la tarea 2.
 */
module registro4bits (
  input        clk,   // señal de reloj
  input        enb,   // habilitado,
                      //    1 : true
                      //    0 : false
  input        dir,   // dirección de rotación,
                      //    0 : izquierda
                      //    1 : derecha
  input        s_in,  // valor de entrada en serie cuando modo=00
  input  [1:0] modo,  // modo del contador, pueden ser
                      //    00 : carga en serie
                      //    01 : rotacion circular
                      //    10 : carga en paralelo
  input  [3:0] d,     // datos que se cargan en paralelo cuando modo=10
  output [3:0] q,     // estado del registro
  output s_out        // bit que sale cuando modo=00, es 0 para modo!=00
);



  // El bitHolder 0 es el LSB
  bitHolder bitHolder0(
    .s_der(s_der),
    .s_izq(s_izq),
    .d_n(d_n),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out)
  );



endmodule // registro4bits
