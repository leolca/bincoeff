#!/bin/bash
# help
display_help() {
    echo "Usage: $0 [option...] " >&2
    echo
    echo "   -h, --help                 Display this help message"
    echo "   -n, --max 	                Specify a maximum value"
    echo "   -m, --params               Specify number of parameters"
    echo
    exit 1
}

# As long as there is at least one more argument, keep looping
while [[ $# -gt 0 ]]; do
    key="$1"
case "$key" in
        -n|--max)
        shift # past the key and to the value
        MAX="$1"
        ;;
        -m|--params)
        shift # past the key and to the value
        M="$1"
        ;;
	# display help
        -h | --help)
        display_help  # Call your function
        exit 0
        ;;
        *)
        VALUE="$1"
        ;;
    esac
    # Shift after checking all the cases to get the next option
    shift
done

charset=($(seq 0 $MAX))
permute(){
  (($1 == 0)) && { echo "$2"; return; }
  for char in "${charset[@]}"
  do
    permute "$((${1} - 1 ))" "$2 $char"
  done
}
permute "$M"
