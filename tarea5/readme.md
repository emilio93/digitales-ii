# Tarea 5
Robin Gonzalez y Emilio Rojas

## Instrucciones de ejecución
### Para la prueba sin retrasos
```bash
cd sin-retrasos # entrar a directorio sin-retrasos
make s          # sintetizar
make            # compilar con iverilog
make run        # correr con vvp
make gtk        # visualizar resultados
make clean      # limpiar
cd ..           # regresar a directorio raiz
```

### Para la prueba con retrasos
```bash
cd con-retrasos # entrar a directorio con-retrasos
make s          # realiza la sintesis de yosys con el archivo en src/yosyssrc
make            # compila el archivo de prueba
make run        # ejecuta los archivos de prueba
make gtk1       # abre gtkwave para ver el resultado 1
make gtk2       # abre gtkwave para ver el resultado 2
make gtk3       # abre gtkwave para ver el resultado 3
make clean      # borra todos archivos creados
cd ..           # regresar a directorio raiz
```

Organización en directorios:

```
├── con-retrasos
│   ├── conductual_sintesis_biblioteca1.gtkw
│   ├── conductual_sintesis_generica2.gtkw
│   ├── estrucutal_t4_estructural_biblioteca3.gtkw
│   ├── lib
│   │   ├── cmos_cells.lib
│   │   └── cmos_cells.v
│   ├── makefile
│   ├── readme
│   └── src
│       ├── modulosT3
│       │   ├── ffD.v
│       │   ├── mux.v
│       │   ├── nandGate.v
│       │   ├── norGate.v
│       │   └── notGate.v
│       ├── modulosT4
│       │   ├── bitHolder.v
│       │   ├── enabler.v
│       │   ├── salidaSerial.v
│       │   ├── serialOcontiguo.v
│       │   └── ternarioDoble.v
│       ├── registro4bits.v
│       ├── sreg1.v
│       ├── syn4bitreg.ys
│       ├── tests
│       │   ├── cvssb.v
│       │   ├── cvssg.v
│       │   └── et4vss.v
│       ├── test.v
│       └── yosyssrc
│           └── sreg.v
└── sin-retrasos
    ├── build.sh
    ├── lib
    │   ├── cmos_cells.lib
    │   └── cmos_cells.v
    ├── Makefile
    ├── modulos
    │   ├── sregconduct.v
    │   └── sreg.v
    ├── readme.md
    ├── registro.ys
    ├── src
    │   └── test.v
    └── tests
        └── rdesplazante.gtkw
```
