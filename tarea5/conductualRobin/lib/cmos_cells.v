
module BUF(A, Y);
input A;
output Y;
assign #5 Y = A;
endmodule

module NOT(A, Y);
input A;
output Y;
 assign #5 Y = ~A;
endmodule

module NAND(A, B, Y);
input A, B;
output Y;
 assign #5 Y = ~(A & B);
endmodule

module NOR(A, B, Y);
input A, B;
output Y;
 assign  #5 Y = ~(A | B);
endmodule

module DFF(C, D, Q);
input C, D;
output reg Q;
always @(posedge C)
#5	Q <= D;
endmodule

module DFFSR(C, D, Q, S, R);
input C, D, S, R;
output reg Q;
always @(posedge C, posedge S, posedge R)
	if (S)
#5		Q <= 1'b1;
	else if (R)
#5		Q <= 1'b0;
	else
#5		Q <= D;
endmodule

