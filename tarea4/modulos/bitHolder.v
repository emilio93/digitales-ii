`ifndef notGate
  `include "../tarea3/modulos/notGate.v"
`endif
`ifndef mux
  `include "../tarea3/modulos/mux.v"
`endif
`ifndef ffD
  `include "../tarea3/modulos/ffD.v"
`endif
`ifndef ternarioDoble
  `include "modulos/ternarioDoble.v"
`endif

/*
  Modulo bitHolder
 */
module bitHolder (
  input s_der,      // Esta es la salida del bitHolder a la derechaen caso de
                    // ser el de más a la derecha(LSB) se analizan dos casos:
                    //  - se tiene modo de carga en serie: en este caso
                    //    s_der es s_in(del módulo padre), o la salida del
                    //    bitHolder más a la izquierda, dependiendo de la
                    //    dirección DIR que se tenga en el momento.
                    //  - se tiene rotación circular: en este caso s_der es la
                    //    salida del bit más a la derecha, o la salida del
                    //    bitHolder más a la izquierda, dependiendo de la
                    //    dirección DIR que se tenga en el momento.

  input s_izq,      // Esta es la salida del bitHolder a la izquierda, en caso
                    // de ser el bit más a la izquierda(MSB) se analizan dos
                    // casos:
                    //  - se tiene modo de carga en serie: en este caso
                    //    s_der es s_in(del módulo padre), o la salida del
                    //    bitHolder más a la izquierda, dependiendo de la
                    //    dirección DIR que se tenga en el momento.
                    //  - se tiene rotación circular: en este caso s_der es la
                    //    salida del bit más a la derecha.

  input d_n,         // Para cuando se tiene modo de carga en paralelo (MODO=1X),
                    // este es el bit que entra en el bitHolder.

  input dir,        // Esta es la dirección de la rotación o carga en serie.

  input [1:0] modo,       // Es el modo de movimiento que se le aplica al bit de
                    // entrada. Es un bus de dos bits, el primer bit(0), indica
                    // si se trata de carga en serie es 0, si se trata de
                    // rotación circular es 1. El segundo bit(1), indica con 1
                    // que se trata de carga en paralelo sin importar el primer
                    // bit.

  input clkenb,     // El bitHolder cambia su estado únicamente en los flancos
                    // positivos de clkenb.

  output s_out      // Es el número que estaba previamente en el bitHolder y
                    // sale de este.
);
  wire s_der, s_izq, d_n, dir, clkenb, clkenb_not, clkenb_ret;
  wire [1:0] modo;

  wire s_out;

  parameter notoe = 1'b0;

  wire d_in; // siguiente bit a ingresar

  wire nand1Y;

  ternarioDoble d_n_prima(
    .a(s_der),
    .b(s_izq),
    .c(d_n),
    .s1(dir),
    .s2(modo[1]),
    .y(d_in)
  );

  parameter notpreset = 1'b1;
  parameter notclear = 1'b1;

  wire notq;

  // se debe agregar un retraso.
  notGate ng1(.a(clkenb), .y(clkenb_not));
  notGate ng2(.a(clkenb_not), .y(clkenb_ret));

  ffD bitValue(
    .d(d_in),           // valor de entrada en flanco positivo cuando
                            // notclear y notpreset son 1.
    .clk(clkenb_ret),       // indica cuando cambia el estado en el flip flop
                            // esto es en los flancos positivos de (clk&enb)
    .notpreset(notpreset),  // si es 1 y notclear es 0, se carga 1 en el flip flop(asincrónico).
    .notclear(notclear),    // si es 1 y notpreset es 0, se carga 0 en el flip flop(asincrónico).
    .q(s_out),              // es el valor actual en el flip flop.
    .notq(notq)             // el valor negado de q
  );

endmodule // bitHolder
