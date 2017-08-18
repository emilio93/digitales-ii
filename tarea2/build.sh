#!/bin/bash

# Lista de módulos
declare -a modulos=(
  "modulos/registro.v"
  "modulos/registro32bits.v"
)

# process_tb tb modulo compile test view
function process_tb() {
  tb=$1
  modulo=$2
  compile=$3
  test=$4
  view=$5

  testbench=${tb/pruebas\/${modulo}\//}
  testbench=${testbench/.v/}

  if [ "$compile" == "true" ] || [ "$test" == "true" ] || [ "$view" == "true" ]; then
    echo "Testbench ${testbench}"
    echo "**********************"
  fi

  if [ "$compile" == "true" ]; then
    echo "iverilog -o build/${modulo}/${testbench} ${tb} modulos/registro.v modulos/registro32bits.v
    "
    iverilog -o build/${modulo}/${testbench} ${tb} modulos/registro.v modulos/registro32bits.v
  fi

  if [ "$test" == "true" ]; then
    echo "vvp build/${modulo}/${testbench}
    "
    vvp build/${modulo}/${testbench}
  fi

  if [ "$view" == "true" ]; then
    echo "gtkwave tests/${modulo}/${testbench}.gtkw
    "
    gtkwave tests/${modulo}/${testbench}.gtkw
  fi
}

# process_modulo(modulo, compile, test, view)
function process_modulo() {
  modulo=$1
  compile=$2
  test=$3
  view=$4

  if [ "$compile" == "true" ] || [ "$test" == "true" ] || [ "$view" == "true" ]; then
    echo "** Modulo ${modulo}"
    echo "**********************"
  else
    echo "Asignando banderas de compilación y tests"
    compile="true"
    test="true"
  fi

  # modulos.replace("modulos/","")
  modulo=${modulo/modulos\//}
  # modulos.replace(".v","")
  modulo=${modulo/.v/}

  mkdir -p build/${modulo}
  mkdir -p tests/${modulo}

  for tb in pruebas/${modulo}/*.v; do
    process_tb "$tb" "$modulo" "$compile" "$test" "$view"
  done
}

compile='false'
test='false'
view='false'
while getopts 'ctv' flag; do
  case "${flag}" in
    c) compile='true' ;;
    t) test='true' ;;
    v) view='true' ;;
    *) error "Unexpected option ${flag}" ;;
  esac
done

mkdir -p build

for modulo in ${modulos[@]}; do
  process_modulo "$modulo" "$compile" "$test" "$view"
done
