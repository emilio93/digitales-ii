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

  parameter tpdmin = 1.5; // ns
  parameter tpdmax = 11.1; // ns

  wire a, b;
  wire y;

  integer c;
  initial begin
    c=0;
    $display ("Compuerta NAND");
  end

  assign #(tpdmin:tpdmax:tpdmax) Y = !(a & b);

  parameter Vcc = 3.3; // V
  parameter Cl = 0.05; // nF

  always @(Y) begin
    c=c+1;
    $display("Potencia disipada: %f unidades", c * Cl * Vcc);
  end

endmodule
