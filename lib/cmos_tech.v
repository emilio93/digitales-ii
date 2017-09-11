`timescale 1ns/1ps

module BUF(A, Y);
parameter tpdmin = 10;
parameter tpdmax = 14.2;
input A;
output Y;
assign # (tpdmin:tpdmax:tpdmax) Y = A;
endmodule

module NOT(A, Y);
parameter tpdmin = 5;   // ns, máximo de los mínimos
parameter tpdmax = 7.1; // ns, máximo de los máximos
input A;
output Y;
assign #(tpdmin:tpdmax:tpdmax) Y = ~A;
endmodule

module NAND(A, B, Y);

parameter tpdmin = 1.5;  // ns, máximo de los mínimos
parameter tpdmax = 11.1; // ns, máximo de los máximos

input A, B;
output Y;
assign # (tpdmin:tpdmax:tpdmax) Y = ~(A & B);
endmodule

module NOR(A, B, Y);
parameter tpdmin = 8.1;  // ns, máximo de los mínimos
parameter tpdmax = 11.4; // ns, máximo de los máximos
input A, B;
output Y;
assign # (tpdmin:tpdmax:tpdmax) Y = ~(A | B);
endmodule

module DFF(C, D, Q);
parameter tpmin = 1.5;
parameter tptyp = 7.7;
parameter tpmax = 10.5;

input C, D;
output reg Q;
always @(posedge C)
	# (tpmin:tptyp:tpmax) Q <= D;
endmodule

module DFFSR(C, D, Q, S, R);
parameter tpmin = 1.5;
parameter tptyp = 7.7;
parameter tpmax = 10.5;
input C, D, S, R;
output reg Q;
always @(posedge C, posedge S, posedge R)
	if (S)
		# (tpmin:tptyp:tpmax) Q <= 1'b1;
	else if (R)
		# (tpmin:tptyp:tpmax) Q <= 1'b0;
	else
		# (tpmin:tptyp:tpmax) Q <= D;
endmodule
