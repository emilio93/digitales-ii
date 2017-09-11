GTK1=build/*1.vcd
GTK2=build/*2.vcd
GTK3=build/*3.vcd
EXE1=build/estructuralCmoslib
EXE2=build/estructuralGenerico
EXE3=build/2estructurales
SRC1=src/tests/cvssb.v
SRC2=src/tests/cvssg.v
SRC3=src/tests/et4vss.v
SRCT4=src/modulosT4/*.v
SRCT3=src/modulosT3/*.v

all:
	iverilog ${SRC1} lib/cmos_cells.v  -o ${EXE1}
	iverilog ${SRC2}  -o ${EXE2}
	iverilog ${SRC3} ${SRCT4} ${SRCT3} lib/cmos_cells.v  -o ${EXE3}

1:
	iverilog ${SRC1} lib/cmos_cells.v  -o ${EXE1}

2:
	iverilog ${SRC2}  -o ${EXE2}

3:
	iverilog ${SRC3} ${SRCT4} ${SRCT3} lib/cmos_cells.v  -o ${EXE3}	

s:	
	mkdir -p build
	yosys src/syn4bitreg.ys
	rm -f *.pid
	
run1:
	vvp ${EXE1}
run2:
	vvp ${EXE2}
run3:
	vvp ${EXE3}

gtk1:
	gtkwave ${GTK1} &

gtk2:
	gtkwave ${GTK2} &

gtk3:
	gtkwave ${GTK3} &

clean:
	rm -rf build
