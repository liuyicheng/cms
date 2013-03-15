<?php
/**
 * 类名: Keepin
 * 功能: 处理登录的session
 * 属性: 无
 * 方法: start, in, out, isIn, isSignPage, goto_, end
 * 说明: 用在init.php中的是否登录检测，static不需要实例化
 */
class Keepin {
    /**
     * 方法: start
     * 功能: 开启session
     * 参数: 无
     * 说明: 重复开启不要紧
     */
    public static function start() {
        session_start();
    }
    /**
     * 方法: in
     * 功能: 写入登录信息
     * 参数: $userID
     * 说明: 将$userID写入session
     */
    public static function in($userID) {
        $_SESSION["user_ID"] = $userID;
    }
    /**
     * 方法: out
     * 功能: 清除登录信息
     * 参数: 无
     * 说明: 清除session中的user_ID
     */
    public static function out() {
        unset($_SESSION["user_ID"]);
    }
    /**
     * 方法: isIn
     * 功能: 判断是否已登录
     * 参数: 无
     * 说明: 通过检测session中的user_ID是否设置来判断是否登录
     */
    public static function isIn() {
        return isset($_SESSION["user_ID"]);
    }
    /**
     * 方法: getID
     * 功能: 获取用户ID
     * 参数: 无
     * 说明: 登录后才有ID
     */
    public static function getID() {
        return $_SESSION["user_ID"];
    }
    /**
     * 方法: isSignPage
     * 功能: 判断是否是登录页面
     * 参数: 无
     * 说明: 通过查询地址中是否有sign字眼判断是否是登录页面
     *       TODO 可能有bug，是否有更好的方法？
     */
    public static function isSignPage() {
        return strpos($_SERVER["PHP_SELF"], "sign");
    }
    /**
     * 方法: goto_
     * 功能: 跳转页面
     * 参数: $url
     * 说明: 跳转到指定url
     */
    public static function goto_($url) {
    // goto 是保留字，不能使用，故在其后加了下划线，以后都用这个规范
        header("Location: " . $url);
    }
    /**
     * 方法: end
     * 功能: 销毁session
     * 参数: 无
     * 说明: 注意会销毁所有session，与session_start对应
     */
    public static function end() {
        session_destroy();
    }
}
?>
