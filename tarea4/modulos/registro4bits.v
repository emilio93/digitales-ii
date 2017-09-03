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
  wire socMSBout, socLSBout;
  wire clkenb;

  serialOcontiguo socMSB(
    .usual(q[0]),
    .s_in(s_in),
    .modo(modo),
    .out(socMSBout)
  );

  serialOcontiguo socLSB(
    .usual(q[3]),
    .s_in(s_in),
    .modo(modo),
    .out(socLSBout)
  );

  enabler enabler1(
    .clk(clk),
    .enb(enb),
    .eclk(clkenb)
  );

  // El bitHolder 0 es el LSB
  bitHolder bitHolder0(
    .s_der(socLSBout),
    .s_izq(q[1]),
    .d_n(d[0]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[0])
  );

  bitHolder bitHolder1(
    .s_der(q[0]),
    .s_izq(q[2]),
    .d_n(d[1]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[1])
  );

  bitHolder bitHolder2(
    .s_der(q[1]),
    .s_izq(q[3]),
    .d_n(d[2]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[2])
  );

  bitHolder bitHolder3(
    .s_der(q[2]),
    .s_izq(socMSBout),
    .d_n(d[3]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[3])
  );

  wire [1:0] not_modo;
  wire is_modo_00;
  
  notGate notModo0(.a(modo[0]), .y(not_modo[0]));
  notGate notModo1(.a(modo[1]), .y(not_modo[1]));

  enabler modoCheck(.clk(not_modo[0]), .enb(not_modo[1]), .eclk(is_modo_00));

  ternarioDoble salida(
    .a(q[3]),
    .b(q[0]),
    .c(1'b0),
    .s1(dir),
    .s2(not_modo0),
    .y(s_out)
  );


endmodule // registro4bits
