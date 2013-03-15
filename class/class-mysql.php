<?php
/**
 * 类名: Mysql
 * 功能: 数据库语句封装
 * 属性: $server, $user, $password, $database, $charset, $link
 * 方法: connet, query, fetcharray, fetchall, numrows, numfields, affectedrows, version, insertid, close, error
 * 说明: 数据库连接，查询等操作
 */
class Mysql {
    private $server;    // 服务器名
    private $user;      // 数据库用户名
    private $password;  // 数据库密码
    private $database;  // 数据库名
    private $charset;   // 数据库编码,默认为utf8
    private $link;      // mysql连接标识符
    /**
     * 方法: __construct
     * 功能: 构造函数
     * 参数: $server, $user, $password, $database, $charset
     * 说明: 实例化时自动连接数据库
     */
    public function __construct($server, $user, $password, $database, $charset = 'utf8') {
        $this->server = $server;
        $this->user = $user;
        $this->password = $password;
        $this->database = $database;
        $this->charset = $charset;
        $this->connect();
    }
    /**
     * 方法: connect
     * 功能: 连接数据库
     * 参数: 无
     * 说明: 连接mysql服务器,连接数据库,设置字符编码
     */
    private function connect() {
        $this->link = mysql_connect($this->server, $this->user, $this->password) or die($this->error("数据库服务器连接出错!"));
        mysql_select_db($this->database, $this->link) or die($this->error("数据库连接出错!"));
        mysql_query("set names '$this->charset'");
    }
    /**
     * 方法: query
     * 功能: 执行sql
     * 参数: $sql
     * 说明: 对传过来的sql语句执行,并返回结果$result资源标识符
     */
    public function query($sql) {
        $result = mysql_query($sql, $this->link);
        if ( !$result ) {
            $this->error($sql . "语句执行失败!");
            return false;
        } else {
            return $result;
        }
    }
    /**
     * 方法: fetcharray
     * 功能: 从结果集中取一行做为数组
     * 参数: $result资源标识符
     * 说明: 需要提供sql语句执行返回的资源标识符
     */
    public function fetcharray($result) {
        return mysql_fetch_array($result);
    }
    /**
     * 方法: fetchall
     * 功能: 从结果集中取出所有记录做为二维数组$arr
     * 参数: $result资源标识符
     * 说明: 循环取所有记录保存为$arr
     */
    public function fetchall($result) {
        $arr = array ();
        while ( $row = mysql_fetch_array($result) ) {
            $arr[] = $row;
        }
        mysql_free_result($result);
        return $arr;
    }
    /**
     * 方法: numrows
     * 功能: 统计结果集中记录数
     * 参数: $result资源标识符
     * 说明: 统计行数
     */
    public function numrows($result) {
        return mysql_num_rows($result);
    }
    /**
     * 方法: numfields
     * 功能: 统计结果集中字段数
     * 参数: $result资源标识符
     * 说明: 统计字段数
     */
    public function numfields($result) {
        return mysql_num_fields($result);
    }
    /**
     * 方法: affectedrows
     * 功能: 取得前一次mysql操作所影响的记录行数
     * 参数: 无
     * 说明: 取得前一次mysql操作所影响的记录行数
     */
    public function affectedrows() {
        return mysql_affected_rows($this->link);
    }
    /**
     * 方法: version
     * 功能: 取得mysql版本
     * 参数: 无
     * 说明: 取得当前数据库服务器mysql的版本
     */
    public function version() {
        return mysql_get_server_info();
    }
    /**
     * 方法: insertid
     * 功能: 取得上一步insert操作产生的id
     * 参数: 无
     * 说明: 取得上一步insert操作产生的自增字段id
     */
    public function insertid() {
        return mysql_insert_id($this->link);
    }
    /**
     * 方法: close
     * 功能: 关闭连接
     * 参数: 无
     * 说明: 关闭非永久数据库连接
     */
    private function close() {
        mysql_close($this->link);
    }
    /**
     * 方法: error
     * 功能: 提示错误
     * 参数: $err_msg
     * 说明: 对给出的错误提示内容给予echo
     */
    private function error($err_msg = "") {
        if ( $err_msg == "" ) {
            echo "errno: " . mysql_errno . "</br>";
            echo "error: " . mysql_error . "</br>";
        } else {
            echo $err_msg;
        }
    }
    /**
     * 方法: __destruct
     * 功能: 析构函数
     * 参数: 无
     * 说明: 释放类,关闭连接
     */
    public function __destruct() {
        $this->close();
    }
}
?>
