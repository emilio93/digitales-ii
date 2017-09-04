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
  Compuerta NAND
  74AC11000
  QUADRUPLE 2-INPUT POSITIVE-NAND GATE
  http://www.ti.com/lit/ds/symlink/74ac11000.pdf
  @ 3.3V
 */
module nandGate (
  input a,  // entrada 1
  input b,  // entrada 2
  output y  // salida
);

  parameter tpdmin = 1.5;  // ns, máximo de los mínimos
  parameter tpdmax = 11.1; // ns, máximo de los máximos

  parameter Vcc = 3.3; // V
  parameter Cl = 0.05; // nF, 50pF

  // solo lógica combinacional
  wire a, b, y;

  integer c;
  initial c=0;

  assign #(tpdmin:tpdmax:tpdmax) y = !(a & b);

  always @ (y) begin
    c=c+1;
    // $display("     Potencia disipada por la compuerta NAND: %f", c * Cl * Vcc);
  end
endmodule
