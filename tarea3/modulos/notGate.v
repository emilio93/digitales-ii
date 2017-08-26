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

`timescale 1ns/1ps

/*
  Compuerta NOT
  SN74AHC1G04
  Single Inverter Gate
  http://www.ti.com/lit/ds/symlink/sn74ahc1g04.pdf
 */
module notGate (
  input a,     // entrada es a
  output nota  // salida es no a
);

  // parámetros del componente
  parameter tpdmin = 5;
  parameter tpdmax = 7.1;
  parameter Cl = 0.0015;
  parameter Vcc = 3.3;

  // la compuerta not es lógica combinacional
  wire a;
  wire nota;

  // contador de disparos de la compuerta
  integer c;
  initial begin
    c = 0;
  end

  assign #(tpdmin:tpdmax:tpdmax) nota = ~a;

  always @(nota) begin
    c=c+1;
    $display("Potencia disipada por compuerta NOR: %f nW", c * Cl * Vcc);
  end

endmodule
