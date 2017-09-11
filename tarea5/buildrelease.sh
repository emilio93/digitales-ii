rm -rf overleaf
git clone https://git.overleaf.com/10899557rnczpjsfvhcy ./overleaf
cd overleaf
pdflatex main.tex
pdflatex main.tex
cd ..
rm -rf release
mkdir release
cp overleaf/main.pdf release/b43011_b15680.pdf
cp readme.md release/readme.md
cp -r con-retrasos release/con-retrasos
cp -r sin-retrasos release/sin-retrasos
cd release 
zip -r b43011_b15680.zip .
cd ..
cp release/b43011_b15680.zip b43011_b15680.zip
