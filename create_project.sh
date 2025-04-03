#!/bin/bash
set -e
__INC_LIB_DIR="/home/pi/bin/inc"
source "${__INC_LIB_DIR}/header.sh"

function print_usage() {
	__genre_list_str=$(printf ",%s" "${__GENRE_LIST[@]}")
	__genre_list_str=${__genre_list_str:1}

	__usage="
Usage: $(basename "$0") [OPTIONS]

Options:
   -n,  --new       Add new device with random hostname
   -g,  --github    use github
   -?,  --help      print help
"
	echo "$__usage"

}

for arg in "$@"; do
	shift
	case "$arg" in
	"--new") set -- "$@" "-n" ;;
	"--github") set -- "$@" "-g" ;;
	*) set -- "$@" "$arg" ;;
	esac
done

# Parse short options
OPTIND=1

while getopts "n:g" opt; do

	case "$opt" in
	"g") __GITHUB=1 ;;
	"n") __NEW_PROJECT=$OPTARG ;;

	*)
		print_usage >&2
		exit 1
		;;
	esac
done
shift $((OPTIND - 1))

shopt -s nocasematch

### Create Project.
# create_project -n "Project Name" [options]
# Add include directory for custom commands.
# Add data directory for non script includes such as json and text files
#
#
__NEW_PROJECT_NAME="$__NEW_PROJECT"

## Comes from the command line input.

__NEW_PROJECT_DIRNAME=${__NEW_PROJECT_NAME// /_}
__NEW_PROJECT_DIRNAME=${__NEW_PROJECT_DIRNAME,,}

## make directory & core directory
__NEW_PROJECT_HOME="/home/pi/scripts/${__NEW_PROJECT_DIRNAME}"
__NEW_PROJECT_INC_DIR="${__NEW_PROJECT_HOME}/inc"
__NEW_PROJECT_INC_CORE="${__NEW_PROJECT_INC_DIR}/core"

#make header
__NEW_PROJECT_OPT="${__NEW_PROJECT_INC_DIR}/getopts.sh"
__NEW_PROJECT_HEADER="${__NEW_PROJECT_INC_DIR}/header.inc.sh"

mkdir -p ${__NEW_PROJECT_INC_CORE}

cat <<'EOF' >${__NEW_PROJECT_HEADER}
source  "${__PROJECT_INC_DIR}/getopts.sh"
__PROJECT_INC_CORE="${__PROJECT_INC_DIR}/core"

OLDIFS=$IFS
IFS=$'\n'
mapfile -t __project_inc_core_array < <(find "${__PROJECT_INC_CORE}" -type f -name "*.inc.sh")

sLen=${#__project_inc_core_array[@]}
for ((i = 0; i < sLen; i++))
do
	source "${__project_inc_core_array[$i]}"
done
EOF

cat <<'EOF' >${__NEW_PROJECT_OPT}
function print_usage()
{
	
	__usage="
Usage: $(basename "$0") [OPTIONS]

Options:
   -o,  --overwrite Compile new souce
   -?,  --help      print help
"
	echo "$__usage"

}

for arg in "$@"
do
	shift
	case "$arg" in
        "--overwrite") set -- "$@" "-n" ;;
		*) set -- "$@" "$arg" ;;
	esac
done

# Parse short options
OPTIND=1

while getopts "n" opt; do

	case "$opt" in
    "n") __NEWDEVICE=1 ;;
		
		*)	print_usage >&2
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

shopt -s nocasematch
EOF

cat <<EOF >"${__NEW_PROJECT_HOME}/${__NEW_PROJECT_DIRNAME}.sh"
#!/bin/bash
set -e 
__PROJECT_NAME="${__NEW_PROJECT_NAME}"
__PROJECT_HOME="${__NEW_PROJECT_HOME}"

__INC_LIB_DIR="/home/pi/bin/inc"
source  "${__INC_LIB_DIR}/header.sh"

print_usage
EOF

touch "${__NEW_PROJECT_INC_CORE}/main.inc.sh"
chmod +x "${__NEW_PROJECT_HOME}/${__NEW_PROJECT_DIRNAME}.sh"

if [[ -n "${__GITHUB}" ]]; then
	pushd ${__NEW_PROJECT_HOME}

	hub init -g
	hub create -p
	echo $?

	git add .
	git commit -m "first"
	git push --set-upstream origin master
fi
