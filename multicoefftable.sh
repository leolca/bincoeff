#!/bin/bash

./permute.sh -n $1 -m $2 |
while read line; 
do 
  cmd="./ymulticoeff $line "; 
  result=$(eval $cmd);
  line=${line// /,}
  echo -e "$line\t$result";
done


# trinomials
# ./multicoefftable.sh 50 3 multicoefftable_m3_max50.txt
