#!/bin/bash

# octave --silent --eval "multicoeffparallelbenchmark ('multicoefftable_m3_max10.txt', 'ymulticoeff')" 
declare -a mcoefunctions=('ymulticoeff' 'gmulticoeff' 'multicoeff' 'armulticoeff' 'aymulticoeff' 'vfmulticoeff' 'fftmulticoeff' 'lemulticoeff')

for method in "${mcoefunctions[@]}"
do
   echo "$method"
   octave --eval "multicoeffparallelbenchmark ('multicoefftable_m3_n100_all.txt', '$method');" &
done

