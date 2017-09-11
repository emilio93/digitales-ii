GTK1=./*1.gtkw
GTK2=./*2.gtkw
GTK3=./*3.gtkw
EXE1=build/estructuralCmoslib
EXE2=build/estructuralGenerico
EXE3=build/2estructurales
SRC1=src/tests/cvssb.v
SRC2=src/tests/cvssg.v
SRC3=src/tests/et4vss.v
SRCT4=src/modulosT4/*.v
SRCT3=src/modulosT3/*.v

DELAY_MODE=-Ttyp
CC1=vvp
VPI=-M ~/.local/install/ivl/lib/ivl

all:
	iverilog ${SRC1} lib/cmos_cells.v  -o ${EXE1} ${DELAY_MODE}
	iverilog ${SRC2}  -o ${EXE2} ${DELAY_MODE}
	iverilog ${SRC3} ${SRCT4} ${SRCT3} lib/cmos_cells.v  -o ${EXE3} ${DELAY_MODE}

1:
	iverilog ${SRC1} lib/cmos_cells.v  -o ${EXE1} ${DELAY_MODE}

2:
	iverilog ${SRC2}  -o ${EXE2} ${DELAY_MODE}

3:
	iverilog ${SRC3} ${SRCT4} ${SRCT3} lib/cmos_cells.v  -o ${EXE3} ${DELAY_MODE}

s:	
	mkdir -p build
	yosys src/syn4bitreg.ys
	rm -f *.pid
	

run:
	$(foreach test,$(wildcard build/*estructural*), $(CC1) $(VPI) $(test);)
run1:
	vvp ${VPI} ${EXE1}
run2:
	vvp ${VPI} ${EXE2}
run3:
	vvp ${VPI} ${EXE3}

gtk1:
	gtkwave ${GTK1} &

gtk2:
	gtkwave ${GTK2} &

gtk3:
	gtkwave ${GTK3} &

clean:
	rm -rf build
