#!/bin/bash

for n in {0..100}
do 
	for k in $(seq 0 $n)
	do
		echo -ne $(./ybincoeff.py $n $k 256) 
		if [ $k != $n ]
		then
			echo -ne ', '
		else
			echo ''
		fi
	done
done
