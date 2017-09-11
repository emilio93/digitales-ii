`timescale 1ns/1ps


module rdesplazanteconduct(CLK, ENB,DIR,S_IN,MODE,D,Q,S_OUT);
input [3 : 0] D;
input [1:0] MODE;
input ENB,S_IN,CLK,DIR;
output reg [3:0] Q;
output reg S_OUT;

always@(posedge CLK)
	if(ENB) begin
		if(MODE === 2'b00) begin//desplazamiento
			S_OUT = 1;
			if(!DIR) begin//izq
			       	Q[3:0] <= {Q[2:0],S_IN};
				S_OUT <= Q[3];
			end
			else begin//der
			       	Q[3:0] <= {S_IN,Q[3:1]};
				S_OUT <= Q[0];
			end

		end
		if(MODE === 2'b01) begin//rotación
			if(!DIR) begin//izq
				Q[3:1] <= Q[2:0];
				Q[0] <= Q[3];
				end
				else begin//der
					Q[3] <= Q[0];
					Q[2:0] <= Q[3:1];
				end
		end
		if(MODE === 2'b10) begin//carga en paralelo
			Q <= D;
		end
end

endmodule
