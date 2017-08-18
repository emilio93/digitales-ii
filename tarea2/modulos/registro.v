/**
 * Copyright 2017 Emilio Rojas
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/**
 * El modulo registro es un registro de desplazamiento con la posibilidad
 * de insertar bits hacia la izquierda/derecha, rotar circularmente en ambos
 * sentidos y carga en paralelo.
 */
module registro (
  input        clk,   // señal de reloj
  input        enb,   // habilitado,
                      // 1 : true
                      // 0 : false
  input        dir,   // dirección de rotación,
                      // 0 : izquierda
                      // 1 : derecha
  input        s_in,  // valor de entrada en serie cuando modo=00
  input  [1:0] modo,  // modo del contador, pueden ser
                      // 00 : carga en serie
                      // 01 : rotacion circular
                      // 10 : carga en paralelo
  input  [3:0] d,     // datos que se cargan en paralelo cuando modo=10
  output [3:0] q,     // estado del registro
  output s_out        // bit que sale cuando modo=00, es 0 para modo!=00
);

  reg s_out;
  reg [3:0] q;

  always @(posedge clk) begin
    if (modo == 2'b00) s_out <= dir ? q[0] : q[3];
    else s_out <= 0;

    // se chequea la señal de habilitado enb
    if (enb) begin

      // modo de carga en serie
      if (modo == 2'b00)      q <= dir ? {s_in, q[3:1]} : {q[2:0], s_in};

      // modo de ciclo
      else if (modo == 2'b01) q <= dir ? {q[0], q[3:1]} : {q[2:0], q[3]};

      // modo de carga en paralelo
      else if (modo == 2'b10) q <= d;
    end
  end
endmodule
