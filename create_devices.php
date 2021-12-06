#!/usr/bin/php
<?
DEFINE("__HOME__",$_SERVER["HOME"]);
DEFINE("__PWD__",$_SERVER["PWD"]);

DEFINE("__PHP_BIN__", __HOME__ . "/bin");
DEFINE("__SCRIPT_LOCATION__",__PHP_BIN__);
DEFINE("__PHP_INCLUDE_DIR__", __SCRIPT_LOCATION__."/inc/php");

require_once(__PHP_INCLUDE_DIR__."/header.inc.php");



/*
$device_id="device_0";
$get_data = callAPI('GET', $DEV_SETTINGS_URL."?device=".$device_id."&setting_key=effects", false);
$response = json_decode($get_data, true);

var_dump($response["setting_value"]["last_effect"]);
*/

#$get_data = callAPI('POST', $DEV_SYSTEM_URL, " ");
#$response = json_decode($get_data, true);

#var_dump($response["index"]);

$default_devices = array(
    "0" => array(
        "DEVICE_NAME" => "Closet",
        "DEVICE_IP" => "10.10.0.11"
    ),
    "1" => array(
        "DEVICE_NAME" => "Left-Center",
        "DEVICE_IP" => "10.10.0.14"
    ),
    "2" => array(
        "DEVICE_NAME" => "Center",
        "DEVICE_IP" => "10.10.0.12"
    ),
    "3" => array(
        "DEVICE_NAME" => "Right-Center",
        "DEVICE_IP" => "10.10.0.15"
    ),
    "4" => array(
        "DEVICE_NAME" => "Wall",
        "DEVICE_IP" => "10.10.0.13"
    ),
);



$device_settings =  array(
  "device" => "%%DEVICE_ID%%",
  "settings" => array(
    "device_name"=> "%%DEVICE_NAME%%",
    "fps" => 60,
    "led_brightness" => 25,
    "led_count" => 120,
    "led_mid" => 60,
    "led_strip" => "ws2812_strip",
    "output_type" => "output_udp"
  )
);


$udp_settings =  array(
  "device" =>  "%%DEVICE_ID%%",
  "output_type_key" => "output_udp",
  "settings" => array(
    "udp_client_ip" =>  "%%DEVICE_IP%%",
    )
  );



$device_json=json_encode($device_settings);
$udp_json=json_encode($udp_settings);

// delete all devices
$get_data = callAPI('GET', DEV_SYSTEM_URL, "");
$response = json_decode($get_data, true);


if ($response == true ) {
foreach ($response as $dev_key => $dev_value)
{

    $device_array = array ("device" => $dev_value["id"] );

    #echo json_encode($device_array). "\n";

    $get_data = callAPI('DELETE', DEV_SYSTEM_URL, json_encode($device_array));
    $response = json_decode($get_data, true);
    print_r($response). "\n";

}
}


foreach($default_devices as $key => $device_id )
{

    $get_data = callAPI('POST', DEV_SYSTEM_URL, " ");
    $response = json_decode($get_data, true);
    $device_key=$response["index"];



    $tmp_device_json = array();
    $tmp_udp_json = array();

    $tmp_device_json = str_replace("%%DEVICE_ID%%","device_".$device_key,$device_json);
    $tmp_udp_json = str_replace("%%DEVICE_ID%%","device_".$device_key,$udp_json);

    foreach ($device_id as $key_name => $key_value )
    {
        $tmp_device_json = str_replace("%%".$key_name."%%",$key_value,$tmp_device_json);
        $tmp_udp_json = str_replace("%%".$key_name."%%",$key_value,$tmp_udp_json);


    }

   # $new_device_array[] = $tmp_device_json;
   # $new_udp_array[] = $tmp_udp_json;
   echo $tmp_device_json;

    $get_data1 = callAPI('POST', DEV_SETTINGS_URL, $tmp_device_json);
    $get_data2 = callAPI('POST', DEV_UDP_URL, $tmp_udp_json);
    $response1 = json_decode($get_data1, true);
    $response2 = json_decode($get_data2, true);

    print_r($response1) ."\n";
    print_r($response2) ."\n";

}



?>
