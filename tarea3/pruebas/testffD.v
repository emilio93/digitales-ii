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


// Se utiliza el archivo modulos/ffD.v (ruta relativa a de donde se corre la
// prueba)
`include "modulos/ffD.v"

// Escala de tiempo indica que la medida de tiempo es un nanosegundo (1ns=1e-9s)
// y la mínima división de tiempo es un picosegundo (1ps=1e-12s).
// Esto significa que la simulación realizara un cálculo del estado del circuito
// cada 1ps, y que se hagan 1000 (1000ps=1ns)de estos cada unidad de tiempo.
`timescale 1ns/1ps

/*
  Módulo testFfD

  Este módulo prueba el componente descrito por el módulo ffD.
  Este módulo indica que se escribira un archivo en tests/testFfD.vcd con los
  resultados de la prueba (se puede abrir con gtkwave).

  Para la prueba se inicializa un módulo ffD con señales de entrada controladas
  a través del tiempo para obtener los resultados en las salidas en esos mismos
  instantes de tiempo.

  Las entradas del ffD(que instanciado se llama ffD1) son: d, clk, notpreset,
  notclear.
  Las salidas son q, notq.
  Las salidas deseadas pueden obtenerse de ver la hoja del fabricante que se
  indica en el archivo para el módulo ffD. Se utilizan los mismos nombres que
  utiliza la hoja del fabricante para las distintas señales.

  La secuencia de entradas se encuentra en el último bloque initial.
 */
module testFfD;

  // Se imprime el nombre del módulo y
  initial begin
    $display ("testFfD");
    $dumpfile("tests/testFfD.vcd");
    $dumpvars(0, testFfD);
  end

  // Las entradas del ffD son todas reg debido a que son
  // controladas a lo largo del tiempo.
  reg d, clk, notpreset, notclear;

  // Las salidas están atadas al módulo ffD, este es quien
  // define su valor, por lo que en el exterior no se tiene manera
  // de modificarlas. Por eso se definen wires.
  wire q, notq;

  // Para medir el tiempo de las transiciones se mide siempre
  // la diferencia del tiempo en que inicio el cambio y en el
  // que acabó.
  realtime inicio, retardo;

  // Instancianción del módulo ffD, como ffD1. Las entradas
  // y salidas son las que se definieron previamente.
  ffD ffD1 (
    .d(d),
    .clk(clk),
    .notpreset(notpreset),
    .notclear(notclear),
    .q(q),
    .notq(notq)
  );

  // Para medir el tiempo de retardo de la señal
  // entre las entradas y la salida, se le resta al
  // tiempo que inicio la transición, el tiempo actual
  // que sucede una vez que la salida q haya terminado
  // su transición.
  //
  // El tiempo inicio se reasigna cada vez que se cambian
  // entradas al módulo.
  always @ (q) begin
    retardo = $realtime-inicio;
  end

  initial begin

    // imprimir cada vez que cambia alguno de los elementos indicados.
    $monitor("%t | %b | %b   | %b    | %b    | %b  | %b  | %f ns",
            $time, d, clk, notpreset, notclear, q, notq, retardo);

    // indicar que se trata de los tests para el flip flop.
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

endmodule
