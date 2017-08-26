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

`include "modulos/ffD.v"
`timescale 1ns/1ps
module testFfD;
  initial begin
    $display ("testFfD");
    $dumpfile("tests/testFfD.vcd");
    $dumpvars(0, testFfD);
  end

  reg d, clk, notpreset, notclear;
  wire q, notq;

  realtime inicio, retardo;

  initial begin
    inicio = $realtime;
    $monitor("%t | %b | %b   | %b    | %b    | %b  | %b  | %f ns", $time, d, clk, notpreset, notclear, q, notq, retardo);

    $display("------------------------------------------");
    $display("Test para el Flip Flop");
    $display("---------------------+---+-----+------+------+----+----+--------");
    $display("              Tiempo | d | clk | ~pre | ~clr |  q | ~q | Retardo");
    $display("---------------------+---+-----+------+------+----+----+--------");

    // Se carga 0 inicialmente
    # 0 clk = 0;

    # 1000 d = 0;
    # 0 notpreset = 1;
    # 0 notclear = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    // Se carga 1
    # 1000 d = 1;
    # 0 notpreset = 1;
    # 0 notclear = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    // se prueba notpreset
    # 1000 d = 1'bx;
    # 0 notpreset = 0;
    # 0 notclear = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    // se prueba notclear
    # 1000 d = 1'bx;
    # 0 notpreset = 1;
    # 0 notclear = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 clk = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;

    # 1000 $finish;
  end

  always @ (q) begin
    retardo = $realtime-inicio;
  end

  ffD ffD1 ( .d(d), .clk(clk), .notpreset(notpreset), .notclear(notclear), .q(q), .notq(notq));
endmodule
