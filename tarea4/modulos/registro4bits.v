/*
  Modulo registro4bits

  Se utilizan las mismas entradas que el modulo conductual de la tarea 2.
 */
module registro4bits (
  input        clk,   // señal de reloj
  input        enb,   // habilitado,
                      //    1 : true
                      //    0 : false
  input        dir,   // dirección de rotación,
                      //    0 : izquierda
                      //    1 : derecha
  input        s_in,  // valor de entrada en serie cuando modo=00
  input  [1:0] modo,  // modo del contador, pueden ser
                      //    00 : carga en serie
                      //    01 : rotacion circular
                      //    10 : carga en paralelo
  input  [3:0] d,     // datos que se cargan en paralelo cuando modo=10
  output [3:0] q,     // estado del registro
  output s_out        // bit que sale cuando modo=00, es 0 para modo!=00
);
  parameter bits = 4;
  wire socMSBout, socLSBout;
  wire clkenb,s_out;



  serialOcontiguo socMSB(
    .usual(q[0]),
    .s_in(s_in),
    .modo(modo),
    .out(socMSBout)
  );

  serialOcontiguo socLSB(//modulo2
    .usual(q[3]),
    .s_in(s_in),
    .modo(modo),
    .out(socLSBout)
  );

  enabler enabler1(//modulo3
    .clk(clk),
    .enb(enb),
    .eclk(clkenb)
  );

  // El bitHolder 0 es el LSB
  bitHolder bitHolder0(//modulo4
    .s_der(socLSBout),
    .s_izq(q[1]),
    .d_n(d[0]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[0])
  );

  bitHolder bitHolder1(//modulo5
    .s_der(q[0]),
    .s_izq(q[2]),
    .d_n(d[1]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[1])
  );

  bitHolder bitHolder2(//modulo6
    .s_der(q[1]),
    .s_izq(q[3]),
    .d_n(d[2]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[2])
  );

  bitHolder bitHolder3(//modulo7
    .s_der(q[2]),
    .s_izq(socMSBout),
    .d_n(d[3]),
    .dir(dir),
    .modo(modo),
    .clkenb(clkenb),
    .s_out(q[3])
  );

  wire [1:0] not_modo;
  wire is_modo_00;

  notGate notModo0(.a(modo[0]), .y(not_modo[0]));
  notGate notModo1(.a(modo[1]), .y(not_modo[1]));

  enabler modoCheck(.clk(not_modo[0]), .enb(not_modo[1]), .eclk(is_modo_00));//?

  parameter notpreset = 1'b1;
  parameter notclear = 1'b1;
  wire notq;
  wire s_out_tran;
  wire s_out_ff;
  ffD s_out_reg(
    .d(s_out_tran),               // valor de entrada en flanco positivo cuando
                            // notclear y notpreset son 1.
    .clk(clkenb),       // indica cuando cambia el estado en el flip flop
                            // esto es en los flancos positivos de (clk&enb)
    .notpreset(notpreset),  // si es 1 y notclear es 0, se carga 1 en el flip flop(asincrónico).
    .notclear(notclear),    // si es 1 y notpreset es 0, se carga 0 en el flip flop(asincrónico).
    .q(s_out_ff),              // es el valor actual en el flip flop.
    .notq(notq)             // el valor negado de q
  );


  ternarioDoble salida(
    .a(s_out_ff),
    .b(1'b0),
    .c(1'b0),
    .s1(dir),
    .s2(not_modo[0]),
    .y(s_out)
  );


endmodule // registro4bits
