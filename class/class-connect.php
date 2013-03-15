<?php
include_once("class-mysql.php");
/**
 * 类名: Connect
 **/
class Connect {
    private $mysql;
    public function __construct() {
        $this->mysql = new Mysql("localhost", "root", "123456", "cms");
    }
    public function vertifyAccount($account, $password) {
        if ( !$account ) {
            return json_encode(array("account" => "请输入帐号"));
        } elseif ( !$password ) {
            return json_encode(array("password" => "请输入密码"));
        } else {
            $mysql = $this->mysql;
            $result = $mysql->query("select user_ID, user_account, user_password from cms_user where user_account = '$account' limit 0, 1");
            if ( $row = $mysql->fetcharray($result) ) {
                if ( $row["user_password"] === md5($password) ) {
                    return $row["user_ID"];
                } else {
                    return json_encode(array("password" => "密码错误"));
                }
            } else {
                return json_encode(array("account" => "帐号不存在"));
            }
        }
    }
    public function getCodeList($filter) {
        if ( $filter === "default" ) {
            $mysql = $this->mysql;
            $result = $mysql->query("select code_ID, code_title, code_language from cms_code order by code_updatetime desc limit 0,20");
            return json_encode($mysql->fetchall($result));
        }
    }
    public function getUserList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select user_ID, user_nickname from cms_user");
        return json_encode($mysql->fetchall($result));
    }
    public function getLanguageList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select count(*) as num, code_language from cms_code group by code_language");
        return json_encode($mysql->fetchall($result));
    }
    public function getProjectList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select project_ID, project_title from cms_project");
        return json_encode($mysql->fetchall($result));
    }
    public function getCodePage($code_ID) {
        $mysql = $this->mysql;
        $result = $mysql->query("select * from cms_code where code_ID = '$code_ID'");
        return json_encode($mysql->fetcharray($result));
    }
    public function __destruct() {
        unset($this->mysql);
    }
}
?>
