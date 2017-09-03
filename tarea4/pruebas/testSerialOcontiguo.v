`timescale 1ns/1ps

/*
El módulo serialOcontiguo se encarga de
 */
module testserialOcontiguo ();
  reg usual, s_in;
  reg [1:0] modo;
  wire out;

  parameter retardos = 40;

  serialOcontiguo tester(
    .usual(usual),
    .s_in(s_in),
    .modo(modo),
    .out(out)
  );

 initial begin
    usual = 0;
    modo = 2'b0;
    s_in = 0;
#retardos
    usual = 1;
    modo = 2'b0;
    s_in = 0;
#retardos
    usual = 1;
    modo = 2'b01;
    s_in = 0;
#retardos
    usual = 1;
    modo = 2'b01;
    s_in = 0;
#retardos
    usual = 1;
    modo = 2'b10;
   s_in = 1;
#retardos
    usual = 1;
    modo = 2'b10;
    s_in = 0;
#retardos
    usual = 0;
    modo = 2'b10;
   s_in = 1;
#retardos
    usual = 1;
    modo = 2'b10;
   s_in = 0;
#retardos
     usual = 0;
    modo = 2'b10;
   s_in = 1;
#retardos
     usual = 1;
    modo = 2'b10;
   s_in = 1;
#retardos
    usual = 1;
    modo = 2'b11;
    s_in = 0;
#retardos
    usual = 0;
    modo = 2'b11;
    s_in = 0;
#retardos
    usual = 1;
    modo = 2'b10;
    s_in = 1;
#retardos
    usual = 0;
    modo = 2'b10;
    s_in = 1;
#retardos
    usual = 1;
    modo = 2'b00;
    s_in = 1;
#retardos
    usual = 0;
    modo = 2'b00;
    s_in = 0;
#retardos
    usual = 0;
    modo = 2'b00;
    s_in = 1;
#retardos
    usual = 1;
    modo = 2'b00;
    s_in = 1;
#retardos
    usual = 1;
    modo = 2'b00;
    s_in = 0;
#retardos
    usual = 0;
    modo = 2'b00;
    s_in = 1;
#retardos
    usual = 0;
    modo = 2'b00;
    s_in = 0;
#retardos
    usual = 1;
    modo = 2'b00;
    s_in = 1;
end

  initial
    begin
    $dumpfile("./testSerialOcontiguo.vcd");
    $dumpvars();
    $display ("\t     tiempo | usual | s_in | modo | out ");
    $monitor             ("%t| %b    | %b     | %b   | %b",
                          $time, usual, s_in, modo, out);
  #2650
    $finish;
  end
endmodule
