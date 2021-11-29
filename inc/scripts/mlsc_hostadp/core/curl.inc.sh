#!/bin/bash


CURL_HEADER=" -H \"Content-Type: application/json\" "
 
CURL_POST="curl -s -X POST ${CURL_HEADER}"
CURL_GET="curl -s -X GET ${CURL_HEADER}"
CURL_DELETE="curl -s -X DELETE ${CURL_HEADER}"


DEV_SYSTEM_URL="http://lights.local/api/system/devices"
DEV_SETTINGS_URL="http://lights.local/api/settings/device"
DEV_UDP_URL="http://lights.local/api/settings/device/output-type"
DEV_ACTIVE_EFFECT="http://lights.local/api/effect/active"
DEV_GET_EFFECTS="http://lights.local/api/settings/device"

function curl.getEffects()
{
    local CMD
    local device_id=$1
    local effect
    local output

    device_id=$(json.getIdfromDevice $device_id)
    device_id="device_${device_id}"

    get_effect_url=" \"${DEV_SETTINGS_URL}?device=${device_id}&setting_key=effects\"" 
    CMD="${CURL_GET} ${get_effect_url}" 
    output=$(eval $CMD)
#    output=$(echo $output | jq -r -c '.effect')

    echo $output
    
}

function curl.getTestEffect()
{

    curl_effect_url="\"http://lights.local/api/settings/effect?device=device_2&effect=effect_single\""
    curl_effect_url2="\"http://lights.local/api/settings/effect?device=device_3&effect=effect_single\""
    CMD="${CURL_GET} ${curl_effect_url}" 
    output=$(eval $CMD)
    echo $(echo $output |jq '.')
    
    CMD="${CURL_GET} ${curl_effect_url2}" 
    output=$(eval $CMD)
    echo $(echo $output |jq '.')
       

}


# curl -X POST "http://lights.local/api/settings/effect" -d "{ \"device\": \"device_2\",  \"effect\": \"effect_gradient\",  \"settings\":  {  \"gradient\": \"jamaca\"}}" -H "Content-Type: application/json"

function curl.setActiveEffect()
{
    local CMD
    local device_id=$1
    local effect="${2}"
    local output

    device_id=$(json.getIdfromDevice $device_id)
    device_id="device_${device_id}"

    active_effect="{\"device\":\"${device_id}\",  \"effect\": \"${effect}\"}"
   
    CMD="${CURL_POST} ${DEV_ACTIVE_EFFECT} -d '$active_effect' " 
    output=$(eval $CMD)
    output=$(echo $output | jq -r -c '.effect')

    echo $output
    
    
}


function curl.getActiveEffect()
{
    local CMD
    local device_id=$1
    local output
    
    device_id=$(json.getIdfromDevice $device_id)

    DEV_ACTIVE_EFFECT="${DEV_ACTIVE_EFFECT}?device=device_${device_id}"
    CMD="${CURL_GET} ${DEV_ACTIVE_EFFECT}" 
    output=$(eval $CMD)

    output=$(echo  $output | jq -r -c '.effect')
    echo $output
    
    
}

function curl.newDevice()
{
    local CMD
    local output
    local new_device_id
    
    
    CMD="${CURL_POST} ${DEV_SYSTEM_URL}" 
    output=$(eval $CMD)
    new_device_id=$(echo $output | jq -r -c '.index')
    echo $new_device_id
    
}

function curl.deleteDevice()
{

    local device_id=$1
    local CMD
    local delete_device_json
    
    
    device_id=$(json.getIdfromDevice $device_id)
    delete_device_json="{\"device\":\"device_${device_id}\"}"
    CMD="${CURL_DELETE} ${DEV_SYSTEM_URL} -d '${delete_device_json}'" 
    
    echo $(eval $CMD)

}

function curl.newDevSettings()
{
    local id=$1
    local device_name=$2    
    local led_brightness=$3
    local ip_address=$4

    id=$(json.getIdfromDevice $id)
    device_id="device_${id}"
    
    new_device="{\"device\":\"${device_id}\", \"settings\": {\"device_name\":\"${device_name}\", \"fps\":60,\"led_brightness\":\"${led_brightness}\",\"led_count\": 60,\"led_mid\": 30, \"led_strip\":\"ws2812_strip\",\"output_type\": \"output_udp\" } }"
    CMD="${CURL_POST} ${DEV_SETTINGS_URL} -d '${new_device}'" 
    output=$(eval $CMD)

    update_udp="{\"device\":\"${device_id}\", \"output_type_key\":\"output_udp\",\"settings\":{\"udp_client_ip\":\"${ip_address}\"}}"
    CMD="${CURL_POST} ${DEV_UDP_URL} -d '${update_udp}'" 
    output=$(eval $CMD)
    
    effect=$(curl.getActiveEffect "0")
    output=$(curl.setActiveEffect "${id}" "${effect}")
    
    main.log "Device $device_name added on $device_id"
    
    
}