<?php
class Printt {
    public static function printTpl($tplName, $subArr) {
        include_once("tpl/" . $tplName);
    }
    public static function printTplHeader($name) {
        Printt::printTpl("header.html", array("title" => $name . " | cms", "cssName" => $name . ".css", "pgName" => "pg_" . $name ));
    }
    public static function printTplFooter($name) {
        Printt::printTpl("footer.html", array("jsName" => $name . ".js" ));
    }
    public static function printTplAll($name) {
        Printt::printTplHeader($name);
        Printt::printTpl($name . ".html", "");
        Printt::printTplFooter($name);
    }
}
?>
