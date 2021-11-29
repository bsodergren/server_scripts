#!/bin/bash
set -e 

__PROJECT_NAME="Build MLSC"

__INC_LIB_DIR="/home/pi/bin/inc"
source  "${__INC_LIB_DIR}/header.sh"

__CMD_PATH="/home/pi/bin/"

__ARDUINO_DIRECTORY="/home/pi/Arduino"
__SKETCH_NAME="NodeMCU_Client"
__SKETCH_DIRECTORY="${__ARDUINO_DIRECTORY}/${__SKETCH_NAME}"



function DoUpload()
{

    local __flag=$1
    local __value=$2
    local __hostname=$3


    if [[ -n $__hostname ]] 
    then
        build_dir="${__SKETCH_DIRECTORY}/build/${__hostname}"
    else
        build_dir="${__SKETCH_DIRECTORY}/build/${__value}"
    fi 
    
    build_bin="${build_dir}/${__SKETCH_NAME}.ino.bin"

    main.log "Build Directory" $build_dir
    main.log "Project Bin file" $build_bin
    
    if [ $__flag == "hostname" ]
    then
        echo 0;
    elif [ $__flag == "ipaddress" ]
    then
        # We can upload to ip.
        local __ip_address="10.10.0.$__value"
        echo "Uploading to $__ip_address"
        
        if [ -f $build_bin ] 
        then
            run_cmd "python3 /home/pi/bin/espota.py -i $__ip_address -f $build_bin"
            
        else 
            echo "no bin file"
        fi 

    fi

}

function uploadCom()
{

    local __value=$1

    build_dir="${__SKETCH_DIRECTORY}/build/${__value}"
    build_bin="${build_dir}/${__SKETCH_NAME}.ino.bin"
    main.log "Build Directory" $build_dir
    main.log "Project Bin file" $build_bin

    run_cmd "${__CMD_PATH}arduino-cli upload -v -b esp8266:esp8266:nodemcuv2 -p /dev/ttyUSB0 -i \"$build_bin\""
}

function compileScript()
{
    local __flag=$1
    local __value=$2

    build_dir="${__SKETCH_DIRECTORY}/build/${__value}"
    build_bin="${build_dir}/${__SKETCH_NAME}.ino.bin"
    main.log "Build Directory" $build_dir
    main.log "Project Bin file" $build_bin

    [[ -n $__UPDATE ]] && build_bin="na"

	main.log "Compiling for build_bin $__UPDATE" $build_bin 

    if [ $__flag == "hostname" ]
    then
        if [ ! -f "$build_bin" ]
        then
        
            main.log "Compiling for hostname" $__value
            echo "Compiling for hostname $__value"
            run_cmd "${__CMD_PATH}arduino-cli compile -e -b esp8266:esp8266:nodemcuv2 --output-dir \"$build_dir\""

        fi

    elif [ $__flag == "ipaddress" ]
    then
      if [ ! -f "$build_bin" ]
        then
            main.log "Compiling for IP address" $__value
            echo "Compiling for 10.10.0.$__value"
            run_cmd "${__CMD_PATH}arduino-cli compile -e --build-property \"build.extra_flags=\\\"-DMLSC_CLIENT_IP=$__value\\\"\" -b esp8266:esp8266:nodemcuv2 --output-dir \"build/$__value\""
        fi
    fi 
    
    main.log "Finished compiling"
    
 }


if [[ -n $__NEWDEVICE ]] 
then
    __HOSTNAME="MLSC Box"
fi

pushd $__SKETCH_DIRECTORY;


[[ -n $__HOSTNAME ]] && __HOSTNAME=${__HOSTNAME// /-}

main.log "Hostname and IpList" "$__HOSTNAME , $__IPLIST"

if [[ -n $__HOSTNAME && -z $__IPLIST ]]
then

    main.log "Setting Hostname $__HOSTNAME , no IP or upload. Use COM port eventually"
    if [ -n $__COMPILE ]
    then
          main.log "Running script compiler"

        compileScript "hostname" $__HOSTNAME
    fi
    
    if [[ -n $__UPLOAD || -n $__NEWDEVICE ]]
    then
            main.log "Setting Hostname $__HOSTNAME and attempt com port"

        uploadCom $__HOSTNAME
    fi
    
elif [[ -n $__HOSTNAME && -n $__IPLIST ]]
then

    main.log "Setting Hostname $__HOSTNAME , Upload to IP $__IPLIST"

    __HOSTNAME=${__HOSTNAME// /-}

    if [ -n $__COMPILE ]
    then
        compileScript "hostname" $__HOSTNAME
    fi

    if [[ -n $__UPLOAD || -n $__NEWDEVICE  ]]
    then
        DoUpload "ipaddress" $__IPLIST $__HOSTNAME
    fi

elif [[ -z $__HOSTNAME && -n $__IPLIST ]]
then

main.log "Setting  Upload to IP $__IPLIST" "$__COMPILE"

    if [[ "${__IPLIST}" =~ "," ]]
    then
        mapfile  -t -d, -c1 __iplist_array <<< "${__IPLIST}"
    else
        __iplist_array=("$__IPLIST")
    fi

    for __IP_ADDR in ${__iplist_array[@]}
    do
        if [ -n $__COMPILE ]
        then
            compileScript "ipaddress" $__IP_ADDR
        fi
        
        if [[ -n $__UPLOAD || -n $__NEWDEVICE ]]
        then
            DoUpload "ipaddress" $__IP_ADDR
        fi
    done
fi

[[ "$?" != 0 ]] && popd;

popd
