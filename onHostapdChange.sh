#!/bin/bash
__PROJECT_NAME="mlsc_hostadp"
__INC_LIB_DIR="/home/pi/bin/inc"
source  "${__INC_LIB_DIR}/header.sh"

ip=$(ip neighbor |grep "$3" | cut -d" " -f1)

if [[ $2 == "AP-STA-CONNECTED" ]]
then
	
	main.log "----------- CONNECTED ----------------"
	main.log "New device connected with ip $ip with mac $3 on $1"
	# Is this IP Already configured?

	# if already exists

	__ip_device_id=$(json.getDeviceId $ip)
	main.log "Does device exist at IP address?" $__ip_device_id

	if [[ -z $__ip_device_id ]]
	then		
		main.log "Adding new device" "$device_id $ip $3"
		json.addDevice "$ip"
	else
		main.log "device exists"
	fi
fi

if [[ $2 == "AP-STA-DISCONNECTED" ]]
then

	main.log "----------- DISCONNECTED ----------------"
	main.log "device disconnected with mac id" "$3"
    ## Lets get all the IPs

    __ip_list=(${ip[*]})    
    __ip_list+=($(ip neighbor | grep "FAILED" | cut -d" " -f1))
    __ip_list+=($(ip neighbor | grep "INCOMPLETE" | cut -d" " -f1))

    for __ip in $__ip_list
    do
        main.log "IPs in list " "$__ip"

        __device_id=$(json.getDeviceId $__ip )
        if [[ -n $__device_id ]]
        then
            main.log "Device found at " "$__device_id"
            $(json.deleteDevice "$__device_id")
        fi
    done


fi
