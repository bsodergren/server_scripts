<?php

DEFINE("__PHP_INC_CORE_DIR__", 	__PHP_INCLUDE_DIR__."/core");
DEFINE("__SCRIPT_NAME__", basename($_SERVER['PHP_SELF']) );


set_error_handler('exceptions_error_handler');

function exceptions_error_handler($severity, $message, $filename, $lineno) {
  if (error_reporting() == 0) {
    return;
  }
  if (error_reporting() & $severity) {
    throw new ErrorException($message, 0, $severity, $filename, $lineno);
  }
}


$all = opendir(__PHP_INC_CORE_DIR__);
while ($file = readdir($all)) {
	if (!is_dir(__PHP_INC_CORE_DIR__.'/'.$file) ) {
		if (preg_match("/\.(php)$/",$file)) {
			require_once(__PHP_INC_CORE_DIR__.'/'.$file);
		}
	}
}

$colors = new Colors();

try {
   $clioptions = $parser->parse();
   } catch (Exception $exc) {
   $parser->displayError($exc->getMessage());
}


