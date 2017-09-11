DIRS = build tests pdfs

SYNT    = yosys
DOT2PDF = dot
CC      = iverilog
CC1     = vvp
VIEWER  = gtkwave

VPI = -M ~/.local/install/ivl/lib/ivl

MAKE_FOLDERS := $(shell mkdir -p $(DIRS))

all:
	$(foreach test,$(wildcard src/*.v), $(CC) -o build/$(subst src/,,$(subst .v,.o,$(test))) $(test) -Ttyp -g specify;)

s:
	$(foreach yosys,$(wildcard ./*.ys), $(SYNT) $(yosys);)
	$(foreach dot,$(wildcard ./*.dot), $(DOT2PDF) -Tpdf $(dot) -o pdfs/$(subst .dot,.pdf,$(dot));)
	$(foreach dot,$(wildcard ./*.dot), rm $(dot);)

run:
	$(foreach test,$(wildcard build/*.o), $(CC1) $(VPI) $(test);)

gtk:
	$(foreach writefile,$(wildcard tests/*.gtkw), $(VIEWER) $(writefile))

clean:
	rm -f -R build
	rm -f -R pdfs
	rm -f tests/*.vcd
	rm -f *.dot
