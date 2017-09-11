for file in ../*.dot
	do
	    mv -i "${file}" "${file/dot/pdf}"
	done
mkdir -p ../build/PDF
mv ../*pdf ../build/PDF
