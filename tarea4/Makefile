DIRS = build tests
CC = iverilog
CC1 = vvp
CC2 = gtkwave
VPI = -M ~/.local/install/ivl/lib/ivl
MAKE_FOLDERS := $(shell mkdir -p $(DIRS))

all:
	@$(foreach test,$(wildcard pruebas/test*.v), $(CC) -o build/$(subst pruebas/,,$(subst .v,,$(test))) $(test) -Ttyp -g specify;)

compile:
	@$(foreach test,$(wildcard pruebas/test*.v), $(CC) -o build/$(subst pruebas/,,$(subst .v,,$(test))) $(test) -Ttyp -g specify;)

compilemax:
	@$(foreach test,$(wildcard pruebas/test*.v), $(CC) -o build/$(subst pruebas/,,$(subst .v,,$(test))) $(test) -Tmax -g specify;)

compilemin:
	@$(foreach test,$(wildcard pruebas/test*.v), $(CC) -o build/$(subst pruebas/,,$(subst .v,,$(test))) $(test) -Tmin -g specify;)

run:
	@$(foreach test,$(wildcard build/test*), $(CC1) $(VPI) $(test);)

clean:
	@rm -R build
	@rm -R tests/*.vcd
