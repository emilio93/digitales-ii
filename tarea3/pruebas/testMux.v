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

`include "modulos/mux.v"
`timescale 1ns/1ps
module testMux;
  initial begin
    $display ("testMux");
    $dumpfile("tests/testMux.vcd");
    $dumpvars(0, testMux);
  end

  reg s, notoe;
  reg [1:0] a;
  wire y;

  realtime inicio, retardo;

  initial begin
    inicio = $realtime;
    $monitor("%t | %b  | %b  | %b |  %b  | %b | %f ns", $time, s, a[0], a[1], notoe, y, retardo);

    $display("------------------------------------------");
    $display("Test para el MUX");
    $display("---------------------+----+----+---+-----+---+--------");
    $display("              Tiempo | a1 | a2 | s | ~oe | y | Retardo");
    $display("---------------------+----+----+---+-----+---+--------");

    # 1000 s = 0;
    # 0 notoe = 0;
    # 0 a = 2'b00;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 s = 1;
    # 0 notoe = 0;
    # 0 a = 2'b00;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 s = 1;
    # 0 notoe = 1;
    # 0 a = 2'b00;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 $finish;
  end

  always @ (y) begin
    retardo = $realtime-inicio;
  end

  mux mux1 (.s(s), .a(a), .notoe(notoe), .y(y));
endmodule
