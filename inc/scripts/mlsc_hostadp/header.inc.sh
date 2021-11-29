
__PROJECT_OPTS="${__PROJECT_INC_DIR}/getopts.sh"
[[ -f $__PROJECT_OPTS ]] && source "$__PROJECT_OPTS"

__PROJECT_INC_CORE="${__PROJECT_INC_DIR}/core"

mapfile -t __project_inc_core_array < <(find "${__PROJECT_INC_CORE}" -type f -name "*.inc.sh")

sLen=${#__project_inc_core_array[@]}
for ((i = 0; i < sLen; i++))
do
	source "${__project_inc_core_array[$i]}"
done

__config_file="/share/.mlsc/config.json"
