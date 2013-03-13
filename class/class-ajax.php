<?php
/**
 * 类名: Ajax
 **/
class Ajax {
    public function __construct() {
        ;
    }
    public static function issetPost($key) {
        return isset($_POST[$key]);
    }
    public static function getPost($key) {
        if ( Ajax::issetPost($key) ) {
            return $_POST[$key];
        } else {
            return false;
        }
    }
    public function __destruct() {
        ;
    }
}
?>
