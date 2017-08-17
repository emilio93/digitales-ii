/*
  El módulo registro32bits hace uso del modulo registro, lo intancia ocho
  veces y realiza las conexiones necesarias para mantener el comportamiento
  deseado del registro de desplazamiento.
 */
module registro32bits (
  input        clk,   // señal de reloj
  input        enb,   // habilitado, 1=true, 0=false
  input        dir,   // dirección de rotación, 0=izquierda , 1=derecha
  input        s_in,  // valor de entrada en serie cuando modo=00
  input  [1:0] modo,  // modo del contador, pueden ser
                      // 00 : carga en serie
                      // 01 : rotacion circular
                      // 10 : carga en paralelo
  input  [31:0] d,    // datos que se cargan en paralelo cuando modo=10
  output [31:0] q,    // estado del registro
  output s_out        // bit que sale cuando modo=00, es 0 para modo!=00
);
  wire       s_out;
  wire [7:0]  s_in_interno;
  wire [7:0] s_out_interno;

  // MSB
  registro r0(clk, enb, dir, s_in_interno[0], modo, d[31:28], q[31:28], s_out_interno[0]);
  registro r1(clk, enb, dir, s_in_interno[1], modo, d[27:24], q[27:24], s_out_interno[1]);
  registro r2(clk, enb, dir, s_in_interno[2], modo, d[23:20], q[23:20], s_out_interno[2]);
  registro r3(clk, enb, dir, s_in_interno[3], modo, d[19:16], q[19:16], s_out_interno[3]);
  registro r4(clk, enb, dir, s_in_interno[4], modo, d[15:12], q[15:12], s_out_interno[4]);
  registro r5(clk, enb, dir, s_in_interno[5], modo, d[11:8],  q[11:8],  s_out_interno[5]);
  registro r6(clk, enb, dir, s_in_interno[6], modo, d[7:4],   q[7:4],   s_out_interno[6]);
  registro r7(clk, enb, dir, s_in_interno[7], modo, d[3:0],   q[3:0],   s_out_interno[7]);
  // LSB

  // assign s_out_interno[0] = dir ? q[28] : q[31];
  // assign s_out_interno[1] = dir ? q[24] : q[27];
  // assign s_out_interno[2] = dir ? q[20] : q[23];
  // assign s_out_interno[3] = dir ? q[16] : q[19];
  // assign s_out_interno[4] = dir ? q[12] : q[15];
  // assign s_out_interno[5] = dir ? q[8]  : q[11];
  // assign s_out_interno[6] = dir ? q[4]  : q[7];
  // assign s_out_interno[7] = dir ? q[0]  : q[3];

  assign s_out = modo == 2'b00
                ? dir ? s_out_interno[0] : s_out_interno[7]
                : 0;

  assign s_in_interno[0] = dir ? (modo == 2'b01) ? s_out_interno[7] : s_in : s_out_interno[1];
  assign s_in_interno[1] = dir ? s_out_interno[0] : s_out_interno[2];
  assign s_in_interno[2] = dir ? s_out_interno[1] : s_out_interno[3];
  assign s_in_interno[3] = dir ? s_out_interno[2] : s_out_interno[4];
  assign s_in_interno[4] = dir ? s_out_interno[3] : s_out_interno[5];
  assign s_in_interno[5] = dir ? s_out_interno[4] : s_out_interno[6];
  assign s_in_interno[6] = dir ? s_out_interno[5] : s_out_interno[7];
  assign s_in_interno[7] = dir ? s_out_interno[6] : (modo ==2'b01) ? s_out_interno[0] : s_in;
endmodule
