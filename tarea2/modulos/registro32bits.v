/*
  El módulo registro32bits hace uso del modulo registro, lo instancia ocho
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
  reg       s_out;
  reg [7:0]  s_in_interno;
  wire [7:0] s_out_interno;

  wire [1:0] modo_interno;

  assign modo_interno = (modo == 2'b01) ? 2'b00 : modo;

  // MSB
  registro r0(clk, enb, dir, s_in_interno[0], modo_interno, d[31:28], q[31:28], s_out_interno[0]);
  registro r1(clk, enb, dir, s_in_interno[1], modo_interno, d[27:24], q[27:24], s_out_interno[1]);
  registro r2(clk, enb, dir, s_in_interno[2], modo_interno, d[23:20], q[23:20], s_out_interno[2]);
  registro r3(clk, enb, dir, s_in_interno[3], modo_interno, d[19:16], q[19:16], s_out_interno[3]);
  registro r4(clk, enb, dir, s_in_interno[4], modo_interno, d[15:12], q[15:12], s_out_interno[4]);
  registro r5(clk, enb, dir, s_in_interno[5], modo_interno, d[11:8],  q[11:8],  s_out_interno[5]);
  registro r6(clk, enb, dir, s_in_interno[6], modo_interno, d[7:4],   q[7:4],   s_out_interno[6]);
  registro r7(clk, enb, dir, s_in_interno[7], modo_interno, d[3:0],   q[3:0],   s_out_interno[7]);
  // LSB

  // se actualiza s_out en flanco positivo
  always @ (posedge clk) begin
    s_out <= modo == 2'b00
            ? dir ? s_out_interno[7] : s_out_interno[0]
            : 0;

  end

  // La información interna se debe actualizar antes del flanco positivo
  always @ (negedge clk) begin
    s_in_interno[0] <= (modo == 2'b01)
                        ? dir ? q[0] : q[27]
                        : dir ? s_in : q[27];

    s_in_interno[1] <= dir ? q[28] : q[23];
    s_in_interno[2] <= dir ? q[24] : q[19];
    s_in_interno[3] <= dir ? q[20] : q[15];
    s_in_interno[4] <= dir ? q[16] : q[11];
    s_in_interno[5] <= dir ? q[12] : q[7];
    s_in_interno[6] <= dir ? q[8] : q[3];

    s_in_interno[7] <= (modo == 2'b01)
                        ? dir ? q[4] : q[31]
                        : dir ? q[4] : s_in;

  end
endmodule
