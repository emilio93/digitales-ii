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
  Flip Flop tipo D
  74AC11074
  Dual D-Type Positive-Edge-Triggered Flip-Flop
  http://www.ti.com/lit/ds/scas499a/scas499a.pdf
  @ 3.3V
 */
module ffD(
  input d,
  input clk,
  input notpreset,
  input notclear,
  output q,
  output notq
);
  wire d;
  wire clk;
  wire preset;
  wire clear;
  reg q;
  reg notq;

  // para cambios en not preset o notclear
  parameter tplhmin = 1.5;
  parameter tplhtyp = 5.8;
  parameter tplhmax = 9.3;
  parameter tphlmin = 1.5;
  parameter tphltyp = 6.5;
  parameter tphlmax = 11.4;

  // para cambios en clk
  parameter tplhclkmin = 1.5;
  parameter tplhclktyp = 7.7;
  parameter tplhclkmax = 10.5;
  parameter tphlclkmin = 1.5;
  parameter tphlclktyp = 7.3;
  parameter tphlclkmax = 9.7;

  parameter Vcc = 3.3; // V
  parameter Cl = 0.05; // nF => 50pF

  integer c;
  initial c = 0;

  always @ (posedge clk) begin
    if (notpreset & notclear) begin
      if (d) # (tplhclkmin:tplhclktyp:tplhclkmax) q <= d;
      else # (tphlclkmin:tphlclktyp:tphlclkmax) q <= d;
    end
  end

  always @ (*) begin
    if (~notpreset & notclear) begin
      #(tplhmin:tplhtyp:tplhmax) q <= 1;
    end else if (notpreset & ~notclear) begin
      #(tphlmin:tphltyp:tphlmax) q <= 0;
    end
  end

  always @ (q) begin
    notq <= ~q;
    c = c+1;
    $display("    Potencia disipada por el Flip Flop: %f", c * Cl * Vcc);
  end

endmodule
