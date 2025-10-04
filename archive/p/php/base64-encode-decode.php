<?php
function usage()
{
    exit("Usage: please provide a mode and a string to encode/decode");
}

// Cannot use the library function directly because it doesn't check if the
// length of the input string is a multiple of 4. The value of false is
// returned if the input string is invalid. Otherwise, the Base64 decoded
// string is returned
function base64_validate_and_decode($str)
{
    // Use the library function if length of input string is a multiple of 4.
    // Otherwise, just return false
    $result = false;
    if (strlen($str) % 4 == 0) {
        $result = base64_decode($str, true);
    }

    return $result;
}

// Exit if arguments are invalid
if (count($argv) < 3 || strlen($argv[2]) < 1)
{
    usage();
}

$mode = $argv[1];
$str = $argv[2];
switch ($mode) {
    case "encode":
        $result = base64_encode($str);
        break;

    case "decode":
        $result = base64_validate_and_decode($str);
        if ($result === false) {
            usage();
        }
        break;

    default:
        usage();
}

echo $result;
