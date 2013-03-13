<?php
include_once("class/class-keepin.php");
include_once("class/class-printt.php");
Keepin::start();
if ( Keepin::isSignPage() && Keepin::isIn() ) {
    Keepin::goto_("index");
} elseif ( !Keepin::isSignPage() && !Keepin::isIn() ) {
    Keepin::goto_("sign");
}
?>
