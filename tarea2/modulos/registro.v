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
  reg s_out;
  reg [3:0] q;

  always @(posedge clk) begin
    if (enb) begin

      // carga en serie
      if (modo == 2'b00) begin
        q <= dir ? {s_in, q[3:1]} : {q[2:0], s_in};
        s_out <= dir ? q[0] : q[3];
      end

      // ciclo
      if (modo == 2'b01) begin
        s_out <= 0;
        q <= dir ? {q[0], q[3:1]} : {q[2:0], q[3]};
      end

      // carga en paralelo
      if (modo == 2'b10) begin
          s_out <= 0;
          q <= d;
      end
    end
  end
endmodule
