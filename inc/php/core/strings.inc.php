<?php


function output($string, $color="red")
{
	global $colors;
	echo $colors->getColoredString($string, $color) . "\n";
}

function verbose_output($text='', $level=1)
{
	global $colors;
	global $clioptions;
	
	if ( $level == 1 ) { $color="light_cyan"; }
	if ( $level == 2 ) { $color="light_green"; }
	if ( $level == 3 ) { $color="light_red"; }
	if ( $level == 4 ) { $color="red"; }
	
	$options_object = get_options();

	if ( $options_object->options["verbose_level"] >= $level )
	{
		echo $colors->getColoredString("[".$level."]:","yellow") .
			 $colors->getColoredString($text, $color) . "\n";
	}
	
}

function translate($string="")
{
	
	// "trans -b -no-warn -no-autocorrect " 
	return $string;
}

function escape($value) {
    $return = '';
    for($i = 0; $i < strlen($value); ++$i) {
        $char = $value[$i];
        $ord = ord($char);
        if($char !== "'" && $char !== "\"" && $char !== '\\' && $ord >= 32 && $ord <= 126)
            $return .= $char;
        else
            $return .= '\\x' . dechex($ord);
    }
    return $return;
}

function escape_string($value)
{
	if (__USE_MSYQL__ == true )
	{
		return mysqli_real_escape_string($value);
	} else {
		return escape($value);
	}
	
}





?>