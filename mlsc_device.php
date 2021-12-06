#!/usr/bin/php
<?
DEFINE("__HOME__",$_SERVER["HOME"]);
DEFINE("__PWD__",$_SERVER["PWD"]);

DEFINE("__PHP_BIN__", __HOME__ . "/bin");
DEFINE("__SCRIPT_LOCATION__",__PHP_BIN__);
DEFINE("__PHP_INCLUDE_DIR__", __SCRIPT_LOCATION__."/inc/php");

require_once(__PHP_INCLUDE_DIR__."/header.inc.php");
$options_arg = get_options();

switch ($clioptions->command_name)
{
	case 'delete':
    exit(0);

  case 'add':
    exit(0);

  case 'configure':
    exit(0);

  case 'brightness':
    // Set brightness of all devices to -n
    $led_brightness = $options_arg->options["led_brightness"];
    setDeviceBrightness($led_brightness);

      exit(0);

  default:
    $devices = getAllDeviceIds();

    print_r($devices) . "\n";

    exit(0);
}

?>
