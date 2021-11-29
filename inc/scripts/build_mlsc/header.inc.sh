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
