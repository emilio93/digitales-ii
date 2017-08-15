#!/bin/bash

declare -a modulos=(
  "modulos/registro.v"
  "modulos/registro32bits.v"
)

mkdir -p build
# for modulo in modulos/*.v; do
for modulo in ${modulos[@]}; do
  modulo=${modulo/modulos\//}
  modulo=${modulo/.v/}

  mkdir -p build/${modulo}
  mkdir -p tests/${modulo}

  echo "MODULO ${modulo}"

  for tb in pruebas/${modulo}/*.v; do

    testbench=${tb/pruebas\/${modulo}\//}
    testbench=${testbench/.v/}
    echo "    Testbench ${testbench}"

    iverilog -o build/registro/${testbench} ${tb}
    vvp -M ../iverilog/vpi build/registro/${testbench}
    #statements
  done

done
