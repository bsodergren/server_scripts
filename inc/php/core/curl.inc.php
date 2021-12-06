<?php

// Returns array of device_id
function getAllDevices()
{

  $get_data = callAPI('GET', DEV_SYSTEM_URL, "");
  $response = json_decode($get_data, true);

  return $response;
}


// returns list of device ID's only.
// Takes the result from getAllDevices
function getAllDeviceIds()
{

  $device_array=array();
  $result_array=getAllDevices();
  foreach ($result_array as $dev_key => $dev_value)
  {
    $device_array[]=$dev_value["id"];
  }

  return $device_array;
}

function setDeviceBrightness($brightness)
{
  $device_settings =  array(
    "device" => "%%DEVICE_ID%%",
    "settings" => array(
      "led_brightness" => "%%BRIGHTNESS%%" ));

      $device_json=json_encode($device_settings);

      $devices = getAllDeviceIds();
      unset($tmp_device_json);

      foreach ( $devices as $device_id )
      {
        $tmp_device_json = str_replace("%%DEVICE_ID%%",$device_id, $device_json);
        $tmp_device_json = str_replace("%%BRIGHTNESS%%",$brightness,$tmp_device_json);


        $get_data1 = callAPI('POST', DEV_SETTINGS_URL, $tmp_device_json);
        $response1 = json_decode($get_data1, true);

        print_r($response1) . "\n";

      }


}


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

       case "DELETE":
         curl_setopt($curl, CURLOPT_CUSTOMREQUEST, "DELETE");
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
