


function json.getIdfromDevice()
{
	local __device_id=$1
	__id=$(echo $__device_id | cut -f2 -d_)
	echo -e $__id
}

function json.deleteDevice()
{
	local __device_name=$1
    
    __id=$(json.getIdfromDevice $__device_name)
    
    if (( __id > 4 ))
    then
        main.log "deleting id" $__device_name
        __output=$(curl.deleteDevice $__id)
        
    else 
        main.log "not deleting id" $__device_name
    fi
}

function json.addDevice()
{
	local ipaddress=$1
    
	local device_name
    local device_id
	
	device_id=$(curl.newDevice)
    device_name_id=$((device_id - 4));
	device_name="Remote Box ${device_name_id}"
    
	## is there a hostname set?
#	__hostname=$(dig  +short -x $__ipaddress)
#	if [[ -z $__hostname ]]
#	then
#		device_id=$(json.getIdfromDevice $__device_id)
#		device_name="Remote Box ${device_id}"
#	else
#		__device_name=$(echo $__hostname|sed -r 's/\.$//')
#	fi
	
    
	effect_list=$(jq -r -c .device_configs.device_0.effects $__config_file)
	led_brightness=$(jq -r -c .device_configs.device_0.led_brightness $__config_file)

	main.log "Device ID"  " ${device_id}"
	main.log "Device Name "  "${device_name}"
    main.log "led_brightness "  "${led_brightness}"
    main.log "IP Address "  "${ipaddress}"
    
    out=$(curl.newDevSettings "$device_id" "$device_name" $led_brightness "$ipaddress")
   	echo $out
}



function json.getDeviceId()
{
	local __address=$1
	local __addr
	local __device_id
	local __device_list

	unset is_mac

	main.log "Device Address: " "$__address"

	__device_list=$(jq -r '.device_configs| keys[]'  $__config_file)

	for __device_id in $__device_list
	do
		__addr=$(jq -r --arg DEVICE_PATH "$__device_id" '.device_configs[$DEVICE_PATH].output.output_udp.udp_client_ip' $__config_file)

		if [[ "$__addr" == *"$__address"* ]]
		then
			main.log "Found device at"  "$__device_id"
			echo "${__device_id}"
			break
		fi
	done
}

