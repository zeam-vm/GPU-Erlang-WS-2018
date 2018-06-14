PDF = manuscript.pdf

all: ${PDF}

%.pdf:  %.tex acmart.cls description.tex ACM-Reference-Format.bst reference.bib Hastega-arch.png Hastega-arch.pdf
	pdflatex $<
	- bibtex $*
	pdflatex $<
	pdflatex $<
	while ( grep -q '^LaTeX Warning: Label(s) may have changed' $*.log) \
	do pdflatex $<; done

description.tex: description.md
	@cat $^ \
	| pandoc -t latex \
	| sed 's/includegraphics/includegraphics[width=1.0\\columnwidth]/g' \
	| sed 's/\[htbp\]/\[t\]/g' \
	> description.tex 

#test.xbb: test.png
#	extractbb test.png

clean:
	@rm -rf description.{dvi,log,tex} manuscript.{pdf,aux,dvi,log,out,blg,bbl} *.xbb
	