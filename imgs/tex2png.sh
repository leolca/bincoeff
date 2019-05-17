#!/bin/bash
if [ -e $1 ]
then
   TEX=$(<$1)
else
   TEX=$1
fi
echo -E "\documentclass[border=2pt]{standalone} 
\usepackage{amsmath}
\usepackage{varwidth}
\begin{document}
\begin{varwidth}{\linewidth}
\[ $TEX \]
\end{varwidth}
\end{document}" > tmp.tex
if [ -z "$2" ]
then
  if [ ${1: -4} == ".tex" ]
  then
     filename="${1%.tex}.png"
  else
     filename="$RANDOM.png"
  fi
else
  filename="$2"
fi
pdflatex tmp.tex
convert -density 300 tmp.pdf -quality 90 $filename
rm tmp.*
