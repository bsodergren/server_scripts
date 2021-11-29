unset __UPLOAD 
unset __HOSTNAME
unset __IPLIST
unset __COMPILE
unset __NEWDEVICE
unset __UPDATE

function print_usage()
{
	__genre_list_str=$(printf ",%s" "${__GENRE_LIST[@]}")
	__genre_list_str=${__genre_list_str:1}


	__usage="
Usage: $(basename "$0") [OPTIONS]

Options:
   -i,  --ip        IP Address (last segment, comma seperated)
   -h,  --hostname  Hostname
   -n,  --new       Add new device with random hostname
   -u,  --upload    upload vi over the air update
   -c,  --compile   compile binaries
   -o,  --overwrite Compile new souce
   -?,  --help      print help
"
	echo "$__usage"

}

for arg in "$@"
do
	shift
	case "$arg" in
		"--ip") set -- "$@" "-i" ;;
        "--overwrite") set -- "$@" "-o" ;;
		"--upload") set -- "$@" "-u" ;;
		"--compile") set -- "$@" "-c" ;;
		"--hostname") set -- "$@" "-h" ;;
		"--new") set -- "$@" "-n" ;;
		*) set -- "$@" "$arg" ;;
	esac
done

# Parse short options
OPTIND=1

while getopts "o:h:uci:n" opt; do

	case "$opt" in
    "u") __UPLOAD=1;;
    "o") __UPDATE=1;;
    "c") __COMPILE=1;;
    "h") __HOSTNAME=$OPTARG ;;
    "i") __IPLIST=$OPTARG ;;
    "n") __NEWDEVICE=1 ;;
		
		*)	print_usage >&2
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

shopt -s nocasematch

