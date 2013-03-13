<?php
include_once("__core.php");
/**
 * 类名: Connect
 **/
class Connect {
    private $mysql;
    public function __construct() {
        $this->mysql = new Mysql("localhost", "root", "123456", "cms");
    }
    public function vertifyAccount($account, $password) {
        $mysql = $this->mysql;
        $result = $mysql->query("select `user_account`, `user_password` from `cms_user` where `user_account` = '$account' limit 0, 1");
        if ( $row = $mysql->fetcharray($result) ) {
            if ( $row["user_password"] === md5($password) ) {
                return true;
            } else {
                die("密码错误");
            }
        } else {
            die("帐号不存在");
        }
    }
    public function __destruct() {
        unset($this->mysql);
    }
}
?>
