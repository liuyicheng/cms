<?php
include_once("__core.php");
/**
 * 类名: Keepin
 **/
class Keepin {
    private $session;
    public function __construct() {
        $this->session = new Session();
    }
    public function in($ID) {
        $this->session->set("ID", $ID);
    }
    public function out() {
        $this->session->unset_("ID");
    }
    public function isIn() {
        return $this->session->isset_("ID");
    }
    public function isLoginPage() {
        return strpos($_SERVER["PHP_SELF"], "login");
    }
    public function goto_($url) {
        header($url);
        die();
    }
    public function __destruct() {
        unset($this->session);
    }
}
?>
