#!/bin/bash

if [ -e $1 ]
then
   TEX=$(<$1)
else
   TEX=$1
fi

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

if [ -z "$3" ]
then
   density="150"
else
   density="$3"
fi

echo -E "\documentclass[border=2pt]{standalone} 
\usepackage{amsmath}
\usepackage{varwidth}
\begin{document}
\begin{varwidth}{\linewidth}
\[ $TEX \]
\end{varwidth}
\end{document}" > tmp.tex

pdflatex tmp.tex
convert -density $density tmp.pdf $filename
rm tmp.*
