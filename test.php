#!/usr/bin/php
<?


$DEV_SYSTEM_URL="http://lights.local/api/system/devices";
$DEV_SETTINGS_URL="http://lights.local/api/settings/device";

$DEV_UDP_URL="http://lights.local/api/settings/device/output-type";

$DEV_ACTIVE_EFFECT="http://lights.local/api/effect/active";


function callAPI($method, $url, $data){
   $curl = curl_init();

   switch ($method){
      case "POST":
         curl_setopt($curl, CURLOPT_POST, 1);
         if ($data)
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);
         break;
      case "PUT":
         curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "PUT");
         if ($data)
            curl_setopt($curl, CURLOPT_POSTFIELDS, $data);			 					
         break;
      default:
         if ($data)
            $url = sprintf("%s?%s", $url, http_build_query($data));
   }
   // OPTIONS:
   
   curl_setopt($curl, CURLOPT_URL, $url);
   curl_setopt($curl, CURLOPT_HTTPHEADER, array(
        'Accept: application/json',
      'Content-Type: application/json'
   ));
   curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
   curl_setopt($curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
   // EXECUTE:
   $result = curl_exec($curl);
   if(!$result){die("Connection Failure");}
   curl_close($curl);
   return $result;
}

/*
$device_id="device_0";
$get_data = callAPI('GET', $DEV_SETTINGS_URL."?device=".$device_id."&setting_key=effects", false);
$response = json_decode($get_data, true);

var_dump($response["setting_value"]["last_effect"]);
*/

#$get_data = callAPI('POST', $DEV_SYSTEM_URL, " ");
#$response = json_decode($get_data, true);

#var_dump($response["index"]);

$data_array =  array(

  "device" => "device_7",
  "settings" => array(
    "device_name"=> "New Name",
    "fps" => 60,
    "led_brightness" => 25,
    "led_count" => 60,
    "led_mid" => 30,
    "led_strip" => "ws2812_strip",
    "output_type" => "output_udp"
  ), );

$upd_array =  array(

  "device" => "device_7",
  "output_type_key" => "output_udp",
  "settings" => array(
    "udp_client_ip" => "10.10.0.99"
    )
  );
$get_data = callAPI('POST', $DEV_SETTINGS_URL, json_encode($data_array));
$response = json_decode($get_data, true);

var_dump($response);

$get_data = callAPI('POST', $DEV_UDP_URL, json_encode($upd_array));
$response = json_decode($get_data, true);

var_dump($response);

?>

