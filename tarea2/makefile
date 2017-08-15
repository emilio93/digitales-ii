OBJ = pruebas/registro/test1.v
OBJ1 = tests/registro/test1.vcd

CC = iverilog
CC1 = vvp
VISOR = gtkwave
DEBUG = -o

TARGET = build/registro/test1.o
TARGET1 = config_signals_gp.gtkw

all:   $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(OBJ) $(DEBUG) $(TARGET)
	$(CC1) $(TARGET)

look:
	$(VISOR) $(TARGET1)

values:
	$(CC1) $(TARGET)

clean:
	rm -f -R *.o *.vcd
