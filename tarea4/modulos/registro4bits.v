`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif
`ifndef ffD
  `include "../tarea3/modulos/ffD.v"
`endif
`ifndef bitHolder
  `include "./bitHolder.v"
`endif
`ifndef serialOcontiguo
  `include "./serialOcontiguo.v"
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
  parameter bits = 4;
  wire [bits-1:0] s_out_bit;
  wire socMSBout, socLSBout;
  wire clkenb;

  serialOcontiguo socMSB(
    .usual(s_out_bit[0]),
    .s_in(s_in),
    .modo(modo),
    .out(socMSBout)
  );

  serialOcontiguo socLSB(
    .usual(s_out_bit[bits-1]),
    .s_in(s_in),
    .modo(modo),
    .out(socLSBout)
  );

  // El bitHolder 0 es el LSB
  bitHolder bitHolder0(
    .s_der(socLSBout),
    .s_izq(s_out_bit[1]),
    .d_n(d[0]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out_bit[0])
  );

  bitHolder bitHolder1(
    .s_der(s_out_bit[0]),
    .s_izq(s_out_bit[2]),
    .d_n(d[0]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out_bit[1])
  );

  bitHolder bitHolder2(
    .s_der(s_out_bit[1]),
    .s_izq(s_out_bit[3]),
    .d_n(d[0]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out_bit[2])
  );

  bitHolder bitHolder3(
    .s_der(s_out_bit[1]),
    .s_izq(socMSBout),
    .d_n(d[0]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(s_out_bit[3])
  );


endmodule // registro4bits
