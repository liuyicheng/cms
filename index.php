<?php
/**
 * 主页面，显示搜索框（上），搜索结果列表（左），代码页面（右）
 */
include_once("init.php");
Printt::printTplHeader("index");
Printt::printTpl("sidebar", "");
Printt::printTpl("search", "");
Printt::printTpl("main", "");
Printt::printTpl("index", "");
Printt::printTplFooter("index");
?>
