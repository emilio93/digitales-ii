SRC=src/*.v build/yosys_sreg_sintetizado.v
GTK=*.vcd
EXE=build/exe


all:
	iverilog src/test.v lib/cmos_cells.v  -o ${EXE}
s:
	mkdir -p build
	yosys src/syn4bitreg.ys
	rm -f *.pid

run:
	vvp -M ~/.local/install/ivl/bin ${EXE}

gtk:
	gtkwave ${GTK} &

clean:
	rm -rf build
