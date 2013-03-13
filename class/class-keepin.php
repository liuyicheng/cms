<?php
/**
 * 类名: Keepin
 **/
class Keepin {
    public function __construct() {
        ;
    }
    public static function start() {
        session_start();
    }
    public static function in($userID) {
        $_SESSION["user_ID"] = $userID;
    }
    public static function out() {
        unset($_SESSION["user_ID"]);
    }
    public static function isIn() {
        return isset($_SESSION["user_ID"]);
    }
    public static function isSignPage() {
        return strpos($_SERVER["PHP_SELF"], "sign");
    }
    public static function goto_($url) {
        header("Location: " . $url);
    }
    public static function end() {
        session_destroy();
    }
    public function __destruct() {
        ;
    }
}
?>
