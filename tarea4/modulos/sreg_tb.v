module pruebashift;
reg [3:0] D;
reg [1:0] MODE;
reg ENB;
reg S_IN;
reg CLK;
reg DIR;
wire [3:0] Q;
wire S_OUT;

rdesplazante r1(CLK,ENB, DIR, S_IN, MODE,D,Q,S_OUT);

always #1 CLK <= ~CLK;

initial begin
	$dumpfile("pruebashift.vcd");
	$dumpvars(0,pruebashift);
	CLK = 0;
	D = 4'b0001;
	S_IN = 1;
	MODE = 2'b00;
	DIR = 1;
	ENB = 0;

	$monitor("%t: %b \t Q: %b\t Load: %b Sale: %b entra: %b enable %b Dir: %b", $time, CLK, Q, D,S_OUT, S_IN, ENB, DIR);
	$display("Desplazamiento hacia la derecha:");
	#3 ENB = 1;//desp der
	#1 ENB = 1;
	#25
	S_IN = 0;
	$display("Desplazamiento hacia la izquierda:");
	DIR = 0;//desp izq
	#25
	S_IN = 1;
	#4 ENB = 0;
	#6 ENB = 1;
	$display("Rotación circular hacia la izquierda:");
	MODE = 2'b01;//rot izq
	#15
	$display("Rotación circular hacia la derecha:");
	DIR = 1;//rot der
	#10
	$display("Carga en paralelo:");
	MODE = 22'b10;//Carga en ||
	D = 4'b1010;
	#3;
	D = 4'b0000;
	#3;
	D = 4'b1011;
	#3;
	D = 4'b1111;
	#3;
	D = 4'b1001;
	#3;
	S_IN = 0;
	D = 4'b1111;
	#4

	$finish;
end
endmodule
