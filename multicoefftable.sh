#!/bin/bash

# help
display_help() {
    echo "Usage: $0 [option...] " >&2
    echo "Example (trinomials)"
    echo "   ./multicoefftable.sh -n 50 -m 3 -p > multicoefftable_m3_max50.txt"
    echo
    echo "   -h, --help     Display this help message"
    echo "   -n, --level    Specify the multinomial maximum level"
    echo "   -m, --degree   Specity the multinomial degree (2: binomial, 3: trinomial, etc.)"
    echo "   -p, --remove   Remove permutations"
    echo
    exit 1
}

# As long as there is at least one more argument, keep looping
while [[ $# -gt 0 ]]; do
    key="$1"
    case "$key" in
        -n|--level)
        shift # past the key and to the value
        N=$1
        ;;
        -m|--degree)
        shift # past the key and to the value
        M=$1
        ;;
        -p|--remove)
	FLG=true
	;;
        # display help
        -h|--help)
        display_help  # Call your function
        exit 0
        ;;
        *)
    esac
    shift
done

if [ "$FLG" = true ] ; then
  ./permute.sh -n $N -m $M |
  # remove permutations which will have the same multinomial coefficient value
  awk '{for (i=1; i<=NF; i++) a[i-1]=$i; n=asort(a,sa); for (i=1;i<=n;i++) printf("%d ",sa[i]); printf("\n")}' | sort | uniq 
else
  ./permute.sh -n $N -m $M | sed 's/^ *//g'
fi  |
awk -v n="$N" '{s=0; for (i = 1; i<= NF; i++) s+=$i; if (s<=n) print s " " $0;}' | sort -n | # select those that sum up to n
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
# ./multicoefftable.sh -n 50 -m 3 -p > multicoefftable_m3_max50.txt
