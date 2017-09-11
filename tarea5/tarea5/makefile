GTK=build/*.vcd
EXE=build/exe


all:
	iverilog src/test.v lib/cmos_cells.v  -o ${EXE}
s:	
	mkdir -p build
	yosys src/syn4bitreg.ys
	rm -f *.pid
	
run:
	vvp ${EXE}

gtk:
	gtkwave ${GTK} &

clean:
	rm -rf build
