<?php
include_once("class-mysql.php");
/**
 * 类名: Connect
 * 功能: 处理特定的mysql请求
 * 属性: $mysql
 * 方法: vertifyAccount, getCodeList, getUserList, getLanguageList, getProjectList, getCodePage
 * 说明: 需要include Mysql类，所有数据库增删查改都在这个类中
 */
class Connect {
    private $mysql;     // Mysql类的实例
    /**
     * 方法: __construct
     * 功能: 构造函数
     * 参数: 无
     * 说明: 实例化一个Mysql对象
     */
    public function __construct() {
        $this->mysql = new Mysql("localhost", "root", "123456", "cms");
    }
    /**
     * 方法: vertifyAccount
     * 功能: 验证帐号
     * 参数: $account, $password
     * 说明: 通过输入的帐号密码查询数据库验证，成功时返回user_ID，失败时返回json格式的失败信息
     */
    public function vertifyAccount($account, $password) {
        if ( !$account ) {
            return json_encode(array("account" => "请输入帐号"));
        } else if ( !$password ) {
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
    public function signUp($account, $password, $nickname, $email, $phonenum) {
        if ( !$account ) {
            return json_encode(array("account" => "请输入帐号"));
        } else if ( !$password ) {
            return json_encode(array("password" => "请输入密码"));
        } else if ( !$nickname ) {
            return json_encode(array("nickname" => "请输入昵称"));
        } else if ( !$email) {
            return json_encode(array("email" => "请输入邮箱"));
        } else if ( !$phonenum) {
            return json_encode(array("phonenum" => "请输入电话"));
        } else {
            $mysql = $this->mysql;
            $password = md5($password);
            $result = $mysql->query("select user_account from cms_user where user_account = '$account'");
            if ( $mysql->fetcharray($result) ) {
                return json_encode(array("account" => "帐号已存在"));
            } else {
                $result = $mysql->query("insert into cms_user (user_account, user_password, user_nickname, user_email, user_phonenum) values ('$account', '$password', '$nickname', '$email', '$phonenum')");
                return 'success';
            }
        }
    }
    /**
     * 方法: getCodeList
     * 功能: 获取代码查询结果列表
     * 参数: $filter
     * 说明: 可以设置过滤器，默认为所有代码按时间排序结果，最多只返回30条结果
     *       TODO 过滤器部分还没做好
     */
    public function getCodeList($label, $language, $project, $author, $keywords) {
        $mysql = $this->mysql;
        $query = "select code_ID, code_title, code_language, code_project, code_author, code_updatetime, code_summary, code_description ";
        if ( $label ) {
            $query .= " , label_codeid, label_content from cms_code inner join cms_label on code_ID=label_codeid where label_content = '" . $label . "' ";
        } else {
            $query .= " from cms_code ";
        }
        if ( $language || $project || $author || $keywords ) {
            if ( !$label ) {
                $query .= " where ";
            } else {
                $query .= " and ";
            }
            if ( $language ) {
                $query .= " code_language = '" . $language . "' ";
            }
            if ( $project ) {
                if ( $language ) {
                    $query .= " and ";
                }
                $query .= " code_project = '" . $project . "' ";
            }
            if ( $author ) {
                if ( $language || $project ) {
                    $query .= " and ";
                }
                $query .= " code_author = '" . $author . "' ";
            }
            if ( $keywords ) {
                if ( $language || $project || $author ) {
                    $query .= " and ";
                }
                $query .= " ( code_title like '%" . $keywords . "%' or code_summary like '%" . $keywords . "%' or code_description like '%" . $keywords . "%' ) ";
            }
        }
        $query .= " order by code_updatetime desc limit 0, 10";
        $result = $mysql->query($query);
        $codeList = $mysql->fetchall($result);
        for ($i = 0; $i < count($codeList); $i++) {
            $codeList[$i]["label_list"] = self::getCodeLabel($codeList[$i]["code_ID"]);
        }
        return json_encode($codeList);
    }
    /**
     * getLabelList
     */
    public function getLabelList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select label_content from cms_label group by label_content");
        return json_encode($mysql->fetchall($result));
    }
    /**
     * 方法: getLanguageList
     * 功能: 获取语言列表
     * 参数: 无
     * 说明: 返回代码语言的列表
     */
    public function getLanguageList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select code_language from cms_code group by code_language");
        return json_encode($mysql->fetchall($result));
    }
    /**
     * 方法: getProjectList
     * 功能: 获取项目列表
     * 参数: 无
     * 说明: 返回项目列表
     */
    public function getProjectList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select code_project from cms_code group by code_project");
        return json_encode($mysql->fetchall($result));
    }
    /**
     * 方法: getUserList
     * 功能: 获取用户列表
     * 参数: 无
     * 说明: 返回所有用户的user_nickname
     */
    public function getUserList() {
        $mysql = $this->mysql;
        $result = $mysql->query("select code_author from cms_code group by code_author");
        return json_encode($mysql->fetchall($result));
    }
    /**
     * 方法: getCodePage
     * 功能: 获取代码页面
     * 参数: $code_ID
     * 说明: 返回特定code_ID的代码页面需要的数据
     *       TODO 目前返回的信息还不完善，不包括评论
     */
    public function getCodePage($code_ID) {
        $mysql = $this->mysql;
        $result = $mysql->query("select * from cms_code where code_ID = '$code_ID'");
        return json_encode($mysql->fetcharray($result));
    }
    /**
     * getCodeLabel
     */
    public function getCodeLabel($code_ID) {
        $mysql = $this->mysql;
        $result = $mysql->query("select label_codeid, label_content from cms_label where label_codeid = '$code_ID'");
        return $mysql->fetchall($result);
    }
    /**
     * 方法: addCodePage
     * 功能: 插入一个代码页面
     * 参数: 很多
     * 说明: 将数据插入cms_code表
     *       TODO 临时写的，还需修改
     */
    public function addCodePage($code_title, $code_project, $code_language, $code_label, $code_summary, $code_location, $code_source, $code_description) {
        $mysql = $this->mysql;
        $code_source = addslashes($code_source);
        $code_updatetime = date("Y-m-d H:i:s",time());
        session_start();
        $user_ID = $_SESSION["user_ID"];
        $user_nickname = $mysql->fetcharray($mysql->query("select user_nickname from cms_user where user_ID='$user_ID'"));
        $user_nickname = $user_nickname["user_nickname"];
        $mysql->query("insert into cms_code (code_title, code_project, code_language, code_summary, code_location, code_updatetime, code_author, code_source, code_description) values ('$code_title', '$code_project', '$code_language', '$code_summary', '$code_location', '$code_updatetime', '$user_nickname', '$code_source', '$code_description')");
        $insertid = $mysql->insertid();
        $label_list = explode(" ", $code_label);
        for ( $i = 0; $i < count($label_list); $i++ ) {
            $mysql->query("insert into cms_label (label_codeid, label_content) values ('$insertid', '$label_list[$i]')");
        }
        return "success";
    }
    /**
     * 方法: __destruct
     * 功能: 析构函数
     * 参数: 无
     * 说明: 释放$mysql实例
     */
    public function __destruct() {
        unset($this->mysql);
    }
}
?>
