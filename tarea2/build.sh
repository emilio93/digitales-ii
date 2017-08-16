#!/bin/bash

# Lista de módulos que se
# compilan y prueban
declare -a modulos=(
  "modulos/registro.v"
  "modulos/registro32bits.v"
)

mkdir -p build
for modulo in ${modulos[@]}; do
  # modulos.replace("modulos/","")
  modulo=${modulo/modulos\//}
  # modulos.replace(".v","")
  modulo=${modulo/.v/}

  mkdir -p build/${modulo}
  mkdir -p tests/${modulo}

  echo "Modulo ${modulo}"

  for tb in pruebas/${modulo}/*.v; do
    # tb.replace("pruebas/", "${modulo}/")
    testbench=${tb/pruebas\/${modulo}\//}
    testbench=${testbench/.v/}
    echo "Testbench ${testbench}"

    iverilog -o build/${modulo}/${testbench} ${tb} modulos/registro.v modulos/registro32bits.v
    vvp -M ~/.local/install/ivl/lib/ivl build/registro/${testbench}
  done

done
