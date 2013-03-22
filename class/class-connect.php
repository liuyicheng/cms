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
    /**
     * 方法: getCodeList
     * 功能: 获取代码查询结果列表
     * 参数: $filter
     * 说明: 可以设置过滤器，默认为所有代码按时间排序结果，最多只返回30条结果
     *       TODO 过滤器部分还没做好
     */
    public function getCodeList($language, $project, $author, $keywords) {
        $mysql = $this->mysql;
        $query = "select code_ID, code_title, code_language, code_project, code_author, code_summary, code_description from cms_code ";
        if ( $language || $project || $author || $keywords ) {
            $query .= " where ";
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
     * 方法: getLanguageList
     * 功能: 获取语言列表
     * 参数: 无
     * 说明: 返回代码语言的列表
     *       TODO 目前语言没有另外建表，是查询的已有代码库中的语言，考虑是否需要给语言建表
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
     * 方法: getCodePage
     * 功能: 获取代码页面
     * 参数: $code_ID
     * 说明: 返回特定code_ID的代码页面需要的数据
     *       TODO 目前返回的信息还不完善，不包括project_title和评论
     */
    public function getCodePage($code_ID) {
        $mysql = $this->mysql;
        $result = $mysql->query("select * from cms_code where code_ID = '$code_ID'");
        return json_encode($mysql->fetcharray($result));
    }
    /**
     * 方法: addCodePage
     * 功能: 插入一个代码页面
     * 参数: 很多
     * 说明: 将数据插入cms_code表
     *       TODO 临时写的，还需修改
     */
    public function addCodePage($code_title, $code_project, $code_language, $code_summary, $code_location, $code_source, $code_description) {
        $code_source = addslashes($code_source);
        $code_description = htmlentities($code_description);
        $mysql = $this->mysql;
        //return $mysql->query("insert into cms_code (code_title, code_projectid, code_language, code_summary, code_location, code_authorid, code_source, code_description) values ('$code_title', '1', '$code_language', '$code_summary', '$code_location', '1', '$code_source', '$code_description')");
        return $mysql->query("insert into cms_code (code_title, code_projectid, code_language, code_summary, code_location, code_authorid, code_source, code_description) values ('$code_title', '1', '$code_language', '$code_summary', '$code_location', '1', '$code_source', '$code_description')");
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
