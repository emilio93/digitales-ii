module registro (
  input        clk,   // señal de reloj
  input        enb,   // habilitado,
                      // 1 : true
                      // 0 : false
  input        dir,   // dirección de rotación,
                      // 0 : izquierda
                      // 1 : derecha
  input        s_in,  // valor de entrada en serie cuando modo=00
  input  [1:0] modo,  // modo del contador, pueden ser
                      // 00 : carga en serie
                      // 01 : rotacion circular
                      // 10 : carga en paralelo
  input  [3:0] d,     // datos que se cargan en paralelo cuando modo=10
  output [3:0] q,     // estado del registro
  output s_out        // bit que sale cuando modo=00, es 0 para modo!=00
);
  wire s_out;
  reg [3:0] q;

  // s_out se asigna para evitar retrasos en modulos
  // utilizan el modulo registro
  assign s_out = modo == 2'b00
                 ? dir ? q[0] : q[3]
                 : 0;

  always @(posedge clk) begin
    // se chequea la señal de habilitado enb
    if (enb) begin

      // modo de carga en serie
      if (modo == 2'b00)      q <= dir ? {s_in, q[3:1]} : {q[2:0], s_in};

      // modo de ciclo
      else if (modo == 2'b01) q <= dir ? {q[0], q[3:1]} : {q[2:0], q[3]};

      // modo de carga en paralelo
      else if (modo == 2'b10) q <= d;
    end
  end
endmodule
