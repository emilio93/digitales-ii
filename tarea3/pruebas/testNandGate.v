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

`include "modulos/nandGate.v"
`timescale 1ns/1ps

module testNandGate;
  initial begin
    $display ("testNandGate");
    $dumpfile("tests/testNandGate.vcd");
    $dumpvars(0, testNandGate);
  end

  reg a, b;
  wire y;

  realtime inicio, retardo;

  initial begin
    inicio = $realtime;
    $monitor("%t | %b | %b | %b | %f ns", $time, a, b, y, retardo);

    $display("------------------------------------------");
    $display("Test para la compuerta NAND");
    $display("---------------------+---+---+---+--------");
    $display("              Tiempo | a | b | y | Retardo");
    $display("---------------------+---+---+---+--------");

    $display("x nand x = x");

    # 1000 a = 0;
    # 0 b = 1'bx;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("0 nand x = 1");

    # 1000 a = 1'bx;
    # 0 b = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("x nand 0 = 1");

    # 1000 a = 1;
    # 0 b = 1'bx;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("1 nand x = x");

    # 1000 a = 1'bx;
    # 0 b = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("x nand 1 = x");

    # 1000 a = 0;
    # 0 b = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("0 nand 0 = 1");

    # 1000 a = 1;
    # 0 b = 0;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("1 nand 0 = 1");

    # 1000 a = 0;
    # 0 b = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("0 nand 1 = 1");

    # 1000 a = 1;
    # 0 b = 1;
    # 0 retardo = 0;
    # 0 inicio = $realtime;
    $display("1 nand 1 = 0");

    # 1000 $finish;
  end

  always @ (y) begin
    retardo = $realtime-inicio;
  end

  nandGate nandGate1 (.a(a), .b(b), .y(y));
endmodule
