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
  MUX
  SN74CBTLV3257
  Low-Voltage 4-Bit 1-of-2 FET Multiplexer/Demultiplexer
  http://www.ti.com/lit/ds/symlink/sn74cbtlv3257.pdf
  @ 3.3V

  Los canales son de 4 bits pero solo se implementa 1 solo bit.
 */
module mux(
  input s,
  input [1:0] a,
  input notoe, // not output enabled ~(OE), cuando está en 1, el mux no funciona
  output y
);
  wire s;
  wire a;
  wire notoe;
  reg y;

  parameter tpin = 0.25; // Retraso de la entrada

  // Propagation Delay(retraso de propagación)
  parameter tpdmin = 1.8; // maximo de los mínimos para ir de a->y y de s->y
  parameter tpdmax = 5.3; // maximo de los máximos para ir de a->y y de s->y

  // Retraso para conectar, notoe -> y
  parameter tenmin = 2;
  parameter tenmax = 5.3;

  // Retraso para desconectar, notoe -> y
  parameter tdismin = 1.6;
  parameter tdismax = 5.5;

  parameter Vcc = 3.3; // V
  parameter Cl = 0.05; // nF => 50pF

  integer c;
  initial c = 0;

  // esta es la señal retrasada de la entrada
  reg aRet;

  always @ (*) begin
    // cambio hacia desconectado
    if (notoe) begin
      #(tdismin:tdismax:tdismax) y = 1'bz;
    // conectado
    end else begin
      // desde desconectado
      if (a == 1'bz) begin
        #(tpdmin:tpdmax:tpdmax) y = aRet;
        // desde una seleccion de canal previa
      end else begin
        #(tpdmin:tpdmax:tpdmax) y = aRet;
      end
    end
  end

  // Retraso que sufre la entrada
  always @ (a) begin
    #tpin aRet = a;
  end

  // incrementar contador
  always @ (y) begin  
    c = c+1;
    $display("    Potencia disipada por el MUX: %f", c * Cl * Vcc);
  end
endmodule // mux
