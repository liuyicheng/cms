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
            $result = $mysql->query("select cms_code.code_ID, cms_code.code_title, cms_code.code_type, cms_code.code_summary, cms_code.code_updatetime, cms_project.project_ID, cms_project.project_title from cms_code inner join cms_project on cms_code.code_projectid=cms_project.project_ID order by cms_code.code_updatetime limit 0,10");
            echo json_encode($mysql->fetchall($result));
        }
    }
    public function __destruct() {
        unset($this->mysql);
    }
}
?>
