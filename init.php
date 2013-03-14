<?php
include_once("class/class-keepin.php");
include_once("class/class-printt.php");
Keepin::start();
if ( Keepin::isSignPage() && Keepin::isIn() ) {
    Keepin::goto_("index.php");
} elseif ( !Keepin::isSignPage() && !Keepin::isIn() ) {
    Keepin::goto_("sign.php");
}
?>
