<?php
/**
 * 类名: Printt
 * 功能: 打印模版文件
 * 属性: 无
 * 方法: printTpl, printTplHeader, printTplFooter
 * 说明: 打印tpl目录下的*.html模版文件，其实是include php文件，static不需要实例化
 */
class Printt {
    /**
     * 方法: printTpl
     * 功能: 打印模版文件
     * 参数: $tplName, $subArr
     * 说明: $tplName不用包含后缀，自动添加.html后缀
     *       $subArr参数以数组形式传入，替换模版文件中的值
     */
    public static function printTpl($tplName, $subArr) {
        include_once("tpl/" . $tplName . ".html");
    }
    /**
     * 方法: printTplHeader
     * 功能: 打印标准头部模版
     * 参数: $name
     * 说明: 包含title,css,html标签的id
     */
    public static function printTplHeader($name) {
        Printt::printTpl("header", array("title" => $name . " | cms", "cssName" => $name . ".css", "pgName" => "pg_" . $name ));
    }
    /**
     * 方法: printTplFooter
     * 功能: 打印标准尾部模版
     * 参数: $name
     * 说明: 包含js
     */
    public static function printTplFooter($name) {
        Printt::printTpl("footer", array("jsName" => $name . ".js"));
    }
}
?>
