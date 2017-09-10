#!/bin/bash

mkdir -p build
yosys registro.ys

mkdir -p pdfs
for archivo in ./*.dot; do
  archivo="${archivo/.dot/}"
  echo  "dot -Tpdf ${archivo}.dot -o pdfs/${archivo}.pdf"
  dot -Tpdf ${archivo}.dot -o pdfs/${archivo}.pdf
  rm ${archivo}.dot
done

# rm *.dot
