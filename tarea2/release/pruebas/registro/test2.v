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

module test2;
  initial begin
    $display("Test Bench 2 registro");
    $display("Prueba la funcionalidad de carga en serie a la derecha");
    $display("********************************************************");
    $dumpfile("tests/registro/test2.vcd");
    $dumpvars(0, test2);
  end
  reg clk  = 0;
  reg enb  = 1;
  reg dir  = 1;
  reg s_in = 1;

  reg [1:0] modo  = 2'b00;
  reg [3:0] d     = 4'b0000;

  wire [3:0] q;
  wire s_out;

  registro registro1(clk, enb, dir, s_in, modo, d, q, s_out);

  always #1 clk = ~clk;

  initial begin

    // Se carga D = 0101
    #0 modo = 2'b10;
    #0 dir = 1;
    #0 s_in = 1;
    #0 d = 4'b0101;
    #1;
    // modo de carga en serie
    #2 modo = 2'b00; // cargar 1's
    #10 s_in = 2'b0; // cargar 0's

    // secuencia
    #2 s_in = 2'b0;
    #2 s_in = 2'b0;
    #2 s_in = 2'b1;
    #2 s_in = 2'b1;
    #2 s_in = 2'b1;
    #2 s_in = 2'b0;

    // Se carga D = 0101
    #2 modo = 2'b10;
    #2 dir = 1;
    #2 s_in = 1;
    #2 d = 4'b1101;

    // modo de carga en serie
    #2 modo = 2'b00; // cargar 1's
    #6 s_in = 2'b0; // cargar 0's

    #8 $finish;
  end

  initial begin
    $display("\t\ttiempo\tdir\ts_in\tmodo\td\tq\ts_out\n");
    $monitor(
      "%d", $time,
      "\t%b", dir,
      "\t%b", s_in,
      "\t%2b", modo,
      "\t%4b", d,
      "\t%4b", q,
      "\t%b", s_out);
  end
endmodule
