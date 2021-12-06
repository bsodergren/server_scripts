<?php

require_once 'Console/CommandLine.php';

$parser = new Console_CommandLine(array(
   'description' => 'A useful description for your program.',
   'version'     => '0.0.1', // the version of your program
));

// Adding a simple option that takes no argument and that tell our program to
// turn on verbose output:
/*
  -A. --approve			Approve changes
  -v, --verbose			turns off progress bar and displays actions
  -c, --changes			Shows only changes, does not make them.
*/

$parser->addOption('verbose_level',
	array(
	'short_name'  => '-v',
	'long_name'   => '--verbose',
	'description' => 'turn on verbose output',
	'action'      => 'Counter'
	)
);


$parser->addOption('debug',
	array('short_name'  => '-d',
	'long_name'   => '--debug',
	'description' => 'Debug Mode',
	'action'      => 'StoreTrue'));

/*
-t, --title <text>	Add title to specified file (use with -f)
-g, --genre <text>	Set Genre of videos
-s, --studio <text>	Studio (Collection) name
-a, --actors <text>	Sets actor list.
*/

/*
* Import Command.
* Converts pornhub file into csv then imports to mySQL
*
*
*/
$add_cmd = $parser->addCommand('add', array(
    'description' => 'Add new devices.' ));
    $add_cmd->addOption('number',
		array(
		'short_name'  => '-n',
		'long_name'   => '--number',
		'description' => 'Number of devices to Add',
		'action'      => 'StoreInt'));


$delete_cmd = $parser->addCommand('delete', array(
    'description' => 'Delete devices' ));

	$delete_cmd->addOption('number',
		array(
		'short_name'  => '-n',
		'long_name'   => '--number',
		'description' => 'number of the device to delete. Defaults to all devices',
		'action'      => 'StoreInt'));

	$delete_cmd->addOption('verbose_level',
		array(
		'short_name'  => '-v',
		'long_name'   => '--verbose',
		'description' => 'turn on verbose output',
		'action'      => 'Counter'));

/***
* Create tables.php and tables.inc.sh files
*
*
*/
$brightness_cmd = $parser->addCommand('brightness', array(
    'description' => 'brightness of all devices' ));

	$brightness_cmd->addOption('led_brightness',
		array(
		'short_name'  => '-b',
		'long_name'   => '--brightness',
		'description' => 'turn on verbose output',
		'action'      => 'StoreInt'));


    function get_options()
    {

    	global $clioptions;

    	switch ($clioptions->command_name)
    	{
        case true:
          return $clioptions->command;
        default:
    			return $clioptions;
       }


    }


?>
