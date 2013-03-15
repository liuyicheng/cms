<?php
/**
 * 初始化php，检测是否登录，每个页面都得include
 */
include_once("class/class-keepin.php");
include_once("class/class-printt.php");
Keepin::start();
if ( Keepin::isSignPage() && Keepin::isIn() ) {
    Keepin::goto_("index.php");
    // 如果在登录页面，并且已经登录，那么跳转到index
} else if ( !Keepin::isSignPage() && !Keepin::isIn() ) {
    Keepin::goto_("sign.php");
    // 如果不再登录页面，并且还没有登录，那么跳转到登录页面
}
// 其他情况下啥都不做
?>
