#!/bin/bash

./permute.sh -n $1 -m $2 | awk '{for (i=1; i<=NF; i++) a[i-1]=$i; n=asort(a,sa); for (i=1;i<=n;i++) printf("%d ",sa[i]); printf("\n")}' | sort | uniq | # remove permutations which will have the same multinomial coefficient value
	awk -v n="$1" '{s=0; for (i = 1; i<= NF; i++) s+=$i; if (s<=n) print s " " $0;}' | sort -n | # select those that sum up to n
while read line; 
do
  ks="${line#* }"
  n="${line%% *}"
  cmd="./ymulticoeff $ks "; 
  result=$(eval $cmd);
  #nsum=$(echo $line | awk '{for (i = 1; i<= NF; i++) s+=$i} END{print s}')
  ks=${ks// /,}
  #echo -e "n=$nsum\t$line\t$result";
  echo -e "$n $ks $result";
done

# trinomials
# ./multicoefftable.sh 50 3 > multicoefftable_m3_max50.txt
