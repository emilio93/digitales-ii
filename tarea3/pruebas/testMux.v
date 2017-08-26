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

  reg a = 0;
  reg b = 0;
  reg temp;

  parameter tpdm = 800;  //min, same for high and low,, T = –40°C to 85°C, vcc ~ 3.3
  parameter tpdM = 3800; //max, ... , this will be the typical, as we're modeling for a worst case scenario
  wire out;

  initial begin
    $monitor("%t | %b | %b | %b", $time, a, b, out );

    $display("\nTest para el MUX");
    $display("----------------\n");
    $display("              Tiempo | A | B | OUT");
    $display("---------------------+---+---+----");

    # 4000 a = 1;
    $display("Output starts in 1 (after delay), this shouldn't change it");
    # 4000 b = 1;
    $display("!(1&1) = 0");
    # 4000 b = 1'bx;
    $display("!(1&x) = x");
    # 4000 a = 1'bx;
    $display("!(x&x) = x");
    # 4000 a = 0;
    $display("!(0&x) = 1");
    # 4000 a = 0; b = 1;
    $display("Testing time requirements.");
    # 2000 a = 1; b = 1;
    # 4000 $finish;
  end

  always @ (a,b) begin
    temp = !( a & b );
    #(tpdm:tpdM:tpdM);
    if( !( a & b ) !== temp) begin
      $display("\n\n******ERROR: Time requirements not satisfied. Output is undefined.*******\n at interval:%t -%t\n\n", $time-(tpdm:tpdM:tpdM),$time);
      $finish;
    end
  end
endmodule
