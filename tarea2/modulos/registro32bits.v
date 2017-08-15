`include "modulos/registro.v"

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
  initial begin
    $display("Modulo registro32bits");
  end

  reg        s_out;
  reg [7:0]  s_in_tr;
  wire [7:0] s_out_tr;

  registro r1(clk, enb, dir, s_in_tr[0], modo, d[31:28], q[31:28], s_out_tr[0]);
  registro r2(clk, enb, dir, s_in_tr[1], modo, d[27:24], q[27:24], s_out_tr[1]);
  registro r3(clk, enb, dir, s_in_tr[2], modo, d[23:20], q[23:20], s_out_tr[2]);
  registro r4(clk, enb, dir, s_in_tr[3], modo, d[19:16], q[19:16], s_out_tr[3]);
  registro r5(clk, enb, dir, s_in_tr[4], modo, d[15:12], q[15:12], s_out_tr[4]);
  registro r6(clk, enb, dir, s_in_tr[5], modo, d[11:8],  q[11:8],  s_out_tr[5]);
  registro r7(clk, enb, dir, s_in_tr[6], modo, d[7:4],   q[7:4],   s_out_tr[6]);
  registro r8(clk, enb, dir, s_in_tr[7], modo, d[3:0],   q[3:0],   s_out_tr[7]);

  always @ (posedge clk) begin
    // Conexiones para derecha
    if (dir) begin
      // esto diferencia cuando es circular
      s_in_tr[0] <= (modo == 2'b01) ? s_out_tr[7] : s_in;
      s_in_tr[1] <= s_out_tr[0];
      s_in_tr[2] <= s_out_tr[1];
      s_in_tr[3] <= s_out_tr[2];
      s_in_tr[4] <= s_out_tr[3];
      s_in_tr[5] <= s_out_tr[4];
      s_in_tr[6] <= s_out_tr[5];
      s_in_tr[7] <= s_out_tr[6];

      s_out <= s_out_tr[7];
    end
    // Conexiones para izquierda
    else if (~dir) begin
      // esto diferencia cuando es circular
      s_in_tr[0] <= modo == 2'b01 ? s_out_tr[7] : s_out_tr[1];
      s_in_tr[1] <= s_out_tr[2];
      s_in_tr[2] <= s_out_tr[3];
      s_in_tr[3] <= s_out_tr[4];
      s_in_tr[4] <= s_out_tr[5];
      s_in_tr[5] <= s_out_tr[6];
      s_in_tr[6] <= s_out_tr[7];
      s_in_tr[7] <= s_in;

      s_out <= s_out_tr[0];
    end
  end
endmodule
